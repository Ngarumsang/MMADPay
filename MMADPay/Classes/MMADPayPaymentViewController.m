//
//  MMADPayPaymentViewController.m
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import "MMADPayPaymentViewController.h"
#import "MMADPayConstants.h"
#import "MMADPayWebserviceHandler.h"
#import "MMADPayCreatePostData.h"
#import "MMADPayUtils.h"
#import "MMADPayPaymentManager.h"

@interface MMADPayPaymentViewController ()<UIWebViewDelegate, UIScrollViewDelegate>
{
    UIWebView *webView;
    NSURLRequest *nsurlRequestData;
}
@property NSData *httpFormRequestData;
@end

@implementation MMADPayPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = PROCESSING_TITLE;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *backAction = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backAction;
    [self initializePaymentProcess];
}

- (void)backAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:WARNING message:CANCEL_TRANSACTION preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:YES_ACTION style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:yesAction];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:NO_ACTION style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:noAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
    
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initializePaymentProcess {
    MMADPayCreatePostData *createData = [MMADPayCreatePostData new];
    _httpFormRequestData = [createData createPostDataFromPaymentModel:_paramModel];
    MMADPayWebserviceHandler *serviceHandler = [MMADPayWebserviceHandler new];
    
    NSString *urlString;
    
    if ([[[MMADPayPaymentManager sharedInstance]environmentMode] isEqual:MMADPAY_ENVIRONMENT_PRODUCTION]) {
        urlString = MMADPAY_URL_PRODUCTION;
    } else {
        urlString = MMADPAY_URL_TEST;
    }
    [serviceHandler createRequest:urlString paramaters:_httpFormRequestData completionHandler:^(id requestData) {
        nsurlRequestData = requestData;
        [self createWebView];
    }];
    
    
   
    
}

- (void)createWebView {
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    [webView sizeToFit];
    webView.delegate = self;
    [webView setMultipleTouchEnabled:YES];
    [self.view addSubview:webView];
    [webView loadRequest:nsurlRequestData];
    [[MMADPayUtils sharedInstance]showActivity:self];
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[[request URL] absoluteString] hasPrefix:@"ios:"]) {
       
        // Call the given selector
        [self performSelector:@selector(webToNativeCall)];
        // Cancel the location change
        return NO;
    }
    return YES;
}

// Call back method
// Callback handler Method
// On click of done button below method will be invoked
- (void)webToNativeCall
{
    // getText() javascript code will be executed
    NSString *returnvalue =  [webView stringByEvaluatingJavaScriptFromString:@"getResponse()"];
    NSData *data = [returnvalue dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:kMMADPayEnablePaymentNotification object:self userInfo:json];
    }];
    
//    if ([[MMADPayPaymentManager sharedInstance]isModal]) {
//        [self dismissViewControllerAnimated:YES completion:^{
//             [[NSNotificationCenter defaultCenter]postNotificationName:kMMADPayEnablePaymentNotification object:self userInfo:json];
//        }];
//    } else {
//        [CATransaction begin];
//        [CATransaction setCompletionBlock:^{
//            // handle completion here
//            [[NSNotificationCenter defaultCenter]postNotificationName:kMMADPayEnablePaymentNotification object:self userInfo:json];
//        }];
//         [self.navigationController popViewControllerAnimated:YES];
//         [CATransaction commit];
//    }
   

   
    

    // I can handle any error or success response here
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MMADPAYLog(@"webViewDidStartLoad");
    MMADPAYLog(@"Request Url:%@",nsurlRequestData.URL.absoluteURL);

    

}



- (void)webViewDidFinishLoad:(UIWebView *)webView {
     [[MMADPayUtils sharedInstance]dismissActivity];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[MMADPayUtils sharedInstance]dismissActivity];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:kMMADPayEnablePaymentNotification object:self userInfo:@{FAILURE_KEY:error.localizedDescription}];
    }];
    
    
    
}


@end

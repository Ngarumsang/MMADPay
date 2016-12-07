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
@import WebKit;

@interface MMADPayPaymentViewController ()<UIWebViewDelegate, UIScrollViewDelegate>
{
    WKWebView *webView;
    NSMutableData *resultData;
    UIActivityIndicatorView *activity;
}
@property NSData *httpFormRequestData;
@end

@implementation MMADPayPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initializePaymentProcess];
      [self subscribeToNotifications];
}
-(void)dealloc{
    [self unsubscribeFromNotifications];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)subscribeToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentResponse:) name:kMMADPayEnablePaymentNotification object:nil];
}

- (void)unsubscribeFromNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initializePaymentProcess {
    MMADPayCreatePostData *createData = [MMADPayCreatePostData new];
    _httpFormRequestData = [createData createPostDataFromPaymentModel:_paramModel];
    MMADPayWebserviceHandler *serviceHandler = [MMADPayWebserviceHandler sharedInstance];
    activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.hidesWhenStopped = YES;
    [self.view addSubview:activity];
    activity.center = self.view.center;
    [activity startAnimating];
    
    [serviceHandler callWebService:MMADPAY_PAYMENT_URL paramaters:_httpFormRequestData completionHandler:^(id responseObject) {
        resultData = [NSMutableData new];
        resultData = responseObject;
        [self createWebView];
    } andErrorcompletionHandler:^(NSError *error) {
         [activity stopAnimating];
        [self.navigationController popViewControllerAnimated:YES];
    }];
 
}

- (void)createWebView {
    
    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    [webView sizeToFit];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    [webView setMultipleTouchEnabled:YES];
     [webView loadData:resultData MIMEType:MMADPAY_MIMETYPE characterEncodingName:MMADPAY_CHARACTERENCODING baseURL:[NSURL URLWithString:MMADPAY_PAYMENT_URL]];
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

- (void)webToNativeCall
{
   [webView evaluateJavaScript:@"getResponse()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
       NSData *data = [[NSString stringWithFormat:@"%@",response ] dataUsingEncoding:NSUTF8StringEncoding];
       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       
       NSLog(@"Json: %@", json);
    }];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    //-- get version and schema from plist
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *urlScheme=[[infoDict valueForKey:@"CFBundleURLTypes"] objectAtIndex:0];
    NSDictionary *vcScheme=[[infoDict valueForKey:@"LSApplicationQueriesSchemes"] objectAtIndex:1];
    
    //--Initialise App
    NSMutableDictionary *initialiseApp = [[NSMutableDictionary alloc]init];
    [initialiseApp setValue:[infoDict objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [initialiseApp setValue:[[urlScheme valueForKey:@"CFBundleURLSchemes" ] objectAtIndex:0] forKey:@"schema"];
    [initialiseApp setValue:vcScheme forKey:@"vcSchema"];
    //initialiseApp[@"statusBarSize"] = @(statusBarSize);
    //--
    
    [activity stopAnimating];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"initialiseApp" object:nil userInfo:initialiseApp];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Error : %@",error);
    NSLog(@"Error : %@",error.localizedDescription) ;
}


@end

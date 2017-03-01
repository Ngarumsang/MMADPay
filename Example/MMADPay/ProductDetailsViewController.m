//
//  ProductDetailsViewController.m
//  MMADPay
//
//  Created by Vashum on 13/12/16.
//  Copyright © 2016 Ngarumsang. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "MMADPayHeader.h"
#import "SuccessViewController.h"

static NSString *salt = @"c789b33898c94702";
static NSString *payId = @"1611241639211002";
static NSString *merchantName = @"Mobile Integration";

@interface ProductDetailsViewController ()
{
    NSDictionary *productInfo;
    UIView *viewBackground;
    SuccessViewController *successViewController;
}

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat price = [_productPrice floatValue]* 100;
    
   
    productInfo = @{@"PAY_ID": payId,
                    @"ORDER_ID": [self getOrderId: @"Test product"],
                    @"TXNTYPE": @"SALE",
                    @"MERCHANTNAME": merchantName,
                    @"AMOUNT": [NSString stringWithFormat:@"%ld",(long)price],
                    @"CURRENCY_CODE": @"356",
                    @"CUST_NAME": @"Demo Name",
                    @"CUST_STREET_ADDRESS1": @"12 9 Square",
                    @"CUST_ZIP": @"560029",
                    @"CUST_EMAIL": @"nvashum07@gmail.com",
                    @"CUST_PHONE": @"8553070153",
                    @"RETURN_URL": @"http://www.demo.mmadpay.com/crm/jsp/iosResponse.jsp",
                    @"PRODUCT_DESC":_productName,
                    @"SALT_KEY": salt,
                    @"ENVIRONMENT_MODE": MMADPAY_ENVIRONMENT_TEST};
    
    
    
    self.title = _productName;
    self.navigationItem.hidesBackButton = YES;
    _lblPrice.text = [NSString stringWithFormat:@"Rs %@",_productPrice];
    _lblProductName.text = _productName;
    _imageViewProduct.image = _imageProduct;
    _btnBuyNow.layer.cornerRadius = 3.0;
    UIBarButtonItem *backAction = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    backAction.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backAction;
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    [self unsubscribeFromNotifications];
}

- (void)subscribeToNotifications {
    [self unsubscribeFromNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentResponse:) name:kMMADPayEnablePaymentNotification object:nil];
}

- (void)unsubscribeFromNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buyNow:(id)sender {

    MMADPayPaymentManager *paymentManager = [MMADPayPaymentManager sharedInstance];
    [paymentManager processPaymentWithProductInfo:productInfo];
    
    [self subscribeToNotifications];
    
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString*)getOrderId: (NSString*)productName {
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *strippedReplacement = [[[NSString stringWithFormat:@"ORD%f",timeInMiliseconds] componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    return strippedReplacement;
}

- (void)paymentResponse: (NSNotification*)notification {
    NSLog(@"Response Received: %@",notification.userInfo);
    
    NSDictionary *response = notification.userInfo;
    if ([response objectForKey:@"AMOUNT"]) {
        [self showSucessMessage:response];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Transaction failed" message:[NSString stringWithFormat:@"%@",[notification.userInfo objectForKey:@"failureDescription"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

- (void)showSucessMessage: (NSDictionary *)responseObject {
    
    viewBackground = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+64)];
    viewBackground.backgroundColor = [UIColor blackColor];
    viewBackground.alpha = 0.5;
    [self.navigationController.view addSubview:viewBackground];
    
    successViewController = [[SuccessViewController alloc]initWithNibName:@"SuccessView" bundle:nil];
    successViewController.view.backgroundColor =[UIColor clearColor];
    [self displayContentController: successViewController];
    
    [successViewController.btnOk addTarget:self action:@selector(dismissSuccessMessage) forControlEvents:UIControlEventTouchUpInside];
    successViewController.btnOk.layer.cornerRadius = 3.0;
    successViewController.lblTransactionId.text = [responseObject objectForKey:@"TXN_ID"];
    
    NSInteger amount = [[responseObject objectForKey:@"AMOUNT"] integerValue];
    amount = amount/100;
    successViewController.lblPrice.text = [NSString stringWithFormat:@"Rs %ld",(long)amount];
    successViewController.lblStatus.text = [responseObject objectForKey:@"STATUS"];
    successViewController.lblMessage.text = [responseObject objectForKey:@"PG_TXN_MESSAGE"];
    successViewController.lblTime.text = [responseObject objectForKey:@"RESPONSE_DATE_TIME"];
    successViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    successViewController.viewContainer.layer.cornerRadius = 3.0;
    [UIView animateWithDuration:0.3 animations:^{
        successViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        successViewController.view.center = self.view.center;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    
}
- (void)dismissSuccessMessage {
    
    [UIView animateWithDuration:0.3 animations:^{
        successViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        successViewController.view.center = self.view.center;
        
        
    } completion:^(BOOL finished) {
        [successViewController willMoveToParentViewController:nil];
        [successViewController.view removeFromSuperview];
        [successViewController removeFromParentViewController];
        [viewBackground removeFromSuperview];
        viewBackground = nil;
        successViewController = nil;
    }];
    
}
- (void) displayContentController: (UIViewController*) content;
{
    [self.navigationController addChildViewController:content];
    content.view.frame = self.view.frame;
    [self.navigationController.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

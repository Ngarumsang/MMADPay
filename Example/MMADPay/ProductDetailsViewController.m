//
//  ProductDetailsViewController.m
//  MMADPay
//
//  Created by Vashum on 13/12/16.
//  Copyright © 2016 Ngarumsang. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "MMADPayHeader.h"


static NSString *salt = @"c789b33898c94702";
static NSString *payId = @"1611241639211002";
static NSString *merchantName = @"Mobile Integration";

@interface ProductDetailsViewController ()
{
    NSDictionary *productInfo;
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
                    @"PRODUCT_DESC":_productName};
    
    
    
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
    
    MMADPayHashes *hash = [MMADPayHashes new];
    
    MMADPayPaymentModelParams *params = [MMADPayPaymentModelParams new];
    params.payID = payId;
    params.orderID = [productInfo objectForKey:@"ORDER_ID"];
    params.taxType = [productInfo objectForKey:@"TXNTYPE"];
    params.merchantName = [productInfo objectForKey:@"MERCHANTNAME"];
    params.amount = [productInfo objectForKey:@"AMOUNT"];
    params.currencyCode = [productInfo objectForKey:@"CURRENCY_CODE"];
    params.customerName = [productInfo objectForKey:@"CUST_NAME"];
    params.customerStreeAddress1 = [productInfo objectForKey:@"CUST_STREET_ADDRESS1"];
    params.customerZip = [productInfo objectForKey:@"CUST_ZIP"];
    params.customerEmail = [productInfo objectForKey:@"CUST_EMAIL"];
    params.customerPhone = [productInfo objectForKey:@"CUST_PHONE"];
    params.returnURL = [productInfo objectForKey:@"RETURN_URL"];
    params.productDescription = [productInfo objectForKey:@"PRODUCT_DESC"];
    params.hashKey = [hash getPayHashProductInfo:productInfo withSalt:salt];
    
    MMADPayPaymentViewController *paymentVC = [MMADPayPaymentViewController new];
    paymentVC.paramModel = params;
    [self.navigationController pushViewController:paymentVC animated:YES];
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Received response" message:[NSString stringWithFormat:@"%@",notification.userInfo] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil]; 
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

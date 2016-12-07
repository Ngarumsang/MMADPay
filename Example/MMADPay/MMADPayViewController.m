//
//  MMADPayViewController.m
//  MMADPay
//
//  Created by Ngarumsang on 12/07/2016.
//  Copyright (c) 2016 Ngarumsang. All rights reserved.
//

#import "MMADPayViewController.h"
#import "MMADPayConstants.h"
#import "MMADPayPaymentViewController.h"
#import "MMADPayPaymentModelParams.h"
#include <CommonCrypto/CommonDigest.h>
#import "InfoTableViewCell.h"



static NSString *cellId = @"InfoTableViewCell";
static NSString *salt = @"c789b33898c94702";
static NSString *payId = @"1611241639211002";
static NSString *merchantName = @"Mobile Integration";

@interface MMADPayViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSDictionary *productInfo;
    NSArray *keys;
    NSMutableArray *values;
    NSMutableString *hashInfoString;
}
@property (weak, nonatomic) IBOutlet UIButton *btnProceed;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MMADPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MMADPay Demo";
    self.automaticallyAdjustsScrollViewInsets = false;
    
    productInfo = @{@"PAY_ID": payId,
                    @"ORDER_ID": [self getOrderId: @"Test product"],
                    @"TXNTYPE": @"SALE",
                    @"MERCHANTNAME": merchantName,
                    @"AMOUNT": @"10000",
                    @"CURRENCY_CODE": @"356",
                    @"CUST_NAME": @"Demo Name",
                    @"CUST_STREET_ADDRESS1": @"12 9 Square",
                    @"CUST_ZIP": @"560029",
                    @"CUST_EMAIL": @"nvashum07@gmail.com",
                    @"CUST_PHONE": @"8553070153",
                    @"RETURN_URL": @"http://www.demo.mmadpay.com/crm/jsp/response.jsp",
                    @"PRODUCT_DESC":@"Test product"};
    
    values = [NSMutableArray new];
    hashInfoString = [NSMutableString new];
    keys = [[productInfo allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i = 0; i < keys.count; i++) {
        [values addObject: [productInfo objectForKey:[keys objectAtIndex:i]]];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate, UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return keys.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.lblKey.text = [keys objectAtIndex:indexPath.row];
    cell.tfValue.text = [values objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)btnProceedAction:(id)sender {
    for (int i = 0; i < keys.count; i++) {
        [hashInfoString appendString:[NSString stringWithFormat:@"%@=%@",[keys objectAtIndex:i],[values objectAtIndex:i]]];
        if (i < keys.count - 1) {
            [hashInfoString appendString:@"~"];
        }
        
    }
    [hashInfoString appendString:salt];
    
    NSString *hashKey = [[self sha256:[NSString stringWithFormat:@"{%@}",hashInfoString]] uppercaseString];
 
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
    params.hashKey = hashKey;
    
//    NSBundle *podBundle = [NSBundle bundleForClass:[MMADPayPaymentViewController class]];
//    UIStoryboard *paymentStory = [UIStoryboard storyboardWithName:MMADPAY_PAYMENT_OPTION_VIEWCONTROLLER bundle:podBundle];
//    MMADPayPaymentViewController *paymentVC = [paymentStory instantiateViewControllerWithIdentifier:@"MMADPayPaymentViewController"];
    MMADPayPaymentViewController *paymentVC = [MMADPayPaymentViewController new];
    paymentVC.paramModel = params;
    [self.navigationController pushViewController:paymentVC animated:YES];
    
}


-(NSString*) sha256:(NSString *)clear{
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

- (NSString*)getOrderId: (NSString*)productName {
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *strippedReplacement = [[[NSString stringWithFormat:@"ORD%f",timeInMiliseconds] componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    return strippedReplacement;
}


@end

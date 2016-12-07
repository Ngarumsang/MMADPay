//
//  MMADPayCreatePostData.m
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import "MMADPayCreatePostData.h"

@implementation MMADPayCreatePostData
- (NSData *)createPostDataFromPaymentModel: (MMADPayPaymentModelParams*)params {
    
    NSMutableString *productInfoString = [NSMutableString new];
    [productInfoString appendFormat:[NSString stringWithFormat:@"PAY_ID=%@&",params.payID]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"MERCHANTNAME=%@&",params.merchantName]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"ORDER_ID=%@&",params.orderID]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"AMOUNT=%@&",params.amount]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"TXNTYPE=%@&",params.taxType]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"CUST_NAME=%@&",params.customerName]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"CUST_STREET_ADDRESS1=%@&",params.customerName]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"CUST_ZIP=%@&",params.customerZip]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"CUST_PHONE=%@&",params.customerPhone]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"CUST_EMAIL=%@&",params.customerEmail]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"PRODUCT_DESC=%@&",params.productDescription]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"CURRENCY_CODE=%@&",params.currencyCode]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"RETURN_URL=%@&",params.returnURL]];
    [productInfoString appendFormat:[NSString stringWithFormat:@"HASH=%@",params.hashKey]];
    
    NSLog(@"Post Params: %@", productInfoString);
    
    return [productInfoString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
   
}
@end

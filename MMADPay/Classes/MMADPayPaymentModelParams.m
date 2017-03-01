//
//  MMADPayPaymentModelParams.m
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import "MMADPayPaymentModelParams.h"
#import "MMADPayConstants.h"

static MMADPayPaymentModelParams *params = nil;

@implementation MMADPayPaymentModelParams
+ (MMADPayPaymentModelParams*)initialiseParametersWithPostData: (NSDictionary*)productInfo {
    params = [MMADPayPaymentModelParams new];
    params.payID = [productInfo objectForKey:@"PAY_ID"];
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
    params.hashKey = [productInfo objectForKey:HASH_KEY];
    return params;
}

@end

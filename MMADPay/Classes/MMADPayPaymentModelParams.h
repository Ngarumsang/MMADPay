//
//  MMADPayPaymentModelParams.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>
#import "MMADPayHashes.h"

@interface MMADPayPaymentModelParams : NSObject

// MMADPay Gateway parameters
@property (strong, nonatomic) NSString *payID;
@property (strong, nonatomic) NSString *orderID;
@property (strong, nonatomic) NSString *merchantName;
@property (strong, nonatomic) NSString *returnURL;
@property (strong, nonatomic) NSString *taxType;
@property (strong, nonatomic) NSString *hashKey;
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *customerFirstName;
@property (strong, nonatomic) NSString *customerLastName;
@property (strong, nonatomic) NSString *customerStreeAddress1;
@property (strong, nonatomic) NSString *customerCity;
@property (strong, nonatomic) NSString *customerState;
@property (strong, nonatomic) NSString *customerCountry;
@property (strong, nonatomic) NSString *customerZip;
@property (strong, nonatomic) NSString *customerPhone;
@property (strong, nonatomic) NSString *customerEmail;
@property (strong, nonatomic) NSString *custShippingLastName;
@property (strong, nonatomic) NSString *customerShippingFirstName;
@property (strong, nonatomic) NSString *customerShippingName;
@property (strong, nonatomic) NSString *customerShippingStreetAddress1;
@property (strong, nonatomic) NSString *customerShippingStreetAddress2;
@property (strong, nonatomic) NSString *customerShippingCity;
@property (strong, nonatomic) NSString *customerShippingState;
@property (strong, nonatomic) NSString *customerShippingCountry;
@property (strong, nonatomic) NSString *customerShippingZip;
@property (strong, nonatomic) NSString *customerShippingPhone;
@property (strong, nonatomic) NSString *amount;
@property (strong, nonatomic) NSString *currencyCode;
@property (strong, nonatomic) NSString *productDescription;

@end

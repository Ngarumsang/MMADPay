//
//  MMADPayConstants.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>



#ifdef DEBUG
#define MMADPAYLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define MMADPAYLog(...)
#endif


#define MMADPAY_CONTENTVALUE @"application/x-www-form-urlencoded"
#define MMADPAY_CONTENTTYPE @"Content-Type"
#define MMADPAY_HTTPMETHOD  @"POST"

#define MMADPAY_CHARACTERENCODING @"utf-8"
#define MMADPAY_MIMETYPE @"text/html"
#define WARNING @"WARNING"
#define CANCEL_TRANSACTION @"Are you sure you want to cancel transaction?"
#define YES_ACTION @"YES"
#define NO_ACTION @"NO"
#define BACK_ICONNAME @"left-arrow.png"
#define PROCESSING_TITLE @"Processing payment..."
#define FAILURE_KEY @"failureDescription"
#define TRANSACTION_FAILED @"Transaction failed"

#define ENVIRONMENT_MODE @"ENVIRONMENT_MODE"
#define SALT_KEY @"SALT_KEY"
#define HASH_KEY @"HASH_KEY"
#pragma mark - Server URLs

#define MMADPAY_URL_TEST @"http://www.demo.mmadpay.com/crm/jsp/paymentrequest"
#define MMADPAY_URL_PRODUCTION @"http://www.demo.mmadpay.com/crm/jsp/paymentrequest"

#pragma mark - Server environment

#define MMADPAY_ENVIRONMENT_PRODUCTION  @"Production"
#define MMADPAY_ENVIRONMENT_TEST        @"Test"



extern NSString * const kMMADPayEnablePaymentNotification;

@interface MMADPayConstants : NSObject

@end

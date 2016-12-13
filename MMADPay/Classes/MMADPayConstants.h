//
//  MMADPayConstants.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>

#define MMADPAY_CONTENTVALUE @"application/x-www-form-urlencoded"
#define MMADPAY_CONTENTTYPE @"Content-Type"
#define MMADPAY_HTTPMETHOD  @"POST"
#define MMADPAY_PAYMENT_URL @"http://www.demo.mmadpay.com/crm/jsp/paymentrequest"
#define MMADPAY_CHARACTERENCODING @"utf-8"
#define MMADPAY_MIMETYPE @"text/html"
#define WARNING @"WARNING"
#define CANCEL_TRANSACTION @"Are you sure you want to cancel transaction?"
#define YES_ACTION @"YES"
#define NO_ACTION @"NO"
#define BACK_ICONNAME @"left-arrow.png"
#define PROCESSING_TITLE @"Processing payment..."

extern NSString * const kMMADPayEnablePaymentNotification;
@interface MMADPayConstants : NSObject

@end

//
//  MMADPayPaymentManager.h
//  Pods
//
//  Created by Vashum on 19/12/16.
//
//

#import <Foundation/Foundation.h>

@interface MMADPayPaymentManager : NSObject
+ (instancetype)sharedInstance;
-(void)processPaymentWithProductInfo: (NSDictionary*)transactionData;

@property (nonatomic, strong) NSString *environmentMode;
@end

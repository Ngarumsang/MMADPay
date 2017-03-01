//
//  MMADPayPaymentManager.m
//  Pods
//
//  Created by Vashum on 19/12/16.
//
//

#import "MMADPayPaymentManager.h"
#import "MMADPayConstants.h"
#import "MMADPayCreatePostData.h"
#import "MMADPayHashes.h"
#import "MMADPayPaymentViewController.h"

@interface MMADPayPaymentManager ()
{
    NSMutableDictionary *hashParams;
    
}


@end

@implementation MMADPayPaymentManager

static MMADPayPaymentManager *payMentManager = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        payMentManager = [[MMADPayPaymentManager alloc]init];
    });
    return payMentManager;
}

-(void)processPaymentWithProductInfo: (NSDictionary*)transactionData {
    
    hashParams = [transactionData mutableCopy];
    _environmentMode = [transactionData objectForKey:ENVIRONMENT_MODE];
    NSString *salt = [transactionData objectForKey:SALT_KEY];
    [hashParams removeObjectForKey:SALT_KEY];
    [hashParams removeObjectForKey:ENVIRONMENT_MODE];
    MMADPayHashes *hash = [MMADPayHashes new];
    [hashParams setObject:[hash getPayHashProductInfo:hashParams withSalt:salt] forKey:HASH_KEY];
    MMADPayPaymentModelParams *params = [MMADPayPaymentModelParams initialiseParametersWithPostData:hashParams];
    
    
    MMADPayPaymentViewController *paymentVC = [MMADPayPaymentViewController new];
    paymentVC.paramModel = params;
    
    UIViewController *topViewContoller = [self getTopViewController];
   
    UINavigationController *tempNavigationController = [[UINavigationController alloc]initWithRootViewController:paymentVC];
    [topViewContoller presentViewController:tempNavigationController animated:YES completion:nil];
   
    
}

- (UIViewController*) getTopViewController {
    
    return  [UIApplication sharedApplication].keyWindow.rootViewController;
}



@end


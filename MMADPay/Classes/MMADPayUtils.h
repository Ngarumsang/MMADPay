//
//  MMADPayUtils.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MMADPayUtils : NSObject
+(instancetype)sharedInstance;
- (void)showActivity: (UIViewController *)viewController;
- (void)dismissActivity;

@end

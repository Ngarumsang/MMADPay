//
//  MMADPayCreatePostData.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>
#import "MMADPayPaymentModelParams.h"

@interface MMADPayCreatePostData : NSObject

- (NSData *)createPostDataFromPaymentModel: (MMADPayPaymentModelParams*)params;

@end

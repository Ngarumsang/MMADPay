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

///-------------------------------
/// @name HTTP form data Handling
///-------------------------------

/**
    Create http post data and return in NSData format.
 @param params All the mandatory field should not be left blank
*/
- (NSData *)createPostDataFromPaymentModel: (MMADPayPaymentModelParams*)params;

@end

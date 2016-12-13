//
//  MMADPayHashes.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>

@interface MMADPayHashes : NSObject
- (NSString*)getPayHashProductInfo: (NSDictionary *)productInfo withSalt: (NSString *)saltKey;
@end

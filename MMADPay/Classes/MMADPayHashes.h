//
//  MMADPayHashes.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>

@interface MMADPayHashes : NSObject

///-------------------------------
/// @name Genereate Hash using the request information
///-------------------------------

/**
 Create Hash key and return as string.
 */

- (NSString*)getPayHashProductInfo: (NSDictionary *)productInfo withSalt: (NSString *)saltKey;
@end

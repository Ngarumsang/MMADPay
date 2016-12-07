//
//  MMADPayWebserviceHandler.h
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import <Foundation/Foundation.h>

@class MMADPayWebserviceHandler;
//Custom block to handle success and failure session request
typedef void (^MMADPayWebserviceSuccessBlock)(id responseObject);
typedef void (^MMADPayWebserviceFailureBlock)(NSError *error);

@interface MMADPayWebserviceHandler : NSObject

+(instancetype)sharedInstance;

- (void)callWebService:(NSString *)urlString
            paramaters:(NSData *)paramaters
     completionHandler:(MMADPayWebserviceSuccessBlock)success
andErrorcompletionHandler:(MMADPayWebserviceFailureBlock)failure;

@end

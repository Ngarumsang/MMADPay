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
typedef void (^MMADPayWebserviceRequestData)(id requestData);

@interface MMADPayWebserviceHandler : NSObject


- (void)createRequest:(NSString *)urlString
            paramaters:(NSData *)paramaters
     completionHandler:(MMADPayWebserviceRequestData)requestData;

@end

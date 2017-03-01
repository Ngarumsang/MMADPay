//
//  MMADPayWebserviceHandler.m
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import "MMADPayWebserviceHandler.h"
#import "MMADPayConstants.h"


@implementation MMADPayWebserviceHandler


- (void)createRequest:(NSString *)urlString
           paramaters:(NSData *)paramaters
    completionHandler:(MMADPayWebserviceRequestData)requestData{
    NSURL * url = [NSURL URLWithString:urlString];
    MMADPAYLog(@"post url:%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:30.0];
    
    NSAssert(paramaters,@"Empty parameters!!!");
    [request setHTTPMethod:MMADPAY_HTTPMETHOD];
    [request setValue:MMADPAY_CONTENTVALUE forHTTPHeaderField:MMADPAY_CONTENTTYPE];
    [request setHTTPBody:paramaters];
    requestData(request);
}





@end

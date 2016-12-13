//
//  MMADPayWebserviceHandler.m
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import "MMADPayWebserviceHandler.h"
#import "MMADPayConstants.h"

static MMADPayWebserviceHandler *serviceHandler = nil;

@implementation MMADPayWebserviceHandler

+(instancetype)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        serviceHandler = [[MMADPayWebserviceHandler alloc]init];
    });
    
    return serviceHandler;
}


- (void)callWebService:(NSString *)urlString
            paramaters:(NSData *)paramaters
     completionHandler:(MMADPayWebserviceRequestData)requestData{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:urlString];
    NSLog(@"post url:%@",url);
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

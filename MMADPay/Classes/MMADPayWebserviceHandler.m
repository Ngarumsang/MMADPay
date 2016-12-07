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
     completionHandler:(MMADPayWebserviceSuccessBlock)success
andErrorcompletionHandler:(MMADPayWebserviceFailureBlock)failure{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:urlString];
    NSLog(@"post url:%@",url);
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:30.0];
    
    NSAssert(paramaters,@"Empty parameters!!");
    [request setHTTPMethod:MMADPAY_HTTPMETHOD];
    [request setValue:MMADPAY_CONTENTVALUE forHTTPHeaderField:MMADPAY_CONTENTTYPE];
    [request setHTTPBody:paramaters];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
                
                
            });
        }
        else{
            if (data != nil) {
    
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure(error);
                    });
                }
                else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(data);
                        
                    });
                    
                    
                }
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(error);
                    
                });
                
            }
        }
    }] resume];
}





@end

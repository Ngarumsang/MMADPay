//
//  MMADPayHashes.m
//  Pods
//
//  Created by Vashum on 06/12/16.
//
//

#import "MMADPayHashes.h"
#include <CommonCrypto/CommonDigest.h>



@implementation MMADPayHashes {
    NSMutableArray *values;
    NSMutableArray *keys;
    NSMutableString *hashInfoString;
}

- (NSString*)getPayHashProductInfo: (NSDictionary *)productInfo withSalt: (NSString *)saltKey {
    
    values = [NSMutableArray new];
    hashInfoString = [NSMutableString new];
    keys = [[productInfo allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i = 0; i < keys.count; i++) {
        [values addObject: [productInfo objectForKey:[keys objectAtIndex:i]]];
    }
    
    for (int i = 0; i < keys.count; i++) {
        [hashInfoString appendString:[NSString stringWithFormat:@"%@=%@",[keys objectAtIndex:i],[values objectAtIndex:i]]];
        if (i < keys.count - 1) {
            [hashInfoString appendString:@"~"];
        }
        
    }
    [hashInfoString appendString:saltKey];
    
    NSString *hashKey = [[self sha256:[NSString stringWithFormat:@"{%@}",hashInfoString]] uppercaseString];
    return hashKey;
    
    
}



-(NSString*) sha256:(NSString *)clear{
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}
@end

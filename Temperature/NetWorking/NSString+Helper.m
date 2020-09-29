//
//  NSString+Helper.m
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helper)


- (NSString *)MD5
{
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)sha1{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data 	 = [NSData dataWithBytes:cstr length:self.length];
    
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
	CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
		[output appendFormat:@"%02x", digest[i]];
    }
    
	return output;
}


@end

//
//  NSString+trimMultipleWhitespace.m
//  ValleyForge
//
//  Created by mike on 9/8/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "NSString+trimMultipleWhitespace.h"

@implementation NSString (trimMultipleWhitespace)

- (NSString *)trimMultipleWhitespace {
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\t" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *trimmedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
   
    return trimmedString;
}

@end

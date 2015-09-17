//
//  NSString+Extensions.m
//  ValleyForge
//
//  Created by mike on 9/8/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

- (NSString *)stringByTrimmingTabs {
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\t" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *trimmedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
   
    return trimmedString;
}

- (NSString *)stringByTrimmingLeadingWhitespace {
    NSInteger i = 0;
    
    while ((i < [self length]) && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    
    return [self substringFromIndex:i];
}

- (NSString *)stringByTrimmingTabsAndNewline {
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\t" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *trimmedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
 
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"\n" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *trimmedString2 = [regex2 stringByReplacingMatchesInString:trimmedString options:0 range:NSMakeRange(0, [trimmedString length]) withTemplate:@""];
    
    NSString *trimmedString3 = [trimmedString2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString3;
}
@end

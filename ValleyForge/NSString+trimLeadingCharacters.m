//
//  NSString+trimLeadingCharacters.m
//  ValleyForge
//
//  Created by MHoward2 on 8/19/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "NSString+trimLeadingCharacters.h"

@implementation NSString (trimLeadingCharacters)

- (NSString *)stringByTrimmingLeadingWhitespace {
    NSInteger i = 0;
    
    while ((i < [self length]) && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    
    return [self substringFromIndex:i];
}

@end

//
//  NSString+Extensions.h
//  ValleyForge
//
//  Created by mike on 9/8/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

- (NSString *)stringByTrimmingTabs;
- (NSString *)stringByTrimmingLeadingWhitespace;
- (NSString *)stringByTrimmingTabsAndNewline;

@end

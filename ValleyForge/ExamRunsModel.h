//
//  ExamRunsModel.h
//  ValleyForge
//
//  Created by mike on 9/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamRunsModel : NSObject

- (void)correctAnswer:(NSString *)examName question:(NSString *)question correct:(BOOL)correct;

@end

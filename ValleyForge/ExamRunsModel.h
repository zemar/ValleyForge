//
//  ExamRunsModel.h
//  ValleyForge
//
//  Created by mike on 9/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExamRunItem;

@interface ExamRunsModel : NSObject

- (void)addResult:(NSString *)examName runNumber:(short)runNumber question:(NSString *)question correct:(BOOL)correct;
- (NSArray *)fetchAllResults:(NSString *)predicate;
- (NSArray *)fetchResultsPerExam:(NSString *)examName;
- (NSArray *)fetchResultsPerExamAndRun:(NSString *)examName runNumber:(short)runNumber;
- (ExamRunItem *)fetchResultsQuestion:(NSString *)examName runNumber:(short)runNumber question:(NSString *)question;
- (short)fetchRunNumber:(NSString *)examName;

@end

//
//  QuestionListModel.h
//  ValleyForge
//
//  Created by MHoward2 on 7/25/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@class Exam;

@interface QuestionListModel : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) Exam *exam;

- (NSArray *)storedExams;
- (NSString *)question:(NSInteger)index;
- (NSString *)answer:(NSInteger)index;
- (NSInteger)questionCount;
- (void)addExam:(NSData *)examData;
- (instancetype)initWithContext:(NSManagedObjectContext*)context;

@end

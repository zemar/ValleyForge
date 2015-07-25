//
//  QuestionListModel.m
//  ValleyForge
//
//  Created by MHoward2 on 7/25/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListModel.h"
#import "ExamItem.h"

@implementation QuestionListModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        if ( ![self checkForExam] ) {
            [self initializeDefaultExam];
        }
        self.exam = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BOOL)checkForExam {
    // Query CoreData for existing exam
    return false;
}

- (void)initializeDefaultExam {

    NSString *defaultExamFile = @"CitizenshipExam2014";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:defaultExamFile ofType:@"xml"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    parser.delegate = self;
    [parser parse];
    
}

#pragma NSXMLParser Delegate
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"examItem"] ) {
        ExamItem *item = [[ExamItem alloc] init];
        [self.exam addObject:item];
        
    }
    
    if ( [elementName isEqualToString:@"question"] ) {
        ExamItem *item = [self.exam lastObject];
        item.question = @"question1";
    }
    
    if ( [elementName isEqualToString:@"answer"] ) {
        ExamItem *item = [self.exam lastObject];
        item.question = @"answer";
    }
    
}

@end

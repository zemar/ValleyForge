//
//  QuestionListModel.m
//  ValleyForge
//
//  Created by MHoward2 on 7/25/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListModel.h"
#import "ExamItem.h"

@interface QuestionListModel ()

@property NSMutableString *tempElement;

@end

@implementation QuestionListModel

- (instancetype)init {
    self = [super init];


    if (self) {
        self.exam = [[NSMutableArray alloc] init];

        if ( ![self checkForExam] ) {
            [self initializeDefaultExam];
        }
    }
    
    return self;
}

- (BOOL)checkForExam {
    // Query CoreData for existing examß
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

#pragma mark - NSXMLParser Delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ( [elementName isEqualToString:@"examItem"] ) {
        ExamItem *item = [[ExamItem alloc] init];
        [self.exam addObject:item];
        if (!self.tempElement) {
            self.tempElement = [[NSMutableString alloc] init];
        }
        [self.tempElement setString:@""];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.tempElement appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"question"] ) {
        [[self.exam lastObject] setQuestion:self.tempElement];
    }
    
    if ( [elementName isEqualToString:@"answer"] ) {
        [[self.exam lastObject] setAnswer:self.tempElement];
    }
    
    [self.tempElement setString:@""];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse error occured"); // throw exception
}

@end

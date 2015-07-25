//
//  QuestionListModel.h
//  ValleyForge
//
//  Created by MHoward2 on 7/25/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExamItem;

@interface QuestionListModel : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *exam;

@end

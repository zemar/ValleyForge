//
//  QuestionListModel.m
//  ValleyForge
//
//  Created by MHoward2 on 7/25/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import "QuestionListModel.h"

@implementation QuestionListModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        if ( ![self checkForExam] ) {
            [self initializeDefaultExam];
        }
    }
    
    return self;
}

- (BOOL)checkForExam {
    // Query CoreData for existing exam
    return false;
}

- (void)initializeDefaultExam {
    
}

@end

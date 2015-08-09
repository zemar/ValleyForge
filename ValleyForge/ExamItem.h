//
//  ExamItem.h
//  ValleyForge
//
//  Created by mike on 8/2/15.
//  Copyright (c) 2015 X-Tic Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ExamItem : NSManagedObject

@property (nonatomic, strong) NSString *examName;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;

@end

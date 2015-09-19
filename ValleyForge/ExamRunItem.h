//
//  ExamRunItem.h
//  ValleyForge
//
//  Created by mike on 9/18/15.
//  Copyright © 2015 X-Tic Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ExamRunItem: NSManagedObject

@property (nonatomic, strong) NSString *examName;
@property (nonatomic) NSInteger runNumber;
@property (nonatomic, strong) NSString *question;
@property (nonatomic) BOOL correct;

@end

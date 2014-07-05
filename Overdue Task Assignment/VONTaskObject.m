//
//  VONTaskObject.m
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONTaskObject.h"

@implementation VONTaskObject

-(id)init{
    self = [self initWithData:nil];
    return self;
}


- (id)initWithData:(NSDictionary *)data
{
    self =  [super init];
    self.title = [data valueForKey:TASK_TITLE];
    self.description = [data valueForKey:TASK_DESCRIPTION];
    self.isComplete = [[data valueForKey:TASK_COMPLETION] boolValue];
    self.date = [data valueForKey:TASK_DATE];
    
    
    return self;

    
}


@end

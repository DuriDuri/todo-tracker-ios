//
//  VONTaskObject.h
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VONTaskObject : NSObject


@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isComplete;


- (id)initWithData:(NSDictionary *)data;





@end

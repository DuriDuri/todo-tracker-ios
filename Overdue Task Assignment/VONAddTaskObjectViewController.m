//
//  VONAddTaskObjectViewController.m
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONAddTaskObjectViewController.h"
#import "VONTaskObject.h"

@interface VONAddTaskObjectViewController ()

@end

@implementation VONAddTaskObjectViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskDescription.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    VONTaskObject *task = [self createTaskObject];
    [self.delegate didAddTask:task];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.delegate didCancel];
}

#pragma mark -Protocol Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    else{
        return YES;
    }
}



#pragma Helper Methods

-(VONTaskObject *)createTaskObject{
    VONTaskObject *newTaskObject = [[VONTaskObject alloc] init];
    newTaskObject.title = self.taskTitle.text;
    newTaskObject.description = self.taskDescription.text;
    newTaskObject.date =self.taskDate.date;
    newTaskObject.isComplete = NO;
    
    return newTaskObject;
}
@end

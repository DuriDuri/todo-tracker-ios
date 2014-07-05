//
//  VONDetailedTaskObjectViewController.m
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONDetailedTaskObjectViewController.h"

@interface VONDetailedTaskObjectViewController ()

@end

@implementation VONDetailedTaskObjectViewController

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
    
    self.taskTitleDetail.text = self.currentDetailTask.title;
    self.taskDescriptionDetail.text = self.currentDetailTask.description;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.taskDateDetail.text = [formatter stringFromDate: self.currentDetailTask.date];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[VONEditTaskObjectViewController class]]) {
        VONEditTaskObjectViewController *editVC = segue.destinationViewController;
        editVC.editCurrenttask = self.currentDetailTask;
        editVC.delegate = self;
    }
}


- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTaskObjectController" sender:sender];
    
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didUpdateTask{
    self.taskTitleDetail.text = self.currentDetailTask.title;
    self.taskDescriptionDetail.text = self.currentDetailTask.description;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.taskDateDetail.text = [formatter stringFromDate: self.currentDetailTask.date];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTask];
}
@end

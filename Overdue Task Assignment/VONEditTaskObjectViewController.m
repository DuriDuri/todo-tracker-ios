//
//  VONEditTaskObjectViewController.m
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONEditTaskObjectViewController.h"

@interface VONEditTaskObjectViewController ()

@end

@implementation VONEditTaskObjectViewController

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
    
    self.editDescriptionTextField.text = self.editCurrenttask.description;
    self.editTitleTextField.text = self.editCurrenttask.title;
    self.editDate.date = self.editCurrenttask.date;
    
    
    self.editTitleTextField.delegate = self;
    self.editDescriptionTextField.delegate = self;
 
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

- (IBAction)editTaskButtonPressed:(UIButton *)sender {
    
    [self updateTask];
    [self.delegate didUpdateTask];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateTask
{
    self.editCurrenttask.description = self.editDescriptionTextField.text;
    self.editCurrenttask.title = self.editTitleTextField.text;
    self.editCurrenttask.date = self.editDate.date;

}


#pragma mark - UITextFieldDelegate

/* Method is called when the user taps the return key. When this action occurs we tell the textField to dismiss the keyboard. */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.editDescriptionTextField resignFirstResponder];
    [self.editTitleTextField resignFirstResponder];
    return YES;
}



#pragma mark - UITextViewDelegate

/* UITextView Delegate method. This method is triggered when the user types a new character in the textView. */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self.editTitleTextField resignFirstResponder];
        return NO;
    }
    else return YES;
}
@end

//
//  NewNoteViewController.m
//  BlocNotes
//
//  Created by Eddy Chan on 6/26/16.
//  Copyright © 2016 chan-e. All rights reserved.
//

#import "NewNoteViewController.h"
#import "CoreDataStack.h"
#import "Note.h"

@interface NewNoteViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeholderTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation NewNoteViewController

- (IBAction)cancelPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (IBAction)donePressed:(id)sender {
    CoreDataStack *sharedCoreDataStack = [CoreDataStack sharedStack];
    
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                               inManagedObjectContext:sharedCoreDataStack.managedObjectContext];
    note.date = [NSDate date];
    note.body = self.bodyTextView.text;
    
    [sharedCoreDataStack saveContext];
    
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bodyTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderTextLabel.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

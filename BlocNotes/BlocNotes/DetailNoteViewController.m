//
//  DetailNoteViewController.m
//  BlocNotes
//
//  Created by Eddy Chan on 6/26/16.
//  Copyright © 2016 chan-e. All rights reserved.
//

#import "DetailNoteViewController.h"
#import "CoreDataStack.h"
#import "Note.h"

@interface DetailNoteViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeholderTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation DetailNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleTextField.delegate = self;
    self.bodyTextView.delegate = self;
    
    if (self.note != nil) {
        // The note exists which means the user selects it from the notes table view
        
        self.titleTextField.placeholder = nil;
        self.placeholderTextLabel.hidden = YES;
        
        // Show the note details
        self.titleTextField.text = self.note.title;
        self.bodyTextView.text = self.note.body;
    } else {
        // The user presses the "+" button from the notes table view
        
        self.navigationItem.title = @"New Note";
    }
}

- (void)viewDidLayoutSubviews {
    // Remove the paddings in the UITextView (the note's body)
    // So, its text lines up with the text of the UITextField (the note's title)
    CGFloat lineFragmentPadding = self.bodyTextView.textContainer.lineFragmentPadding;
    
    self.bodyTextView.textContainerInset = UIEdgeInsetsMake(0, -lineFragmentPadding,
                                                            0, -lineFragmentPadding);
    
    // Always start the body content from the top
    [self.bodyTextView setContentOffset:CGPointZero animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    CoreDataStack *sharedCoreDataStack = [CoreDataStack sharedStack];
    
    if (self.note != nil) {
        // The note exists which means the user selects it from the notes table view
        
        // Update the note
        self.note.title = self.titleTextField.text;
        self.note.body = self.bodyTextView.text;
    } else {
        // The user presses the "+" button from the notes table view
        
        // Add a new note
        Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                                   inManagedObjectContext:sharedCoreDataStack.managedObjectContext];
        note.date = [NSDate date];
        note.title = self.titleTextField.text;
        note.body = self.bodyTextView.text;
    }
    
    [sharedCoreDataStack saveContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.titleTextField.placeholder = nil;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderTextLabel.hidden = YES;
}

#pragma mark - IBActions

- (IBAction)shareNote:(id)sender {
    NSString *title = self.titleTextField.text;
    NSString *body = self.bodyTextView.text;
    
    NSArray *itemsToShare = @[title, body];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:itemsToShare
                                            applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
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

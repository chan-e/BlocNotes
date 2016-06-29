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

@interface DetailNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation DetailNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bodyTextView.text = self.note.body;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.note.body = self.bodyTextView.text;
    
    CoreDataStack *sharedCoreDataStack = [CoreDataStack sharedStack];
    [sharedCoreDataStack saveContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

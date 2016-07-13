//
//  ShareViewController.m
//  BlocNotesShareExtension
//
//  Created by Eddy Chan on 7/8/16.
//  Copyright © 2016 chan-e. All rights reserved.
//

#import "ShareViewController.h"
#import "CoreDataStack.h"
#import "Note.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    CoreDataStack *sharedCoreDataStack = [CoreDataStack sharedStack];
    
    // Add a new note
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                               inManagedObjectContext:sharedCoreDataStack.managedObjectContext];
    note.date = [NSDate date];
    note.title = @"";
    note.body = self.contentText;
    
    [sharedCoreDataStack saveContext];
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end

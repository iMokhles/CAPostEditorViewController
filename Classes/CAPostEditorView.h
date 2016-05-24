//
//  CAPostEditorView.h
//  ContrAlert
//
//  Created by iMokhles on 10/05/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAPostEditorView : UIView
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) IBOutlet UIButton *postButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *topViewLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomBarView;
@property (strong, nonatomic) IBOutlet UILabel *textCounterLabel;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIView *attachmentsView;
@property (strong, nonatomic) IBOutlet UIImageView *attachmentsImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *attachmentsConstraint;

/**
 actions block
 **/
@property (nonatomic, copy) void (^postButtonBlock)(CAPostEditorView * editorView, UIButton *postButton, NSString *text);
@property (nonatomic, copy) void (^backButtonBlock)(CAPostEditorView * editorView, UIButton *backButton, NSString *text);

@end

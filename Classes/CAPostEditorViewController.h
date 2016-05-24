//
//  CAPostEditorViewController.h
//  ContrAlert
//
//  Created by iMokhles on 10/05/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPostEditorView.h"


@interface CAPostEditorViewController : UIViewController

// editor view
@property (strong, nonatomic) IBOutlet CAPostEditorView *mainEditorView;

/**
 customiztions
 **/

// textview background image ( if needed ) [nil by default]
@property(nonatomic, strong) UIImage *textViewBackgroundImage;

// top right button image [ compose icon by default ]
@property (nonatomic, strong) UIImage *topRightImage;

// top left button image [ arrow icon by default ]
@property (nonatomic, strong) UIImage *topLeftImage;

// textview background color ( if the backgroundImage property is nil ) [purple by default]
@property (nonatomic, strong) UIColor *textViewBackgroundColor;

// textview text color [ black by default ]
@property (nonatomic, strong) UIColor *textViewTextColor;

// title [ edit by default ]
@property (nonatomic, strong) NSString *titleString;

// counter textColor [ lightGray by default ]
@property (nonatomic, strong) UIColor *counterColor;

// main background blur effect [ nil by default ]
@property (nonatomic, assign) UIBlurEffectStyle blurEffect;

// main background color [ gray by default with alpha = 0.9]
@property (nonatomic, strong) UIColor *mainBackgroundColor;
@property (nonatomic, assign) CGFloat mainBackgroundAlpha;

// texview container view top constrait [ 30 by default ]
@property (nonatomic, assign) NSInteger topConstraint;

// texview container view height constrait [ 230 by default ]
@property (nonatomic, assign) NSInteger heightConstraint;

// hide status bar [ NO by default ]
@property (nonatomic, assign) BOOL hideStatusBar;

// top bar background color [purple by default]
@property (nonatomic, strong) UIColor *topBarBackgroundColor;

// bottom bar background color [ clear by default ]
@property (nonatomic, strong) UIColor *bottomBarBackgroundColor;

// editor mode [ NO by default ]
@property (nonatomic, assign) BOOL isEditingMode;

// the important @property ( @"" by default :P )
@property (nonatomic, strong) NSString *postText;

// text maxi length ( 140 by default twitter drugs -.-" )
@property (nonatomic, assign) NSInteger textLimit;

// attachements url ( if nil attachments view won't be visible if not nil will create thumbnail for it)
@property (nonatomic, strong) NSURL *attachmentURL;


// actions blocks
@property (nonatomic, copy) void (^postButtonBlock)(CAPostEditorViewController * editorViewController, UIButton *postButton, NSString *text);
@property (nonatomic, copy) void (^backButtonBlock)(CAPostEditorViewController * editorViewController, UIButton *backButton, NSString *text);
@end

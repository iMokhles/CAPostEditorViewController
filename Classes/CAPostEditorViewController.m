//
//  CAPostEditorViewController.m
//  ContrAlert
//
//  Created by iMokhles on 10/05/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import "CAPostEditorViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define SCREEN_WIDTH_EDITOR (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) : [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT_EDITOR (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width) : [[UIScreen mainScreen] bounds].size.height)
#define IOS_VERSION_LOWER_THAN_8 (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)

@interface NSURLConnection (Background)
+ (void)sendSynchronousRequest:(NSURLRequest *)request inBackgroundWithCompletionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler;
@end
@implementation NSURLConnection (Background)
+ (void)sendSynchronousRequest:(NSURLRequest *)request
inBackgroundWithCompletionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler {
    
    dispatch_async(dispatch_queue_create
                   ("AsynchRequest", NULL), ^{
                       NSURLResponse *response = nil;
                       NSError *error = nil;
                       NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                       
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           handler(response,data,error);
                       });
                   });
}
@end

@interface CAPostEditorViewController () <UITextViewDelegate>

@end

@implementation CAPostEditorViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect tempFrame = self.mainEditorView.frame;
    int width  = SCREEN_WIDTH_EDITOR;
    int height = SCREEN_HEIGHT_EDITOR;
    tempFrame.size.width = width;
    tempFrame.size.height = height;
    [self.mainEditorView setFrame:tempFrame];
    
    // hide status bar
    if (self.hideStatusBar) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    if (self.attachmentURL != nil) {
        [self.mainEditorView.attachmentsView setHidden:NO];
        self.mainEditorView.attachmentsConstraint.constant = 112;
        [self.mainEditorView.mainView updateConstraints];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = self.mainEditorView.attachmentsImageView.bounds;
        [activityIndicator startAnimating];
        [self.mainEditorView.attachmentsImageView addSubview:activityIndicator];
        self.mainEditorView.attachmentsImageView.userInteractionEnabled = NO;
        
        if (![self.attachmentURL  isFileURL]) {
            [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:self.attachmentURL] inBackgroundWithCompletionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                NSString *mime = [response MIMEType];
                if ([mime containsString:@"video"]) {
                    NSLog(@"Video");
                    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:self.attachmentURL options:nil];
                    AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
                    generate1.appliesPreferredTrackTransform = YES;
                    NSError *err = NULL;
                    CMTime time = CMTimeMake(1, 2);
                    CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
                    UIImage *one = [[UIImage alloc] initWithCGImage:oneRef];
                    [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                    [self.mainEditorView.attachmentsImageView setImage:one];
                } else if ([mime containsString:@"audio"]) {
                    NSLog(@"Audio");
                    [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                    [self.mainEditorView.attachmentsImageView setImage:[UIImage imageNamed:@"Audio-icon"]];
                } else if ([mime containsString:@"image"]) {
                    NSLog(@"Image");
                    [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                    [self.mainEditorView.attachmentsImageView setImage:[UIImage imageWithData:data]];
                } else {
                    [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                    [self.mainEditorView.attachmentsImageView setImage:[UIImage imageNamed:@"attachment_data.jpg"]];
                }
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
                self.mainEditorView.attachmentsImageView.userInteractionEnabled = YES;
            }];
        } else {
            NSString *mime = [self MIMEForFileURL:self.attachmentURL];
            if ([mime containsString:@"video"]) {
                NSLog(@"Video");
                AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:self.attachmentURL options:nil];
                AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
                generate1.appliesPreferredTrackTransform = YES;
                NSError *err = NULL;
                CMTime time = CMTimeMake(1, 2);
                CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
                UIImage *one = [[UIImage alloc] initWithCGImage:oneRef];
                [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                [self.mainEditorView.attachmentsImageView setImage:one];
            } else if ([mime containsString:@"audio"]) {
                NSLog(@"Audio");
                [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                [self.mainEditorView.attachmentsImageView setImage:[UIImage imageNamed:@"Audio-icon"]];
            } else if ([mime containsString:@"image"]) {
                NSLog(@"Image");
                [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                [self.mainEditorView.attachmentsImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:self.attachmentURL]]];
            } else {
                [self.mainEditorView.attachmentsView setBackgroundColor:[UIColor clearColor]];
                [self.mainEditorView.attachmentsImageView setImage:[UIImage imageNamed:@"attachment_data.jpg"]];
            }
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            self.mainEditorView.attachmentsImageView.userInteractionEnabled = YES;
        }
    } else if (self.attachmentURL == nil) {
        [self.mainEditorView.attachmentsView setHidden:YES];
        self.mainEditorView.attachmentsConstraint.constant = 8;
        [self.mainEditorView.mainView updateConstraints];
    }
    // update top constrait
    self.mainEditorView.topConstraint.constant = 30;
    self.mainEditorView.heightConstraint.constant = 230;
    [self.view updateConstraints];
    if (self.topConstraint) {
        self.mainEditorView.topConstraint.constant = self.topConstraint;
        [self.view updateConstraints];
    }
    
    if (self.heightConstraint) {
        self.mainEditorView.heightConstraint.constant = self.heightConstraint;
        [self.view updateConstraints];
    }
    
    // text view set text
    [_mainEditorView.textView setText:self.postText];
    
    // text view delegate
    [_mainEditorView.textView setDelegate:self];
    // text view text did change notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTextView) name:UITextViewTextDidChangeNotification object:nil];
    
    // title
    if (self.titleString.length > 0) {
        _mainEditorView.topViewLabel.text = self.titleString;
    } else {
        _mainEditorView.topViewLabel.text = @"Edit";
    }
    
    // editing mode
    if (!self.isEditingMode) {
        [_mainEditorView.postButton setHidden:YES];
        [_mainEditorView.textView setEditable:NO];
    } else {
        [_mainEditorView.textView setKeyboardType:UIKeyboardTypeDefault];
        [_mainEditorView.postButton setHidden:NO];
        [_mainEditorView.textView setEditable:YES];
        [_mainEditorView.textView becomeFirstResponder];
    }
    
    // top right button image
    if (self.topRightImage != nil) {
        [self.mainEditorView.postButton setImage:self.topRightImage forState:UIControlStateNormal];
    } else {
        [self.mainEditorView.postButton setImage:[UIImage imageNamed:@"postIcon"] forState:UIControlStateNormal];
    }
    
    // top left button image
    if (self.topLeftImage != nil) {
        [self.mainEditorView.backButton setImage:self.topLeftImage forState:UIControlStateNormal];
    } else {
        [self.mainEditorView.backButton setImage:[UIImage imageNamed:@"ArrowLeftIcon"] forState:UIControlStateNormal];
    }
    
    // textview background Image
    if (self.textViewBackgroundImage != nil) {
        _mainEditorView.textView.backgroundColor = [UIColor clearColor];
        _mainEditorView.backgroundImageView.image = self.textViewBackgroundImage;
    } else {
        // text view background color
        if (self.textViewBackgroundColor != nil) {
            _mainEditorView.mainView.backgroundColor = self.textViewBackgroundColor;
        }
    }
    
    // text view text color
    if (self.textViewTextColor != nil) {
        _mainEditorView.textView.textColor = self.textViewTextColor;
    } else {
        _mainEditorView.textView.textColor = [UIColor whiteColor];
    }
    
    // top bar background color
    if (self.topBarBackgroundColor != nil) {
        _mainEditorView.topBarView.backgroundColor = self.topBarBackgroundColor;
    }
    
    // top bar background color
    if (self.bottomBarBackgroundColor != nil) {
        _mainEditorView.bottomBarView.backgroundColor = self.bottomBarBackgroundColor;
    } else {
        _mainEditorView.bottomBarView.backgroundColor = [UIColor clearColor];
    }
    
    // counter label text color
    if (self.counterColor != nil) {
        _mainEditorView.textCounterLabel.textColor = self.counterColor;
    } else {
        _mainEditorView.textCounterLabel.textColor = [UIColor lightGrayColor];
    }
    
    // blur
    if (self.blurEffect) {
        UIBlurEffect *blurEffect1;
        blurEffect1 = [UIBlurEffect effectWithStyle:self.blurEffect];
        UIVisualEffectView *visualEffectView;
        visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
        visualEffectView.frame = _mainEditorView.backgroundView.bounds;
        [_mainEditorView.backgroundView insertSubview:visualEffectView atIndex:0];
    }
    
    // main backgroun color
    if (self.mainBackgroundColor != nil) {
        _mainEditorView.backgroundView.backgroundColor = self.mainBackgroundColor;
        if (self.mainBackgroundAlpha) {
            _mainEditorView.backgroundView.alpha = self.mainBackgroundAlpha;
        } else {
            _mainEditorView.backgroundView.alpha = 0.9;
        }
        
    } else {
        _mainEditorView.backgroundView.backgroundColor = [UIColor lightGrayColor];
        _mainEditorView.backgroundView.alpha = 0.9;
    }
    
    [self.mainEditorView setBackButtonBlock:^(CAPostEditorView *view, UIButton *button, NSString *text) {
        [self backButtonTapped:self text:text];
    }];
    [self.mainEditorView setPostButtonBlock:^(CAPostEditorView *view, UIButton *button, NSString *text) {
        [self postButtonTapped:self text:text];
    }];
    [self showAnimated:YES withCompletion:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // start the conter
    [self updateCounterForFirstLoad];
}

- (void)backButtonTapped:(CAPostEditorViewController *)viewController text:(NSString *)string {
    
    // show status bar again ( when finish )
    if (self.hideStatusBar) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
    
    // i didn't check if it's nil or not ( to make your app crash if you forgot to implement it ) as it required
    self.backButtonBlock(self,nil,string);
}

- (void)postButtonTapped:(CAPostEditorViewController *)viewController text:(NSString *)string {
    
    // show status bar again ( when finish )
    if (self.hideStatusBar) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
    
    // editing mode ( in case anything ) [ hack - tweak - any modifications ]
    if (!self.isEditingMode) {
        return;
    }
    // i didn't check if it's nil or not ( to make your app crash if you forgot to implement it ) as it required
    self.postButtonBlock(self,nil,string);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnimated:(BOOL)animated withCompletion:(void (^)(void))completion {
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.20, 1.20, 1.00)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.00)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.00, 1.00, 1.00)]];
    transformAnimation.keyTimes = @[@0.0, @0.5, @1.0];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @0.5;
    opacityAnimation.toValue = @1.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[transformAnimation, opacityAnimation, opacityAnimation];
    animationGroup.duration = 0.2;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    [self.view.layer addAnimation:animationGroup forKey:@"showAlert"];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationGroup.duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        if (completion) {
            completion();
        }
    });
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger len = textView.text.length;
    NSInteger lengthLimit = 140;
    if (self.textLimit) {
        lengthLimit = self.textLimit;
    }
    _mainEditorView.textCounterLabel.text=[NSString stringWithFormat:@"%li",lengthLimit-len];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger lengthLimit = 140;
    if (self.textLimit) {
        lengthLimit = self.textLimit;
    }
    
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            return YES;
        }
    }
    else if([[textView text] length] > lengthLimit)
    {
        return NO;
    }
    return YES;
}

- (void)checkTextView
{
    // Add here your logic to check TextView and decide if they have text
    NSInteger lengthLimit = 140;
    if (self.textLimit) {
        lengthLimit = self.textLimit;
    }
    
    if (_mainEditorView.textView.text.length > lengthLimit) {
        _mainEditorView.textView.text = [_mainEditorView.textView.text substringToIndex:lengthLimit];
    }
    
}

- (void)updateCounterForFirstLoad {
    NSInteger len = _postText.length;
    NSInteger lengthLimit = 140;
    if (self.textLimit) {
        lengthLimit = self.textLimit;
    }
    _mainEditorView.textCounterLabel.text=[NSString stringWithFormat:@"%li",lengthLimit-len];
}

- (NSString *)MIMEForFileURL:(NSURL *)url
{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)url.pathExtension, NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    return (NSString *)CFBridgingRelease(mimeType) ;
}

@end

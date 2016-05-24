//
//  CAPostEditorView.m
//  ContrAlert
//
//  Created by iMokhles on 10/05/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import "CAPostEditorView.h"

@interface CAPostEditorView ()
@end

@implementation CAPostEditorView

- (void)drawRect:(CGRect)rect {
    [self.mainView setClipsToBounds:YES];
    [[self.mainView layer]setCornerRadius:6];
    
    [self.attachmentsView setClipsToBounds:YES];
    [[self.attachmentsView layer]setCornerRadius:8];
}

- (IBAction)postButtonTapped:(id)sender {
    // i didn't check if it's nil or not ( to make your app crash if you forgot to implement it ) as it required
    self.postButtonBlock(self, sender, _textView.text);
}

- (IBAction)backButtonTapped:(id)sender {
    
    // i didn't check if it's nil or not ( to make your app crash if you forgot to implement it ) as it required
    self.backButtonBlock(self, sender, _textView.text);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

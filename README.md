# CAPostEditorViewController

[![Version](https://img.shields.io/cocoapods/v/CAPostEditorViewController.svg?style=flat)](http://cocoadocs.org/docsets/CAPostEditorViewController)
[![License](https://img.shields.io/cocoapods/l/CAPostEditorViewController.svg?style=flat)](http://cocoadocs.org/docsets/CAPostEditorViewController)
[![Platform](https://img.shields.io/cocoapods/p/CAPostEditorViewController.svg?style=flat)](http://cocoadocs.org/docsets/CAPostEditorViewController)

simple compose view controller with a lot of customizations properties

## NO Attachment
<p align="center">
  <img width="320" height="550" src="screenshot.png"/>
</p>

## Audio Attachment
<p align="center">
  <img width="320" height="550" src="screenshot2.png"/>
</p>

## Data Attachment
<p align="center">
  <img width="320" height="550" src="screenshot3.png"/>
</p>

## Usage

CAPostEditorViewControlleravailable through [CocoaPods](http://cocoapods.org). To install
it, add the following line to your Podfile:

    pod "CAPostEditorViewController"
    
or drag the files manually then import it

    #import "CAPostEditorViewController.h"
    

    
## Example

    CAPostEditorViewController *postEditPage = [[CAPostEditorViewController alloc] initWithNibName:@"CAPostEditView" bundle:[NSBundle mainBundle]];
    postEditPage.postText = TEXT_TO_EDIT;
    postEditPage.isEditingMode = YES;
    postEditPage.textLimit = 180;
    postEditPage.attachmentURL = [NSURL URLWithString:@""]; // attachment URL 
    postEditPage.heightConstraint = 300; 
    [postEditPage setBackButtonBlock:^(CAPostEditorViewController *postEditorViewController, UIButton *backButton, NSString *text) {
        NSLog(@"******* %@", text);
        [postEditorViewController.view removeFromSuperview];
    }];
    [postEditPage setPostButtonBlock:^(CAPostEditorViewController *postEditorViewController, UIButton *postButton, NSString *text) {
        NSLog(@"******* %@", text);
        [postEditorViewController.view removeFromSuperview];
    }];
    [self.view addSubview:postEditPage.view];
    
for more customizations properties see ```CAPostEditorViewController.h```

## TODO
- [x] Attachments support



## Author

[Mokhlas Hussein (iMokhles)](https://twitter.com/imokhles), [mokhleshussien@gmail.com](mailto:mokhleshussien@aol.com)


### old code before rewriting
[MFComposeViewController (mfarhand)](https://github.com/mfarhand/MFComposeViewController)

## License

    The MIT License (MIT)
  
    Copyright (c) 2016 Mokhlas Hussein
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

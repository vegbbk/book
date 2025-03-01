//
//	ReaderMainToolbar.h
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#import "UIXToolbarView.h"

@class ReaderMainToolbar;
@class ReaderDocument;

@protocol ReaderMainToolbarDelegate <NSObject>

@required // Delegate protocols

- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar doneButton:(UIButton *)button;
//- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar thumbsButton:(UIButton *)button;
//- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar exportButton:(UIButton *)button;
//- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar printButton:(UIButton *)button;
//- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar emailButton:(UIButton *)button;
//- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar markButton:(UIButton *)button;

@end

@interface ReaderMainToolbar : UIXToolbarView

@property (nonatomic, weak, readwrite) id <ReaderMainToolbarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame document:(ReaderDocument *)document;

- (void)setBookmarkState:(BOOL)state;

- (void)hideToolbar;
- (void)showToolbar;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
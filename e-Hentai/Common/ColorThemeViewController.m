//
//  ColorThemeViewController.m
//  e-Hentai
//
//  Created by 啟倫 陳 on 2014/10/30.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "ColorThemeViewController.h"

@interface ColorThemeViewController ()

@end

@implementation ColorThemeViewController

#pragma mark - instance method

- (void)changeToColor:(NSString *)colorString {
    
    //把字串轉顏色
    SEL selector = NSSelectorFromString(colorString);
    NSMethodSignature *signature = [UIColor methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:[UIColor class]];
    [invocation setSelector:selector];
    [invocation invoke];
    __unsafe_unretained UIColor *returnColor;
    [invocation getReturnValue:&returnColor];
    
    //換顏色
    NSArray *colorFriends = [NSArray arrayOfColorsWithColorScheme:ColorSchemeAnalogous for:returnColor flatScheme:YES];
    NSUInteger firstColorIndex = [colorFriends indexOfObject:[colorFriends firstObject]];
    NSUInteger lastColorIndex = [colorFriends indexOfObject:[colorFriends lastObject]];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:self.view.bounds andColors:@[colorFriends[firstColorIndex], colorFriends[lastColorIndex]]];
}

#pragma mark - Configuring the View Rotation Settings

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - private

//本來 settitle 是設定 navigation title 上面的字, 這邊把他轉換成用漂亮的字體秀
- (void)setTitle:(NSString *)title {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    UIColor *textColor = [UIColor flatBlackColor];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : textColor, NSFontAttributeName : font, NSTextEffectAttributeName : NSTextEffectLetterpressStyle };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    UILabel *titleLabel = [UILabel new];
    titleLabel.attributedText = attributedString;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeToColor:[HentaiSettingManager themeColorString]];
}

@end

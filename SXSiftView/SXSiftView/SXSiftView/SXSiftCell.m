//
//  SXSiftCell.m
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import "SXSiftCell.h"

@interface SXSiftCell ()

@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation SXSiftCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.textLabel];
        
        [self loadDefaultConfigure];
    }
    return self;
}

#pragma mark - private
- (void)loadDefaultConfigure{
    self.contentView.layer.cornerRadius = CGRectGetHeight(self.contentView.bounds) / 4;
    self.normalTitleColor = [UIColor grayColor];
    self.selectedTitleColor = [UIColor orangeColor];
    self.normalBorderColor = [UIColor lightGrayColor];
    self.selectedBorderColor = [UIColor orangeColor];
    self.contentView.layer.borderColor = [self.normalBorderColor CGColor];
}

- (void)setSelected:(BOOL)selected {
    self.textLabel.textColor = selected ? self.selectedTitleColor : self.normalTitleColor;
    self.contentView.layer.borderColor = selected ? [self.selectedBorderColor CGColor] : [self.normalBorderColor CGColor];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.textLabel.text = title;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    self.textLabel.font = font;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    self.contentView.layer.borderWidth = borderWidth;
}

@end

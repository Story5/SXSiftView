//
//  SXSiftSectionHeader.m
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import "SXSiftSectionHeader.h"

@interface SXSiftSectionHeader ()

@property(nonatomic,strong) UILabel *textLabel;

@end

@implementation SXSiftSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.textLabel.text = title;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    self.textLabel.font = font;
}

@end

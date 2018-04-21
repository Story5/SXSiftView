//
//  SXSiftCell.h
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXSiftCell : UICollectionViewCell

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIFont *font;

@property (nonatomic,strong) UIColor *normalTitleColor;
@property (nonatomic,strong) UIColor *selectedTitleColor;

@property (nonatomic,strong) UIColor *normalBorderColor;
@property (nonatomic,strong) UIColor *selectedBorderColor;

@property (nonatomic,assign) CGFloat borderWidth;

@end

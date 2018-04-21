//
//  SXSiftView.h
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SXSiftView;
@protocol SXSiftViewDelegate <NSObject>

- (void)sxSiftView:(SXSiftView *)sxSiftView didSelectItemAtIndexPath:(NSIndexPath *)indexPath itemDic:(NSDictionary *)dic;

@end

@interface SXSiftView : UIView

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) id<SXSiftViewDelegate>delegate;

@end

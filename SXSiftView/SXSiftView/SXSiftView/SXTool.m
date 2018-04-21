//
//  SXTool.m
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import "SXTool.h"


@implementation SXTool

+ (CGSize)calTextSize:(NSString *)text attributes:(NSDictionary<NSAttributedStringKey, id> *)attributes
{
    CGRect rect = [text boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size;
}

@end

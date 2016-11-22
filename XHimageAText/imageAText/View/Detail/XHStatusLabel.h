//
//  XHStatusLabel.h
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XHStatusHighTextColor [UIColor redColor]
@class DetailFrame;
@interface XHStatusLabel : UIView
/** 富文本 */
@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic,strong) DetailFrame * detailFrame;
@end

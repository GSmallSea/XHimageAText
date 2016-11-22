//
//  DetailFrame.h
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ImageATextCommentModel;
@interface DetailFrame : NSObject

@property (nonatomic,assign) CGRect iconFrame;

@property (nonatomic,assign) CGRect nameFrame;

@property (nonatomic,assign) CGRect timeFrame;

@property (nonatomic,assign) CGRect detailFrame;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) CGRect Frame;

@property (nonatomic,strong) ImageATextCommentModel * commentModel;

@end

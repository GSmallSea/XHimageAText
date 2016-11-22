//
//  DetailFrame.m
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "DetailFrame.h"
#import "ImageATextModel.h"
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

@implementation DetailFrame

- (void)setCommentModel:(ImageATextCommentModel *)commentModel{

    _commentModel = commentModel;
    
    CGFloat iconX = 20;
    CGFloat iconY = 20;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);

    CGFloat  nameX = CGRectGetMaxX(self.iconFrame) + 5;
    CGFloat  nameY = iconY;
    CGFloat  nameW = kScreenWidth - nameX;
    CGFloat  nameH = 13;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);

    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame)+ 5;
    CGFloat timeW = kScreenWidth - timeX - 20;
    CGFloat timeH = 10;
    self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    
    NSMutableString *mutableContent = [NSMutableString stringWithString:_commentModel.text];
    // 记录下所有的人的名字
    NSMutableArray *replyNameArray = [NSMutableArray array];
    
    for (ImageATextCommentModel *replyComment in _commentModel.reply_comments) {
        if (replyComment.text.length && replyComment.user_name.length) {
            NSString *replyName = [NSString stringWithFormat:@"//@%@：", replyComment.user_name];
            [replyNameArray addObject:replyName];
            [mutableContent appendString:replyName];
            [mutableContent appendString:replyComment.text];
        }
    }
    CGFloat detailX = 20;
    CGFloat detailY = CGRectGetMaxY(self.timeFrame)+10;
    CGFloat detailW = kScreenWidth - detailX * 2;
    CGFloat detailH = [self contentSizeWithLabString:mutableContent labelWidth:kScreenWidth - detailX * 2  font:13].height;
    self.detailFrame = CGRectMake(detailX, detailY, detailW, detailH);
    
    self.cellHeight = CGRectGetMaxY(self.detailFrame)+4;
    
    self.Frame = CGRectMake(0, 0, kScreenWidth, self.cellHeight);
}

-(CGSize)contentSizeWithLabString:(NSString *)strTest labelWidth:(CGFloat)width font:(int)font{
    
    CGRect textRect = [strTest boundingRectWithSize:CGSizeMake(width, 9999)
                                            options:NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                            context:nil];
    
    CGSize size = textRect.size;
    
    return size;
    
}
@end

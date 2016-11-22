//
//  DetaiReviewersView.m
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "DetaiReviewersView.h"
#import "IconButton.h"
#import "XHStatusLabel.h"
#import "DetailFrame.h"
#import "ImageATextModel.h"
#import <RegexKitLite.h>
#import "XHLink.h"
@interface DetaiReviewersView ()
@property (nonatomic,weak) IconButton *icon;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel * time;
@property (nonatomic,weak) XHStatusLabel *status;
@end

@implementation DetaiReviewersView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        IconButton *icon = [[IconButton alloc] init];
        [self addSubview:icon];
        self.icon = icon;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = [UIColor lightGrayColor];
        self.nameLabel = nameLabel;
        
        UILabel *time = [[UILabel alloc] init];
        time.font = [UIFont systemFontOfSize:9];
        time.textColor = [UIColor lightGrayColor];
        [self addSubview:time];
        self.time = time;
        
        XHStatusLabel *status = [[XHStatusLabel alloc] init];
        [self addSubview:status];
        self.status = status;
        
    }
    return self;
}
- (void)setDetailFrame:(DetailFrame *)detailFrame{
    
    _detailFrame = detailFrame;
    
    self.icon.frame = _detailFrame.iconFrame;
    self.nameLabel.frame = _detailFrame.nameFrame;
    self.time.frame = _detailFrame.timeFrame;
    self.status.frame = _detailFrame.detailFrame;
    self.status.detailFrame = _detailFrame;
    self.icon.iconURL = _detailFrame.commentModel.user_profile_image_url;
    
    
    self.nameLabel.text = _detailFrame.commentModel.user_name;
    self.time.text = [self updateTimeForTimeInterval:_detailFrame.commentModel.create_time];
    
    
    NSMutableString *mutableContent = [NSMutableString stringWithString:_detailFrame.commentModel.text];
    
    if (_detailFrame.commentModel.reply_comments.count) {
        for (ImageATextCommentModel *replyComment in _detailFrame.commentModel.reply_comments) {
            if (replyComment.text.length && replyComment.user_name.length) {
                NSString *replyName = [NSString stringWithFormat:@"//@%@：", replyComment.user_name];
                [mutableContent appendString:replyName];
                [mutableContent appendString:replyComment.text];
            }
        }
    }
    NSMutableAttributedString *attContent = [[NSMutableAttributedString alloc] initWithString:mutableContent];
    NSString *mentionRegex = @"//@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+";
    [mutableContent enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//        NSLog(@"------- %ld",captureCount);
        
        [attContent addAttribute:NSForegroundColorAttributeName value:XHStatusHighTextColor range:*capturedRanges];
        [attContent addAttribute:XHLinkText value:*capturedStrings range:*capturedRanges];
    }];
    self.status.attributedText = attContent;
    
    
}

- (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval {
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = timeInterval;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    NSInteger minutes = time / 60;
    if (minutes < 60) {
        
        return [NSString stringWithFormat:@"%ld分钟前", minutes];
    }
    // 秒转小时
    NSInteger hours = time / 3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    // 秒转天数
    NSInteger days = time / 3600 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    // 秒转月
    NSInteger months = time / 3600 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    // 秒转年
    NSInteger years = time / 3600 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%ld年前",years];
}
@end

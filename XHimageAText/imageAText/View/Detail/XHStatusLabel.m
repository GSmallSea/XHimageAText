//
//  XHStatusLabel.m
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "XHStatusLabel.h"
#import "XHLink.h"
#import "DetailFrame.h"
#import "ImageATextModel.h"
#define XHLinkBackgroundTag 10000

@interface XHStatusLabel (){
    int i;
}
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) NSMutableArray *links;

@end

@implementation XHStatusLabel

- (void)setDetailFrame:(DetailFrame *)detailFrame{
    _detailFrame = detailFrame;
    
}

- (NSMutableArray *)links
{
    if (!_links) {
        NSMutableArray *links = [NSMutableArray array];
        
        i=0;
        // 搜索所有的链接
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSString *linkText = attrs[XHLinkText];
            //                NSString *linkText2 = attrs[HMLinkText2];
            if (linkText == nil) return;
            NSInteger userID = 0;
            if (_detailFrame.commentModel.reply_comments.count)userID  = _detailFrame.commentModel.reply_comments[i].user_id;
            NSLog(@"%ld",userID);
            // 创建一个链接
            XHLink *link = [[XHLink alloc] init];
            link.text = linkText;
            link.range = range;
            link.user_id = [NSString stringWithFormat:@"%ld",userID];
            i++;
            // 处理矩形框
            NSMutableArray *rects = [NSMutableArray array];
            // 设置选中的字符范围
            self.textView.selectedRange = range;
            // 算出选中的字符范围的边框
            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
                [rects addObject:selectionRect];
            }
            link.rects = rects;
            
            [links addObject:link];
        }];
        
        
        
        self.links = links;
    }
    return _links;
}

/**
 0.查找出所有的链接（用一个数组存放所有的链接）
 
 1.在touchesBegan方法中，根据触摸点找出被点击的链接
 2.在被点击链接的边框范围内添加一个有颜色的背景
 
 3.在touchesEnded或者touchedCancelled方法中，移除所有的链接背景
 */

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UITextView *textView = [[UITextView alloc] init];
        // 不能编辑
        textView.editable = NO;
        // 不能滚动
        textView.scrollEnabled = NO;
        // 设置TextView不能跟用户交互
        textView.userInteractionEnabled = NO;
        // 设置文字的内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        textView.font = [UIFont systemFontOfSize:13];
        self.textView = textView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}

#pragma mark - 公共接口
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
    self.links = nil;
}

#pragma mark - 事件处理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    XHLink *touchingLink = [self touchingLinkWithPoint:point];
    
    // 设置链接选中的背景
    [self showLinkBackground:touchingLink];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    XHLink *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        // 说明手指在某个链接上面抬起来, 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:XHLinkDidSelectedNotification object:nil userInfo:@{XHLinkText : touchingLink.user_id}];
    }
    
    // 相当于触摸被取消
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
}

#pragma mark - 链接背景处理
/**
 *  根据触摸点找出被触摸的链接
 *
 *  @param point 触摸点
 */
- (XHLink *)touchingLinkWithPoint:(CGPoint)point
{
    __block XHLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(XHLink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}

/**
 *  显示链接的背景
 *
 *  @param link 需要显示背景的link
 */
- (void)showLinkBackground:(XHLink *)link
{
    for (UITextSelectionRect *selectionRect in link.rects) {
        UIView *bg = [[UIView alloc] init];
        bg.tag = XHLinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.frame = selectionRect.rect;
        bg.backgroundColor = [UIColor lightGrayColor];
        [self insertSubview:bg atIndex:0];
    }
}

- (void)removeAllLinkBackground
{
    for (UIView *child in self.subviews) {
        if (child.tag == XHLinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  这个方法会返回能够处理事件的控件
 *  这个方法可以用来拦截所有触摸事件
 *  @param point 触摸点
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self touchingLinkWithPoint:point]) {
        return self;
    }
    return nil;
}@end

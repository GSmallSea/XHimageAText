//
//  XHLink.h
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define XHLinkText @"HMLinkText"

#define XHLinkDidSelectedNotification @"XHLinkDidSelectedNotification"

@interface XHLink : NSObject
/** 链接文字 */
@property (nonatomic, copy) NSString *text;
/** 链接的范围 */
@property (nonatomic, assign) NSRange range;
/** 链接的边框 */
@property (nonatomic, strong) NSArray *rects;
/**用户ID*/
@property (nonatomic,copy) NSString * user_id;

@end

//
//  ImageATextModel.m
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "ImageATextModel.h"

@implementation ImageATextModel


+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"recent_comments":[ImageATextCommentModel class]
             ,@"top_comments":[ImageATextCommentModel class]
             };
}

@end

@implementation ImageATextCommentModel

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"reply_comments":[ImageATextCommentModel class]
             };
}

@end


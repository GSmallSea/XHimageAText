//
//  IconButton.m
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "IconButton.h"


@implementation IconButton


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setIconURL:(NSString *)iconURL{
    _iconURL = iconURL;

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconURL]];
    
    [self setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];

}

@end

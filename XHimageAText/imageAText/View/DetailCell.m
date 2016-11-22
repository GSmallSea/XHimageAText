//
//  DetailCell.m
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "DetailCell.h"
#import "DetaiReviewersView.h"
#import "DetailFrame.h"
@interface DetailCell ()

@property (nonatomic,weak) DetaiReviewersView *reviewersView;
@end

@implementation DetailCell

+ (DetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *iden = @"identity";
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil) {
    
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    
    DetaiReviewersView *view = [[DetaiReviewersView alloc] init];
    [self addSubview:view];
    self.reviewersView = view;
    
}
- (void)setDetailFrame:(DetailFrame *)detailFrame{
    _detailFrame = detailFrame;
    
    self.reviewersView.frame = detailFrame.Frame;
    self.reviewersView.detailFrame = _detailFrame;
    
}
@end

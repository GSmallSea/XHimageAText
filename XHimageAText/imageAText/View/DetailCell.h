//
//  DetailCell.h
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailFrame;
@interface DetailCell : UITableViewCell

@property (nonatomic,strong) DetailFrame * detailFrame;
+ (DetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

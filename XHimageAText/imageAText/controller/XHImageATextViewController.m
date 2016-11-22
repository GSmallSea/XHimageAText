//
//  XHImageATextViewController.m
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import "XHImageATextViewController.h"
#import "ImageATextModel.h"
#import "DetailCell.h"
#import "XHLink.h"
#import "DetailFrame.h"
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

@interface XHImageATextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) ImageATextModel *xmodel;

@property (nonatomic,strong) NSMutableArray * cellFrame;

@property (nonatomic,weak) UITableView * table;
@end

@implementation XHImageATextViewController

- (NSMutableArray *)cellFrame{
    
    if (_cellFrame == nil) {
        
        _cellFrame = [NSMutableArray array];
    }
    return _cellFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    NSDictionary *dict =  [self getDatas];
    self.xmodel = [ImageATextModel mj_objectWithKeyValues:dict];
    
    for (ImageATextCommentModel *model in self.xmodel.recent_comments) {
        
        DetailFrame *frame = [[DetailFrame alloc] init];
        frame.commentModel = model;
        [self.cellFrame addObject:frame];
    }
    
    [self.table reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkDidSelected:) name:XHLinkDidSelectedNotification object:nil];

    
}
- (void)linkDidSelected:(NSNotification *)note
{
    NSString *linkText = note.userInfo[XHLinkText];
    if ([linkText hasPrefix:@"http"]) {
        
    } else {
        // 跳转控制器
        NSLog(@"选中了非HTTP链接---%@", note.userInfo[XHLinkText]);
        NSString *userID = note.userInfo[XHLinkText];
        
        NSLog(@"%@",userID);
    }
}

- (NSDictionary  *)getDatas{
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",dict);
    return  dict;
}

- (void)createView{

    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.table = table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.xmodel.recent_comments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailFrame *frame = self.cellFrame[indexPath.row];
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [DetailCell tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.detailFrame = self.cellFrame[indexPath.row];
    return cell;
}
@end

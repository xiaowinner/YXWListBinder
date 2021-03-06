//
//  YXWViewController.m
//  YXWListBinder
//
//  Created by 原晓文 on 09/21/2018.
//  Copyright (c) 2018 原晓文. All rights reserved.
//

#import "YXWViewController.h"
#import "YXWViewModel.h"
#import "YXWCLViewController.h"

@interface YXWViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YXWViewModel *viewModel;
@property (nonatomic, strong) YXWListBinder *tableViewBinder;
    
@end

@implementation YXWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [[YXWViewModel alloc] init];
    
    CGFloat useWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat useHeight = [UIScreen mainScreen].bounds.size.height;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, useWidth, useHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableViewBinder = [[YXWListBinder alloc] initBinderWithTableView:self.tableView hasSection:YES command:self.viewModel.dataCommand];
    
    self.tableViewBinder.extra = @{@"viewController":self};
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(go) name:@"TBPUSH" object:nil];

    [self.viewModel.dataCommand execute:@(1)];
}

- (void)go {
    YXWCLViewController *yvc = [YXWCLViewController new];
    [self.navigationController pushViewController:yvc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"TABLEVIEW释放了");
}

@end

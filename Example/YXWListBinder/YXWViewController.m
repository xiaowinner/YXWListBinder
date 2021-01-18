//
//  YXWViewController.m
//  YXWListBinder
//
//  Created by 原晓文 on 09/21/2018.
//  Copyright (c) 2018 原晓文. All rights reserved.
//

#import "YXWViewController.h"
#import "YXWViewModel.h"

@interface YXWViewController ()

@property (nonatomic, strong) YXWViewModel *viewModel;
    
@end

@implementation YXWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [[YXWViewModel alloc] init];
    
    CGFloat useWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat useHeight = [UIScreen mainScreen].bounds.size.height;
    self.tableView.frame = CGRectMake(0, 0, useWidth, useHeight);
    [self.view addSubview:self.tableView];
    
    UINib *aNib = [UINib nibWithNibName:@"YXWNibTableViewCell" bundle:[NSBundle mainBundle]];
    NSArray *cel = [NSArray arrayWithObjects:aNib, [NSString stringWithFormat:@"YXWClassTableViewCell"], nil];
    
    self.tableViewBinder = [[YXWListBinder alloc] initBinder:self.tableView
                                                       cells:cel
                                               headerFooters:@[@"YXWNibTableViewHeaderView"]
                                             cellIdentifiers:@[@"YXWNibTableViewCell", @"YXWClassTableViewCell"]
                                     headerFooterIdentifiers:@[@"YXWNibTableViewHeaderView"]
                                                 dataCommand:self.viewModel.dataCommand];
    
    [self.tableViewBinder addTableViewDatasSubscribe:^{

    } errorSubcribe:^(NSError *error) {

    }];

    [self.viewModel.dataCommand execute:@(1)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

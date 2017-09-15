//
//  WKWebTableViewController.m
//  WKWebviewDynamicHeight
//
//  Created by houke on 2017/9/15.
//  Copyright © 2017年 ttplus. All rights reserved.
//

#import "WKWebTableViewController.h"
#import "WKWebTableViewCell.h"

@interface WKWebTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    CGFloat webCellH;
    __block BOOL trueWebH;
}

@end

@implementation WKWebTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    trueWebH = NO;
    webCellH = [UIScreen mainScreen].bounds.size.height;
    [self initTableView];
    // Do any additional setup after loading the view.
}

-(void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }else{
        return 30;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        NSLog(@"webCellH__%f",webCellH);
        return webCellH;
    }else{
        return 50;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        WKWebTableViewCell *cell = [WKWebTableViewCell wKWebTableViewCell:tableView];
        cell.urlStr = @"https://www.ttplus.cn/publish/app/data/2017/09/15/96994/share1.html";
        
        __weak typeof(self) weakSelf = self;
        [cell setRefreshCellHeight:^(CGFloat cellH){
            if (!trueWebH) {
                webCellH = cellH;
                [_tableView reloadData];
                trueWebH = YES;
            }
            
        }];
        
        return cell;
    }else{
        
        static NSString *ID = @"otherCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.backgroundColor = [UIColor yellowColor];
            
        }
        
        return cell;
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

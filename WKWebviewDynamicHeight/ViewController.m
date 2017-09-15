//
//  ViewController.m
//  WKWebviewDynamicHeight
//
//  Created by houke on 2017/9/15.
//  Copyright © 2017年 ttplus. All rights reserved.
//

#import "ViewController.h"
#import "WKWebTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 80, 40);
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view.
}

-(void)buttonClick:(UIButton *)sender
{
    WKWebTableViewController *vc =[[WKWebTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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

//
//  WKWebTableViewCell.h
//  WKWebviewDynamicHeight
//
//  Created by houke on 2017/9/15.
//  Copyright © 2017年 ttplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKWebTableViewCell : UITableViewCell

@property (nonatomic, strong)  void (^refreshCellHeight)(CGFloat cellH);
@property (nonatomic ,copy) NSString *urlStr;
+(instancetype)wKWebTableViewCell:(UITableView *)tableview;
@end

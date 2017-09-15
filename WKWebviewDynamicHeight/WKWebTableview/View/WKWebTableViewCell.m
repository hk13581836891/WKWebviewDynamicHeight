//
//  WKWebTableViewCell.m
//  WKWebviewDynamicHeight
//
//  Created by houke on 2017/9/15.
//  Copyright © 2017年 ttplus. All rights reserved.
//

#import "WKWebTableViewCell.h"
#import <WebKit/WebKit.h>

@interface  WKWebTableViewCell()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView *_wkWebView ;
    BOOL trueWebH;
    BOOL webLoad;
}

@end

@implementation WKWebTableViewCell
+(instancetype)wKWebTableViewCell:(UITableView *)tableview
{
    static NSString *ID = @"WKWebTableViewCell";
    WKWebTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WKWebTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}

-(void) initCell
{
    trueWebH = NO;
    webLoad = NO;
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    _wkWebView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:_wkWebView];
}


-(void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;

    if (!webLoad) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [_wkWebView loadRequest:request];
        webLoad = YES;
    }

}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    if (!trueWebH) {
        [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            //获取页面高度，并重置webview的frame
            CGFloat documentHeight = [result doubleValue];
            CGRect frame = webView.frame;
            frame.size.height = documentHeight;
            _wkWebView.frame = frame;
            _refreshCellHeight(documentHeight);
            
        }];
        trueWebH = YES;
    }
    

//    [webView evaluateJavaScript:@"document.getElementById(\"content\").offsetHeight;"completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        //获取页面高度，并重置webview的frame
//        CGFloat documentHeight = [result doubleValue];
//        CGRect frame = webView.frame;
//        frame.size.height = documentHeight;
//        _wkWebView.frame = frame;
//    }];
}
//
//// 类似 UIWebView的 -webView: shouldStartLoadWithRequest: navigationType:
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler {
//    
//    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    if([strRequest isEqualToString:@"about:blank"]) {//主页面加载内容
//        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
//    } else {//截获页面里面的链接点击
//        //do something you want
//        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

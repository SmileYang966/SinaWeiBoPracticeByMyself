//
//  OAuthViewController.m
//  微博项目
//
//  Created by Evan Yang on 07/03/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "OAuthViewController.h"
#import "SCAccount.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "NewFeaturesIntroductionsViewController.h"
#import "WeiBoTabBarController.h"
#import "SCAccountManager.h"

#define APPKEY @"2326987067"
#define APPSECRET   @"165fd028b852cf43a90d3858d64ecfb1"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    webView.delegate = self;
    
    //请求地址
    //请求参数
    //App Key：1288817013
    //App Secret：cb12da93bc847f98851bb4bc6af27548
    //
    //
    
    /*
     * 进入授权界面，第一件事情就是去请求登录界面
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2326987067&redirect_uri=https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

/*
 * urlStr=http://www.baidu.com/?code=3232a3a02e155f776ff3c1e520f6be2e
 */

/*
 *第二件事，就是截取code=后面的字符串，即request code，通过request code
 *去请求对应的access code，并将这些数据以对象的形式存储到文件中去
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) {
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:fromIndex];
        NSLog(@"urlStr=%@ code=%@",urlStr,code);
        [self requestedAccessTokenByRequestedCode:code];
        return false;
    }
    return true;
}

/*
 *第三步，根据request code去请求得到对应的access token
 */
-(void)requestedAccessTokenByRequestedCode:(NSString *)requestedCode{
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    requestM.HTTPMethod=@"POST";
    NSString *paramStr = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=%@&code=%@&redirect_uri=%@",
                          APPKEY,APPSECRET,@"authorization_code",requestedCode,@"https://www.baidu.com"];
    NSData *paramData = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    requestM.HTTPBody = paramData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:requestM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        /*确定哪个应用能够访问哪个用户的信息*/
        /*
         dict={
         "access_token" = "2.00QiHNPETdnTXC3e779b6921wW3H7D";
         "expires_in" = 157679999;
         isRealName = true;
         "remind_in" = 157679999;
         uid = 3889304284;
         }
         */
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dict=%@",dict);
        
        /*Get the SCAccount 模型*/
        SCAccount *account = [SCAccount accountWithDict:dict];
        
        /*专门写一个SCAccountManager这个类，用于存储account*/
        [SCAccountManager saveAccount:account];
        
        /*要写入的模型的文件路径
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *accountPath = [docPath stringByAppendingPathComponent:@"account.plist"];
        */
        
        /*若是字典的话，是可以用writeToFile，但是现在是一个对象，对象是没有writeToFile这个方法的*/
//        [dict writeToFile:accountPath atomically:YES];
        /*注意对对象通过NSKeyedArchiver的方式进行写入的时候，需要指定SCAccount对象的解码和压缩码的操作
        [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
        */
         
        //接着选择进入版本新特性界面还是主TabBar界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIWindow switchedRootViewController];
        });
        
    }];
    
    [task resume];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

@end

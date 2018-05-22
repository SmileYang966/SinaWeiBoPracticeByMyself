//
//  HomeViewController.m
//  微博项目
//
//  Created by Evan Yang on 23/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "HomeViewController.h"
#import "SCDropdownMenu.h"
#import "HomeDropMenuTableViewController.h"
#import "AFNetworking.h"
#import "SCAccountManager.h"
#import "SCAccount.h"
#import "TitleButton.h"
#import "SinaUser.h"
#import "SinaStatus.h"
#import "MJExtension.h"

#import "LoadMoreFooterView.h"

#import "UIImageView+WebCache.h"

#import "SinaWeiBoTableViewCell.h"

#import "SinaWeiBoFrame.h"
#import "SinaWeiBoTableViewCell.h"

@interface HomeViewController ()<SCDropDownMenuDelegate>
@property(nonatomic,strong)UIButton *titleBtn;
@property(nonatomic,strong) NSMutableArray *statuses;
@property(nonatomic,strong) NSMutableArray *totalData;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) LoadMoreFooterView *footerView;

@end

@implementation HomeViewController

- (UIButton *)titleBtn{
    if (_titleBtn == NULL) {
        TitleButton *titleBtn = [[TitleButton alloc]init];
        
        NSDictionary *fontAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0]};
        SCAccount *account = [SCAccountManager account];
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:
                                       (account.name!=NULL ? account.name : @"首页") attributes:fontAttr];
        [titleBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
        
        [titleBtn sizeToFit];
        
        [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _titleBtn = titleBtn;
    }
    return _titleBtn;
}

- (NSArray *)statuses{
    if (_statuses == NULL) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (NSMutableArray *)totalData{
    if (_totalData == NULL) {
        _totalData = [NSMutableArray array];
    }
    return _totalData;
}

- (LoadMoreFooterView *)footerView{
    if (_footerView == NULL) {
        _footerView = [LoadMoreFooterView loadMoreFooterView];
        _footerView.activityIndicatorView.centerY = _footerView.center.y;
    }
    return _footerView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set the naviagationItem
    [self setNavigationItems];
    
    // 设置用户信息
    [self setUpUserInfo];
    
    // 设置测试的button
//    [self setTestedButton];
    
    // 设置请求数据
//    [self loadRequest1];
    
    //添加一个下拉刷新Control，其实苹果系统已经封装好了这个功能
    [self addRefreshControl];
    
    //添加一个上拉刷新的功能
    [self addPullUpRefresh];
    
    //监听服务器未读区的微博数
    [self moniterServerToGetUnreadMessages];
}

#pragma mark ================添加下拉刷新操作==========================

-(void)addRefreshControl{
    //1.New一个UIRefreshControl的对象，并且将这个refreshControl对象直接加入到self.tableView中去
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshWeiBo:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    //用自定义的refreshControl对象去引用这个局部变量
    self.refreshControl = refreshControl;
    
    //2.一进入界面，就开始转那个refresh的圈圈
    [refreshControl beginRefreshing];
    
    //3.并开始加载数据
    [self refreshWeiBo:refreshControl];
}

-(void)refreshWeiBo:(UIRefreshControl *)refreshControl{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    SCAccount *account = [SCAccountManager account];
    dictM[@"access_token"] = account.access_token;
    //加上count后表示每次最多请求10条数据
    dictM[@"count"] = @10;
    //得到since_id，就要得到第一条微博的since_id
    SinaWeiBoFrame *firstWeiBoFrame = [self.totalData firstObject];
    //需要加上这个check，因为第一次进行网络请求时,totalData还为空
    if (firstWeiBoFrame) {
        dictM[@"since_id"] = firstWeiBoFrame.sinaStatus.idstr;
    }
    
    //发送Get请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dictM progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-------%@------",responseObject);
        
        //1.遍历字典数组，取出每个字典数组转化成对象模型
        NSDictionary *dict = responseObject;
        NSArray *elements = dict[@"statuses"];
        
        NSArray *array111 = [SinaStatus objectArrayWithKeyValuesArray:dict[@"statuses"]];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (SinaStatus *status in array111) {
            SinaWeiBoFrame *weiBoFrame = [[SinaWeiBoFrame alloc]init];
            weiBoFrame.sinaStatus = status;
            [arrayM addObject:weiBoFrame];
        }
        
        //2.用一个可变的数组去存储新加载进来的SinaStatus
        /*
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in elements) {
            //SinaWeiBoFrame里既有cell里各个元素的frame,也有sinaStatus的值(具体数据)
            SinaWeiBoFrame *weiBoFrame = [[SinaWeiBoFrame alloc]init];
            SinaStatus *sinaStatus = [[SinaStatus alloc]initWithDict:dict];
            weiBoFrame.sinaStatus = sinaStatus;
            [arrayM addObject:weiBoFrame];
        }*/
        
        //3.添加这些更新的数据到totalData的最前面,因为刷新数据后，新数据理所当然显示在最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,arrayM.count)];
        [self.totalData insertObjects:arrayM atIndexes:indexSet];
        
        //4.Get到数据后就reloadData，就可以显示这些最新的下载数据
        [self.tableView reloadData];
        
        //第一次的since_id还是空的，并且又请求到了网络数据
        //这时候去添加一个上拉刷新的button
//        if (!firstSinaStatus && self.totalData.count>0) {
//            [self addPullUpRefresh];
//        }
        
        //5.Get到数据后就停止刷新
        [refreshControl endRefreshing];
        
        //6.停止刷新后显示更新了多少条的数据
        [self showNewStatusCount:(int)arrayM.count];
        
        //7. 刷新完成需要更新当前的tableItem的bage值
        self.tabBarItem.badgeValue = nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //7.失败后也停止刷新
        [refreshControl endRefreshing];
    }];
}

- (void)showNewStatusCount:(int)count{
    //1.创建一个label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    //2.设置其它属性
    if (count==0) {
        label.text = @"没有新的微博数据，稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    
    //3.添加到navigationController.view上，不太明白下面这句是什么意思
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    /* 动画方式一，通过y值的变化来实现动画效果
     [UIView animateWithDuration:1 animations:^{
     label.y = 64;
     } completion:^(BOOL finished) {
     [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
     label.y = 64 - label.height;
     } completion:^(BOOL finished) {
     }];
     }];
     */
    
    //4.如果动画效果是实现之后又回到初始状态的情形，那么建议使用transform的方式
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //5.完成后需要先delay一段时间后，再执行下面的操作
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //下面这句话可以让label回到最初的位置，看上去像是系统已经把初始的label的transform保存
            //到了CGAffineTransformIdentity里面
            label.transform = CGAffineTransformIdentity;
            //label.transform = CGAffineTransformMakeTranslation(0, -label.height);
        } completion:^(BOOL finished) {
            
        }];
    }];
}


#pragma mark =====================添加上拉刷新的button===========================

//添加一个上拉刷新的button
-(void)addPullUpRefresh{
    self.footerView.hidden = YES;
    // footView是不需要设置其x,y值的
    self.tableView.tableFooterView = self.footerView;
}

//快要停下来的时候，开始显示那个footerView
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    self.footerView.hidden = false;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //1.Get the offsetY
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //2.check if we have got the data from server
    if (self.totalData.count==0)    return;
    
    //3.判断scrollView的偏移量
    
    /*
     * 经过测试，我们发现每次请求数据都会请求两次数据，这就导致了我们接受了同样的两份数据
     * 我们发现原来这里是调用了两次
     * 经过分析原因，我们这里需要加上self.footerView.hidden这个check条件
     * 想想也是说的通的，因为只有在footerView还在的时候才是需要加载数据
     */
    
    /*若是屏幕本身的高度加上位移的长度能够 大于 scrollView本身的contentSize的话，说明已经滑倒最底端*/
    if(scrollView.height + scrollView.contentOffset.y > scrollView.contentSize.height
       && self.refreshControl.isRefreshing == NO && self.footerView.hidden)
    {
        //显示footerView
        self.footerView.hidden = false;
        
        //加载最新数据
        [self loadMoreStatus];
        
        /*
         contentInset：除具体内容以外的边框尺寸
         contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
         contentOffset:
         1.它可以用来判断scrollView滚动到什么位置
         2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
         */
    }
    
    
    //    if (offsetY >= judegOffsetY) {
    //        //显示footerView
    //        self.footerView.hidden = false;
    //
    //        //加载最新数据
    //        [self loadMoreStatus];
    //
    //        /*
    //         contentInset：除具体内容以外的边框尺寸
    //         contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
    //         contentOffset:
    //         1.它可以用来判断scrollView滚动到什么位置
    //         2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
    //         */
    //    }
}

-(void)loadMoreStatus{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    SCAccount *account = [SCAccountManager account];
    paramDict[@"access_token"] = account.access_token;
    paramDict[@"count"] = @10;
    
    SinaWeiBoFrame *weiBoFrame = [self.totalData lastObject];
    if (weiBoFrame != NULL) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = weiBoFrame.sinaStatus.idstr.longLongValue - 1;
        paramDict[@"max_id"] = @(maxId);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:paramDict progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //1.遍历字典数组，取出每个字典数组转化成对象模型
        NSDictionary *dict = responseObject;
        NSArray *elements = dict[@"statuses"];
        
        
        NSArray *array111 = [SinaStatus objectArrayWithKeyValuesArray:dict[@"statuses"]];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (SinaStatus *status in array111) {
            SinaWeiBoFrame *weiBoFrame = [[SinaWeiBoFrame alloc]init];
            weiBoFrame.sinaStatus = status;
            [arrayM addObject:weiBoFrame];
        }
        
        //2.用一个可变的数组去存储新加载进来的SinaStatus
        /*
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in elements) {
            SinaWeiBoFrame *weiBoFrame = [[SinaWeiBoFrame alloc]init];
            SinaStatus *sinaStatus = [[SinaStatus alloc]initWithDict:dict];
            weiBoFrame.sinaStatus = sinaStatus;
            [arrayM addObject:weiBoFrame];
        }*/
        
        //3.将更多数据显示在最后面
        [self.totalData addObjectsFromArray:arrayM];
        
        //4.刷新表格
        [self.tableView reloadData];
        
        //5.结束刷新后，需要去隐藏tableViewFootView
        self.footerView.hidden = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}


#pragma mark ============添加timer来实现定时的去查看新浪服务器有新的未读进来的数据============

-(void) moniterServerToGetUnreadMessages{
    //每隔5秒钟都会去请求一下当前的状态
    //这边有一个新的问题，就是这个NSTimer每隔5秒后去调用对应的function，
    //但是因为在主线程执行的，所以很容易被主线程给阻塞住
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self setRequestToGetUnreadCount];
    }];
    
    //将timer添加到NSRunLoop里去,这样意味着不管主线程多忙，这个timer定时器至少都不会
    //被阻塞掉，感觉这样才靠谱啊
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


//设置未读的微博数
-(void)setRequestToGetUnreadCount{
    
    NSLog(@"setupUnreadCount");
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SCAccount *account = [SCAccountManager account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/remind/unread_count.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*把unRead的微博数转化成字符串类型的*/
        NSString *unReadCount = [responseObject[@"status"] description];
        if ([unReadCount isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = unReadCount;
            [UIApplication sharedApplication].applicationIconBadgeNumber = [unReadCount integerValue];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


/*
-(void)loadRequest1{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    SCAccount *account = [SCAccountManager account];
    dictM[@"access_token"] = account.access_token;
    dictM[@"count"] = @10;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dictM progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //遍历字典数组，取出每个字典数组转化成对象模型
        NSDictionary *dict = responseObject;
        NSArray *elements = dict[@"statuses"];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in elements) {
            SinaStatus *sinaStatus = [[SinaStatus alloc]initWithDict:dict];
            [arrayM addObject:sinaStatus];
        }
        
        //始终把得来的最新数据插入到totalData的最前面
        [self.totalData addObjectsFromArray:arrayM];
        
        //Get到数据后就reloadData，相当于重新加载数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


-(void)loadRequest{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SCAccount *account = [SCAccountManager account];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @1;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSMutableString *strM = [NSMutableString stringWithString:str];
        NSString *character = nil;
        for (int i=0; i<strM.length; i++) {
            character = [strM substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"("]  || [character isEqualToString:@")"]) {
                character = [strM substringWithRange:NSMakeRange(i, 2)];
            }
        }
        
        NSData *data = [strM dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array =  (NSArray *)dict[@"statuses"];
        NSDictionary *dictTest = (NSDictionary *)array[0];
        NSString *testText = dictTest[@"text"];
        int a = 5;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
*/


#pragma mark ===================设置用户信息=========================

- (void)setUpUserInfo{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSString *baseURL = @"https://api.weibo.com/2/users/show.json";
    
    NSMutableDictionary *paramM = [NSMutableDictionary dictionary];
    SCAccount *account = [SCAccountManager account];
    paramM[@"access_token"] = account.access_token;
    paramM[@"uid"] = account.uid;
    
    [mgr GET:baseURL parameters:paramM progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SCLog(@"请求成功-----name=%@,location=%@-----",responseObject[@"name"],responseObject[@"location"]);
        account.name = responseObject[@"name"];
        [SCAccountManager saveAccount:account];
        
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:account.name forState:UIControlStateNormal];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SCLog(@"请求失败");
    }];
}

/*
-(void)setTestedButton{
    UIButton *randomBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
    randomBtn.backgroundColor = [UIColor redColor];
    [randomBtn setTitle:@"Test" forState:UIControlStateNormal];
    [randomBtn addTarget:self action:@selector(randomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomBtn];
}*/

/* Set the navigationItems*/
-(void)setNavigationItems{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(leftBarButtonItemClicked:) Image:@"navigationbar_friendsearch" HighlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(rightBarButtonItemClicked:) Image:@"navigationbar_pop" HighlightedImage:@"navigationbar_pop_highlighted"];
    
    self.navigationItem.titleView = self.titleBtn;
}

- (void)randomBtnClicked:(UIButton *)btn
{
    SCDropdownMenu *dropDownMenu1 = [SCDropdownMenu menu];
    HomeDropMenuTableViewController *dropMenuTableVC = [[HomeDropMenuTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    dropMenuTableVC.view.height = 100;
    dropMenuTableVC.view.width = 200;
    dropDownMenu1.vc = dropMenuTableVC;
    [dropDownMenu1 showFrom:btn];
}

//另外这里非常重要的一个知识点就是关于对图片的拉伸技术，
//请到Assets.xcassets目录中去找到其对应的popover_background图片，然后对它的属性进行设置
//Assets.xcassets -> find popover_background image -> Slicing -> Slices -> Vertical
//这张图片我们只能垂直方向拉伸，因为水平方向是不规则的，一旦拉伸，原来的图片形状就变了
//记住一个要点：做拉伸操作，只能对规则的那个方向(垂直还是水平)进行拉伸
-(void)titleBtnClicked:(UIButton *)btn{
    /*
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
     */
    SCDropdownMenu *dropDownMenu1 = [SCDropdownMenu menu];
    [self dropdownMenuDidShow:dropDownMenu1];
    dropDownMenu1.delegate = self;
    HomeDropMenuTableViewController *dropMenuTableVC = [[HomeDropMenuTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    dropMenuTableVC.view.height = 200;
    dropMenuTableVC.view.width = 130;
    dropDownMenu1.vc = dropMenuTableVC;
    [dropDownMenu1 showFrom:btn];
}

-(void)dropdownMenuDidShow:(SCDropdownMenu *)menu{
    self.titleBtn.selected = YES;
}

- (void)dropDownMenuDidDismiss:(SCDropdownMenu *)menu{
//    [self.titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    self.titleBtn.selected = NO;
}

- (void)leftBarButtonItemClicked:(UIBarButtonItem *)item{
}

- (void)rightBarButtonItemClicked:(UIBarButtonItem *)item{
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.totalData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SinaWeiBoTableViewCell *cell = [SinaWeiBoTableViewCell cellWithTableView:tableView];
    SinaWeiBoFrame *weiBoFrame = self.totalData[indexPath.row];
    cell.weiboFrame = weiBoFrame;
    
    //通过SDWebImage去设置它的icon的image
//    NSString *imgUrl = user.profile_image_url;
//    UIImage *placeHolder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeHolder];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SinaWeiBoFrame *weiBoFrame = self.totalData[indexPath.row];
    return weiBoFrame.cellHeight;
}

@end

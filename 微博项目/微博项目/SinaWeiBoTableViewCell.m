//
//  SinaWeiBoTableViewCell.m
//  微博项目
//
//  Created by Evan Yang on 08/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SinaWeiBoTableViewCell.h"
#import "SinaWeiBoFrame.h"
#import "SinaStatus.h"
#import "SinaUser.h"
#import "UIImageView+WebCache.h"
#import "SinaPhoto.h"

#import "SCToolBarView.h"

@interface SinaWeiBoTableViewCell()

/************************原创微博*************************/
@property(nonatomic,weak) UIView *originalView;
//头像
@property(nonatomic,weak) UIImageView *iconImgView;
//用户昵称
@property(nonatomic,weak) UILabel *sendNameLabel;
//会员图标
@property(nonatomic,weak) UIImageView *vipImgView;
//发送时间
@property(nonatomic,weak) UILabel *sendTimeLabel;
//来自于
@property(nonatomic,weak) UILabel *shareFromLabel;
//微博正文
@property(nonatomic,weak) UILabel *contentLabel;
//配图
@property(nonatomic,weak) UIImageView *photoView;



/**转发微博原图*/
@property(nonatomic,weak) UIView *retweetView;

/**转发微博内容*/
@property(nonatomic,weak) UILabel *retweetContent;

/**转发微博附带的图片*/
@property(nonatomic,weak) UIImageView *retweetImgView;



/**设置工具条*/
@property(nonatomic,weak) SCToolBarView *toolBarView;

@end

@implementation SinaWeiBoTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"sinaWeiBoCell";
    SinaWeiBoTableViewCell *weiBoCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (weiBoCell == NULL) {
        weiBoCell = [[SinaWeiBoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return weiBoCell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell的背景图片为透明的，那么又因为原来的HomeViewController的背景view的颜色
        //是灰色的，所以可以看到是全部灰色的，但是我们需要orignialview的内容为白色，所以需要进行设置
        self.backgroundColor = [UIColor clearColor];
        
        //设置cell选择的状态为None
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        /*
         *设置选中时的背景view
        UIView *selectedBgView = [[UIView alloc]init];
        selectedBgView.backgroundColor = [UIColor blueColor];
        self.selectedBackgroundView = selectedBgView;
        */
        
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweetView];
        
        //初始化ToolBar
        [self setupToolBar];
        
    }
    return self;
}

/**初始化原创微博*/
-(void)setupOriginal{
    /*正文view*/
    UIView *originalView = [[UIView alloc]init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    self.originalView.backgroundColor = [UIColor whiteColor];
    
    //头像
    UIImageView *iconImgView = [[UIImageView alloc]init];
    [originalView addSubview:iconImgView];
    self.iconImgView = iconImgView;
    
    //用户昵称
    UILabel *sendNameLabel = [[UILabel alloc]init];
    [originalView addSubview:sendNameLabel];
    self.sendNameLabel = sendNameLabel;
    self.sendNameLabel.font = IWSinaWeiBoNameFont;
    
    //会员图标
    UIImageView *vipImgView = [[UIImageView alloc]init];
    [originalView addSubview:vipImgView];
    self.vipImgView = vipImgView;
    
    //发送时间
    UILabel *sendTimeLabel = [[UILabel alloc]init];
    [originalView addSubview:sendTimeLabel];
    self.sendTimeLabel = sendTimeLabel;
    self.sendTimeLabel.font = IWSinaWeiBoNameFont;
    
    //来自于
    UILabel *shareFromLabel = [[UILabel alloc]init];
    [originalView addSubview:shareFromLabel];
    self.shareFromLabel = shareFromLabel;
    self.shareFromLabel.font = IWSinaWeiBoNameFont;
    
    //微博正文
    UILabel *contentLabel = [[UILabel alloc]init];
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    self.contentLabel.font = IWSinaWeiBoContentFont;
    
    //配图
    UIImageView *photoView = [[UIImageView alloc]init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
}

/**初始化转发微博*/
-(void)setupRetweetView{
    //转发微博整体
    UIView *retweetView = [[UIView alloc]init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    //转发微博正文
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.font = IWSinaWeiBoContentFont;
    retweetContentLabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContent = retweetContentLabel;
    
    //转发微博图片
    UIImageView *retweetImgView = [[UIImageView alloc]init];
    [retweetView addSubview:retweetImgView];
    self.retweetImgView = retweetImgView;
}

/**设置工具条*/
- (void)setupToolBar{
    SCToolBarView *toolBar = [SCToolBarView toolBarView];
    [self.contentView addSubview:toolBar];
    self.toolBarView = toolBar;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//SinaWeiBoFrame里是即有数据，又有frame的，所以这个自定义cell要做的就是
//将frame和数据赋值给这个cell
- (void)setWeiboFrame:(SinaWeiBoFrame *)weiboFrame{
    _weiboFrame = weiboFrame;
    
    SinaStatus *status = weiboFrame.sinaStatus;
    SinaUser *user = status.user;
    
    //原创微博整体
    self.originalView.frame = weiboFrame.originalViewF;
//    self.originalView.backgroundColor = [UIColor redColor];
    
    //头像
    self.iconImgView.frame = weiboFrame.iconImgViewF;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    //会员名称
    self.sendNameLabel.frame = weiboFrame.sendNameLabelF;
    self.sendNameLabel.text = user.name;
    
    //会员图标
    self.vipImgView.frame = weiboFrame.vipImgViewF;
    self.vipImgView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    if (user.vip) {
        self.vipImgView.hidden = NO;
        self.sendNameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipImgView.hidden = YES;
        self.sendNameLabel.textColor = [UIColor blackColor];
    }

    //发送时间
    self.sendTimeLabel.frame = weiboFrame.sendTimeLabelF;
    self.sendTimeLabel.text = status.created_at;
    
    //来源
    self.shareFromLabel.frame = weiboFrame.shareFromLabelF;
    self.shareFromLabel.text = status.source;
    
    //主体内容
    self.contentLabel.frame = weiboFrame.contentLabelF;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = status.text;
    
    //有图片
    if (status.pic_urls.count) {
        self.photoView.frame = weiboFrame.photoViewF;
//        self.photoView.backgroundColor = [UIColor lightGrayColor];
        SinaPhoto *sinaPhoto = status.pic_urls.firstObject;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:sinaPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.contentMode = UIViewContentModeScaleAspectFit;
        //循环引用，所以在不用的时候，必须要hidden掉这个图片
        self.photoView.hidden = NO;
    }else{//没有图片
        self.photoView.hidden = YES;
    }
    
    //转发微博不为空
    if (status.retweeted_status) {
        /**取出转发微博*/
        SinaStatus *retweedSinaStatus = status.retweeted_status;
        SinaUser *retweedSinaUser = retweedSinaStatus.user;
        
        /**被转发微博整体*/
        self.retweetView.frame = weiboFrame.retweetedWeiBoF;
        self.retweetView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.5];
        
        /**被转发微博正文*/
        self.retweetContent.frame = weiboFrame.retweetedWeiBoContentF;
        NSString *retweetContentText = [NSString stringWithFormat:@"%@ : %@",retweedSinaUser.name,retweedSinaStatus.text];
        self.retweetContent.text = retweetContentText;
        
        /**被转发微博配图*/
        //有图片
        if (retweedSinaStatus.pic_urls.count) {
            self.retweetImgView.frame = weiboFrame.retweetedWeiBoPictureF;
//            self.retweetImgView.backgroundColor = [UIColor lightGrayColor];
            SinaPhoto *retweetSinaPhoto = retweedSinaStatus.pic_urls.firstObject;
            [self.retweetImgView sd_setImageWithURL:[NSURL URLWithString:retweetSinaPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetImgView.contentMode = UIViewContentModeScaleAspectFit;
            //循环引用，所以在不用的时候，必须要hidden掉这个图片
            self.retweetImgView.hidden = NO;
        }else{//没有图片
            self.retweetImgView.hidden = YES;
        }
        
        self.retweetView.hidden = NO;
    }else{
        self.retweetView.hidden = YES;
    }
    
    /**设置工具条的frame*/
    self.toolBarView.frame = weiboFrame.toolBarF;
    
    //设置微博cell的高度
    self.height = weiboFrame.cellHeight;
}

/*第二种做法就是重新设置cell的y值
- (void)setFrame:(CGRect)frame{
    frame.origin.y += IWSinaWeiBoCellBorderH;
    [super setFrame:frame];
}*/

@end

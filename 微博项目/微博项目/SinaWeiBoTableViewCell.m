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


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        /*正文view*/
        UIView *originalView = [[UIView alloc]init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        //头像
        UIImageView *iconImgView = [[UIImageView alloc]init];
        [originalView addSubview:iconImgView];
        self.iconImgView = iconImgView;
        
        //用户昵称
        UILabel *sendNameLabel = [[UILabel alloc]init];
        [originalView addSubview:sendNameLabel];
        self.sendNameLabel = sendNameLabel;
        
        //会员图标
        UIImageView *vipImgView = [[UIImageView alloc]init];
        [originalView addSubview:vipImgView];
        self.vipImgView = vipImgView;
        
        //发送时间
        UILabel *sendTimeLabel = [[UILabel alloc]init];
        [originalView addSubview:sendTimeLabel];
        self.sendTimeLabel = sendTimeLabel;
        
        //来自于
        UILabel *shareFromLabel = [[UILabel alloc]init];
        [originalView addSubview:shareFromLabel];
        self.shareFromLabel = shareFromLabel;

        //微博正文
        UILabel *contentLabel = [[UILabel alloc]init];
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;

        //配图
        UIImageView *photoView = [[UIImageView alloc]init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
        
    }
    return self;
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
    
    //头像
    self.iconImgView.frame = weiboFrame.iconImgViewF;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    //会员图标
    self.vipImgView.frame = weiboFrame.vipImgViewF;
    self.vipImgView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    
    //图片
    self.photoView.frame = weiboFrame.photoViewF;
    
    //会员名称
    self.sendNameLabel.frame = weiboFrame.sendNameLabelF;
    self.sendNameLabel.text = user.name;
    
    //发送时间
    self.sendTimeLabel.frame = weiboFrame.sendTimeLabelF;
    
    //来源
    self.shareFromLabel.frame = weiboFrame.shareFromLabelF;
    
    //主体内容
    self.contentLabel.frame = weiboFrame.contentLabelF;
    self.contentLabel.text = status.text;
}

@end

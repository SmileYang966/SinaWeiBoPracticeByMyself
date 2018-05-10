//
//  SinaWeiBoTableViewCell.h
//  微博项目
//
//  Created by Evan Yang on 08/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SinaWeiBoFrame;

@interface SinaWeiBoTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,assign)SinaWeiBoFrame *weiboFrame;

@end

//
//  LoadMoreFooterView.h
//  微博项目
//
//  Created by Evan Yang on 24/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreFooterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *loadMoreDataLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

+(instancetype)loadMoreFooterView;

@end

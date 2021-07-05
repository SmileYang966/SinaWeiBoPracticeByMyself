//
//  LoadMoreFooterView.m
//  微博项目
//
//  Created by Evan Yang on 24/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "LoadMoreFooterView.h"

@interface LoadMoreFooterView()

@end

@implementation LoadMoreFooterView

+(instancetype)loadMoreFooterView{
    return [[[NSBundle mainBundle] loadNibNamed:@"LoadMoreFooterView" owner:self options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

@end

//
//  JTDianpuHuodongListTableViewCell.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-2.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuHuodongListTableViewCell.h"

@implementation JTDianpuHuodongListTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        UIImageView * bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width-20, 80)];
        bgImgView.image=[UIImage imageNamed:@"登录按钮框.png"];
        [self addSubview:bgImgView];
        
        
        self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 80, 60)];
        [bgImgView addSubview:self.imgView];
        
        self.titleLab=[[UILabel alloc] initWithFrame:CGRectMake(90, 5, self.frame.size.width-20-90, 25)];
        self.titleLab.textColor=[UIColor whiteColor];
        self.titleLab.font=[UIFont systemFontOfSize:16];
        [bgImgView addSubview:self.titleLab];
 
        
        self.huodongDateLab=[[UILabel alloc] initWithFrame:CGRectMake(90, 30,self.frame.size.width-20-90, 20)];
        self.huodongDateLab.textColor=[UIColor whiteColor];
        self.huodongDateLab.font=[UIFont systemFontOfSize:13];
        [bgImgView addSubview:self.huodongDateLab];
        
        
        self.pelopeNumLab=[[UILabel alloc] initWithFrame:CGRectMake(90, 50, self.frame.size.width-20-90, 20)];
        self.pelopeNumLab.textColor=[UIColor whiteColor];
        self.pelopeNumLab.font=[UIFont systemFontOfSize:13];
        [bgImgView addSubview:self.pelopeNumLab];
        
        self.finishLab=[[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-70-10, 10,60, 60)];
        [bgImgView addSubview:self.finishLab];
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width, 90);
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

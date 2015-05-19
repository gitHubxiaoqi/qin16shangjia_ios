//
//  JTHuiyuanListTableViewCell.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-12.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTHuiyuanListTableViewCell.h"

@implementation JTHuiyuanListTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        UIImageView * bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width-20, 60)];
        bgImgView.image=[UIImage imageNamed:@"登录按钮框.png"];
        [self addSubview:bgImgView];
        

        
        self.titleLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20-10, 20)];
        self.titleLab.textColor=[UIColor brownColor];
        self.titleLab.font=[UIFont systemFontOfSize:16];
        [bgImgView addSubview:self.titleLab];
        
        
        self.activeValueLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.frame.size.width-20-10, 20)];
        self.activeValueLab.textColor=[UIColor whiteColor];
        self.activeValueLab.font=[UIFont systemFontOfSize:14];
        [bgImgView addSubview:self.activeValueLab];
        
        self.registDateLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 40,self.frame.size.width-20-10, 20)];
        self.registDateLab.textColor=[UIColor whiteColor];
        self.registDateLab.font=[UIFont systemFontOfSize:14];
        [bgImgView addSubview:self.registDateLab];
          
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width,70);
        
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

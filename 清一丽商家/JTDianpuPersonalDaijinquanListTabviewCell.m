//
//  JTDianpuPersonalDaijinquanListTabviewCell.m
//  清一丽
//
//  Created by 小七 on 15-1-5.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalDaijinquanListTabviewCell.h"

@implementation JTDianpuPersonalDaijinquanListTabviewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        _bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10, 90)];
        _bgImgView.image=[UIImage imageNamed:@"登录按钮框.png"];
        [self addSubview:_bgImgView];
        
        
        self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10-10-150, 80)];
        //self.imgView.image=[UIImage imageNamed:@"代金券.png"];
        [self.bgImgView addSubview:self.imgView];
        
        self.addHistoryLab=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-150-5, 5, 75, 20)];
        self.addHistoryLab.textColor=[UIColor redColor];
        self.addHistoryLab.textAlignment=NSTextAlignmentLeft;
        self.addHistoryLab.font=[UIFont systemFontOfSize:14];
        [self.bgImgView addSubview:self.addHistoryLab];
        
        self.numLab=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-150-5+75, 5,70, 20)];
        self.numLab.textColor=[UIColor whiteColor];
        self.numLab.textAlignment=NSTextAlignmentRight;
        self.numLab.font=[UIFont systemFontOfSize:16];
        [self.bgImgView addSubview:self.numLab];
        
        self.dateLab=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-150-5, 35, 150, 20)];
        self.dateLab.textColor=[UIColor blackColor];
        self.dateLab.textAlignment=NSTextAlignmentLeft;
        self.dateLab.font=[UIFont systemFontOfSize:15];
        [self.bgImgView addSubview:self.dateLab];
        
        self.dateValueLab=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-150-5, 65, 150, 20)];
        self.dateValueLab.textColor=[UIColor blackColor];
        self.dateValueLab.textAlignment=NSTextAlignmentLeft;
        self.dateValueLab.font=[UIFont systemFontOfSize:15];
        [self.bgImgView addSubview:self.dateValueLab];
        
        self.finishLab=[[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-90,25,60,60)];
        self.finishLab.image=[UIImage imageNamed:@"已结算.png"];
        [self.bgImgView addSubview:self.finishLab];
        
        self.addLab=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-150-5, 65, 150, 20)];
        self.addLab.textColor=[UIColor redColor];
        self.addLab.textAlignment=NSTextAlignmentRight;
        self.addLab.font=[UIFont systemFontOfSize:14];
        [self.bgImgView addSubview:self.addLab];
        

        
    }
    return self;
}
-(void)refreshUI
{
    if (self.finishLab.hidden==NO)
    {
        self.dateLab.frame=CGRectMake(self.bounds.size.width-150-5, 30, 65, 20);
        self.dateLab.text=@"结算日期:";
        self.dateLab.font=[UIFont systemFontOfSize:13];
        
        self.dateValueLab.frame=CGRectMake(self.bounds.size.width-150-5+65, 30, 150-65, 20);
        self.dateValueLab.font=[UIFont systemFontOfSize:13];
    }
    else if (self.finishLab.hidden==YES)
    {
        self.dateLab.frame=CGRectMake(self.bounds.size.width-150-5, 25, 150, 20);
        self.dateLab.text=@"用户使用日期:";
        self.dateLab.font=[UIFont systemFontOfSize:15];
        
        self.dateValueLab.frame=CGRectMake(self.bounds.size.width-150-5, 45, 150, 20);
        self.dateValueLab.font=[UIFont systemFontOfSize:15];
    }
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

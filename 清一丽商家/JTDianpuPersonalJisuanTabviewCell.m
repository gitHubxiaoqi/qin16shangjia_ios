//
//  JTDianpuPersonalJisuanTabviewCell.m
//  清一丽
//
//  Created by 小七 on 15-1-6.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalJisuanTabviewCell.h"

@implementation JTDianpuPersonalJisuanTabviewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        self.dateLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10,90, 20)];
        self.dateLab.textColor=[UIColor blackColor];
        self.dateLab.textAlignment=NSTextAlignmentCenter;
        self.dateLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.dateLab];
        
        self.priceLab=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, 50, 20)];
        self.priceLab.textColor=[UIColor brownColor];
        self.priceLab.textAlignment=NSTextAlignmentCenter;
        self.priceLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.priceLab];
        
        self.countLab=[[UILabel alloc] initWithFrame:CGRectMake(150, 10, 50, 20)];
        self.countLab.textColor=[UIColor blackColor];
        self.countLab.textAlignment=NSTextAlignmentCenter;
        self.countLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.countLab];
        
        self.detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.detailBtn.frame=CGRectMake(self.bounds.size.width-120, 0, 45, 40);
        [self addSubview:self.detailBtn];
        
        UILabel * lab1=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 45, 20)];
        lab1.text=@"查看明细";
        lab1.font=[UIFont systemFontOfSize:11];
        lab1.textColor=[UIColor redColor];
        lab1.textAlignment=NSTextAlignmentCenter;
        lab1.userInteractionEnabled=NO;
        [self.detailBtn addSubview:lab1];
        
        UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 27, 45, 0.5)];
        lineLab.backgroundColor=[UIColor redColor];
        lineLab.userInteractionEnabled=YES;
        [self.detailBtn addSubview:lineLab];
        
        
        self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.frame=CGRectMake(self.bounds.size.width-70, 10, 60, 20);
        self.sureBtn.backgroundColor=BG_COLOR;
        [self.sureBtn setTitle:@"确  认" forState:UIControlStateNormal];
        self.sureBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.sureBtn];

        
    }
    return self;
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

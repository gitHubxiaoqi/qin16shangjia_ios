//
//  JTDianpuPersonalGoodsListTabViewCell.m
//  清一丽
//
//  Created by 小七 on 14-12-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalGoodsListTabViewCell.h"

@implementation JTDianpuPersonalGoodsListTabViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        _bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 0.5, self.bounds.size.width-10, self.typeValueLab.frame.size.height+59)];
        _bgImgView.image=[UIImage imageNamed:@"登录按钮框.png"];
        [self addSubview:_bgImgView];
        
        
        self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
        [self addSubview:self.imgView];
        
        
        self.titleLab=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, self.frame.size.width-100-10, 20)];
        self.titleLab.textColor=[UIColor orangeColor];
        self.titleLab.font=[UIFont systemFontOfSize:16];
        [self addSubview:self.titleLab];
        

        
        self.typeLab=[[UILabel alloc] initWithFrame:CGRectMake(100, 30, 45, 20)];
        self.typeLab.textColor=[UIColor blackColor];
        self.typeLab.text=@"类型:";
        self.typeLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.typeLab];
        
        self.typeValueLab=[[UILabel alloc] initWithFrame:CGRectMake(140, 30, self.frame.size.width-150-10, 20)];
        self.typeValueLab.textColor=[UIColor whiteColor];
        self.typeValueLab.numberOfLines=0;
        self.typeValueLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.typeValueLab];
        
        self.priceLab=[[UILabel alloc] initWithFrame:CGRectMake(100, 30+self.typeValueLab.frame.size.height, 45, 20)];
        self.priceLab.textColor=[UIColor blackColor];
        self.priceLab.text=@"价格:";
        self.priceLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.priceLab];
        
        self.priceValueLab=[[UILabel alloc] initWithFrame:CGRectMake(140, 30+self.typeValueLab.frame.size.height, self.frame.size.width-150-10, 20)];
        self.priceValueLab.textColor=[UIColor whiteColor];
        self.priceValueLab.numberOfLines=0;
        self.priceValueLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.priceValueLab];
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width, 60+self.typeValueLab.frame.size.height);
    }
    return self;
}
-(void)refreshUI
{
    self.priceLab.frame=CGRectMake(100, 30+self.typeValueLab.frame.size.height, 45, 20);
    self.priceValueLab.frame=CGRectMake(140, 30+self.typeValueLab.frame.size.height, self.frame.size.width-150-10, 20);
    self.bgImgView.frame=CGRectMake(5, 0.5, self.bounds.size.width-10, self.typeValueLab.frame.size.height+59);
    self.bounds=CGRectMake(0, 0, self.bounds.size.width, 60+self.typeValueLab.frame.size.height);

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

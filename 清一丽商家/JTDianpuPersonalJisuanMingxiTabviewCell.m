//
//  JTDianpuPersonalJisuanMingxiTabviewCell.m
//  清一丽
//
//  Created by 小七 on 15-1-6.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalJisuanMingxiTabviewCell.h"

@implementation JTDianpuPersonalJisuanMingxiTabviewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        self.numLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 10,80, 20)];
        self.numLab.textColor=[UIColor redColor];
        self.numLab.textAlignment=NSTextAlignmentCenter;
        self.numLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.numLab];

        
        self.costLab=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2.0-40, 10,80, 20)];
        self.costLab.textColor=[UIColor brownColor];
        self.costLab.textAlignment=NSTextAlignmentCenter;
        self.costLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.costLab];
        
        self.useDateLab=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-120, 10,120, 20)];
        self.useDateLab.textColor=[UIColor blackColor];
        self.useDateLab.textAlignment=NSTextAlignmentCenter;
        self.useDateLab.font=[UIFont systemFontOfSize:13];
        [self addSubview:self.useDateLab];
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

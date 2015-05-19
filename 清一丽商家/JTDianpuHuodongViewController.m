//
//  JTDianpuHuodongViewController.m
//  清一丽商家后台
//
//  Created by 小七 on 15-3-2.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuHuodongViewController.h"
#import "JTDianpuHuodongListTableViewCell.h"
#import "JTDianpuHuodongDetailViewController.h"

@interface JTDianpuHuodongViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listModelArr;
    int pageNum;
    int q;
    UIButton * _selectedBtn1;
    UIButton * _selectedBtn2;
    BOOL  isFinish;

}


@end

@implementation JTDianpuHuodongViewController
-(void)viewDidAppear:(BOOL)animated
{
    if (_p==1)
    {
      [self sendPost];
    }
    _p=2;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _p=1;
    pageNum=1;
    isFinish=0;
    q=3;
    _listModelArr=[[NSMutableArray alloc] initWithCapacity:0];
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    //自定义导航条
    UIImageView * navBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    navBgImgview.image=[UIImage imageNamed:@"小横条.png"];
    navBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:navBgImgview];
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"本店活动";
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:22];
    [navBgImgview addSubview:navTitailLab];
    
    UIImageView * bigBgImgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44)];
    bigBgImgview.image=[UIImage imageNamed:@"大背景.png"];
    bigBgImgview.userInteractionEnabled=YES;
    [self.view addSubview:bigBgImgview];
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 80, NAV_HEIGHT);
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [navBgImgview addSubview:leftBtn];
    
    UIImageView * backImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回按钮.png"]];
    backImgView.frame=CGRectMake(20, (NAV_HEIGHT-15)/2, 10, 15);
    [leftBtn addSubview:backImgView];
    
    _selectedBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn1.frame=CGRectMake(self.view.frame.size.width/2.0-80, 64+15, 80, 25);
    [_selectedBtn1 setImage:[UIImage imageNamed:@"当前1.png"] forState:UIControlStateSelected];
    [_selectedBtn1 setImage:[UIImage imageNamed:@"当前2.png"] forState:UIControlStateNormal];
    [_selectedBtn1 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn1.selected=YES;
    [self.view addSubview:_selectedBtn1];
    
    
    _selectedBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn2.frame=CGRectMake(self.view.frame.size.width/2.0, 64+15, 80, 25);
    [_selectedBtn2 setImage:[UIImage imageNamed:@"历史2.png"] forState:UIControlStateSelected];
    [_selectedBtn2 setImage:[UIImage imageNamed:@"历史1.png"] forState:UIControlStateNormal];
    [_selectedBtn2 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn2.selected=NO;
    [self.view addSubview:_selectedBtn2];

    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64+15+25+5, self.view.frame.size.width, self.view.frame.size.height-110) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)qiehuan:(UIButton *)sender
{
    if (sender==_selectedBtn1)
    {
        _selectedBtn1.selected=YES;
        _selectedBtn2.selected=NO;
        isFinish=0;
        [self sendPost];

        
    }
    else if (sender==_selectedBtn2)
    {
        _selectedBtn1.selected=NO;
        _selectedBtn2.selected=YES;
        isFinish=1;
        [self sendPost];

    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listModelArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JTDianpuHuodongListTableViewCell * customCell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!customCell)
    {
        customCell=[[JTDianpuHuodongListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        customCell.selectionStyle=UITableViewCellSelectionStyleNone;
        customCell.backgroundColor=[UIColor clearColor];
    }
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    [customCell.imgView setImageWithURL:[NSURL URLWithString:model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon.png"]];
    customCell.titleLab.text=model.title;

    NSString * opentmeStr=[model.openTime stringByReplacingOccurrencesOfString:@" " withString:@""];
    customCell.huodongDateLab.text=[NSString stringWithFormat:@"活动时间:%@",opentmeStr];
    customCell.pelopeNumLab.text=[NSString stringWithFormat:@"报名人数:%@人",model.cost];
    
    if ([model.style isEqualToString:@"New"])
    {
        customCell.finishLab.hidden=YES;
        self.state=1;
    }
    else if ([model.style isEqualToString:@"OverTime"])
    {
        customCell.finishLab.hidden=NO;
        customCell.finishLab.image=[UIImage imageNamed:@"已过期"];
        self.state=2;
    }
    else if ([model.style isEqualToString:@"Cancelled"])
    {
        customCell.finishLab.hidden=NO;
        customCell.finishLab.image=[UIImage imageNamed:@"已取消"];
        self.state=2;
    }
    
    return customCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    JTDianpuHuodongDetailViewController * zjdVC=[[JTDianpuHuodongDetailViewController alloc] init];
    zjdVC.sortmodel=[[JTSortModel alloc] init];
    zjdVC.sortmodel=model;
    //zjdVC.listVC=self;
    [self.navigationController pushViewController:zjdVC animated:YES];
}

#pragma mark- 发请求
//发请求
-(void)sendPost
{
    pageNum=1;
    [_listModelArr removeAllObjects];
    [_tableView reloadData];
    q=3;
    [_tableView headerBeginRefreshing];
}
-(void)CompanyListHeaderRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self GetCompanyListData];
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView headerEndRefreshing];
    });
}

-(void)footerRefresh
{
    pageNum++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //请求数据
        [self loadMoreData];
        // 刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView footerEndRefreshing];
    });
}
-(void)GetCompanyListData
{
    NSMutableArray * statueArr=[[NSMutableArray alloc] initWithCapacity:0];
    if (isFinish==0)
    {
        [statueArr addObject:@"New"];
    }
    else if(isFinish==1)
    {
        [statueArr addObject:@"OverTime"];
        [statueArr addObject:@"Cancelled"];
    }
    
    if ([SOAPRequest checkNet])
    {
        AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:appdelegate.appUser.userShangjiaID,@"shopId",statueArr,@"status",@"1",@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Dianpu_shopActivityPage] jsonDic:jsondic]];
        
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if (q==3)
            {
                if ([[[zaojiaoListDic objectForKey:@"shopActivityPage"] objectForKey:@"totalCount"] intValue]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[[zaojiaoListDic objectForKey:@"shopActivityPage"] objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                    sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"registedCount"];
                    NSString * beginDate=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"startDate"]substringToIndex:10];
                    NSString * endDate=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"endDate"]substringToIndex:10];
                    sortModel.openTime=[NSString stringWithFormat:@"%@至%@",beginDate,endDate];
                    sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                    sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"status"];
                    
                    [_listModelArr addObject:sortModel];
                  
                }
                q=6;
            }
            else
            {
                NSArray * zaojiaoListArr=[[zaojiaoListDic objectForKey:@"shopActivityPage"] objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    NSString * idStr=[NSString stringWithFormat:@"%@",[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"]];
                    BOOL isExist=0;
                    for (int j=0; j<[_listModelArr count]; j++)
                    {
                        JTSortModel * aModel=[_listModelArr objectAtIndex:j];
                        if ([[NSString stringWithFormat:@"%@",aModel.idStr] isEqualToString:idStr])
                        {
                            isExist=1;
                            break;
                        }
                    }
                    if (isExist==0)
                    {
                        JTSortModel * sortModel=[[JTSortModel alloc] init];
                        sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                        sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                        sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"registedCount"];
                        NSString * beginDate=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"startDate"]substringToIndex:10];
                        NSString * endDate=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"endDate"]substringToIndex:10];
                        sortModel.openTime=[NSString stringWithFormat:@"%@至%@",beginDate,endDate];
                        sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                        sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"status"];
                        [_listModelArr insertObject:sortModel atIndex:0];
                        
                    }
                }
                
            }
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }

    
}
-(void)loadMoreData
{
    NSMutableArray * statueArr=[[NSMutableArray alloc] initWithCapacity:0];
    if (isFinish==0)
    {
        [statueArr addObject:@"New"];
    }
    else if(isFinish==1)
    {
        [statueArr addObject:@"OverTime"];
        [statueArr addObject:@"Cancelled"];
    }
    if ([SOAPRequest checkNet])
    {
        AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:appdelegate.appUser.userShangjiaID,@"shopId",statueArr,@"status",[NSString stringWithFormat:@"%d",pageNum],@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Dianpu_shopActivityPage] jsonDic:jsondic]];
        
        if ([[zaojiaoListDic objectForKey:@"resultCode"] intValue]==1000)
        {
            if ([[[zaojiaoListDic objectForKey:@"shopActivityPage"] objectForKey:@"list"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[[zaojiaoListDic objectForKey:@"shopActivityPage"] objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"registedCount"];
                NSString * beginDate=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"startDate"]substringToIndex:10];
                NSString * endDate=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"endDate"]substringToIndex:10];
                sortModel.openTime=[NSString stringWithFormat:@"%@至%@",beginDate,endDate];
                sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"status"];
                [_listModelArr addObject:sortModel];
           
            }
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

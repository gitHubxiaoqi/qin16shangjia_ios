//
//  JTDianpuPersonalJisuanMingxiViewcontroller.m
//  清一丽
//
//  Created by 小七 on 15-1-6.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalJisuanMingxiViewcontroller.h"
#import "JTDianpuPersonalJisuanMingxiTabviewCell.h"
@interface JTDianpuPersonalJisuanMingxiViewcontroller()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listModelArr;
    int pageNum;
    int q;

}
@end
@implementation JTDianpuPersonalJisuanMingxiViewcontroller
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self sendPost];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    navTitailLab.text=@"清单明细";
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
    
    UIView * longView=[[UIView alloc] initWithFrame:CGRectMake(0,64 , self.view.frame.size.width, 30)];
    longView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [self.view addSubview:longView];
    
    UILabel * lab1=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 90, 20)];
    lab1.font=[UIFont systemFontOfSize:14];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.textColor=[UIColor blackColor];
    lab1.text=@"代金券编号";
    [longView addSubview:lab1];
    

    
    UILabel * lab2=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-50, 5, 100, 20)];
    lab2.font=[UIFont systemFontOfSize:14];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.textColor=[UIColor blackColor];
    lab2.text=@"金额(奖励金额)";
    [longView addSubview:lab2];
    
    UILabel * lab3=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 5, 90, 20)];
    lab3.font=[UIFont systemFontOfSize:14];
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.textColor=[UIColor blackColor];
    lab3.text=@"用户使用日期";
    [longView addSubview:lab3];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, self.view.frame.size.width, self.view.frame.size.height-94) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    [self.view addSubview:_tableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listModelArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JTDianpuPersonalJisuanMingxiTabviewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTDianpuPersonalJisuanMingxiTabviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    cell.numLab.text=[NSString stringWithFormat:@"%@",model.name];
    if (model.cost==nil||[[NSString stringWithFormat:@"%@",model.cost] intValue]==0)
    {
        cell.costLab.text=[NSString stringWithFormat:@"￥%@",[NSString stringWithFormat:@"%@",model.style]];
    }
    else
    {
        cell.costLab.text=[NSString stringWithFormat:@"￥%@(奖励:%@元)",[NSString stringWithFormat:@"%@",model.style],[NSString stringWithFormat:@"%@",model.cost]];
    }
    
    cell.useDateLab.text=[NSString stringWithFormat:@"%@",model.beginDate];
 
    return cell;
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];

}
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
    [statueArr addObject:@"Settled"];
    
    AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",self.idStr,@"statementId",statueArr,@"status",@"1",@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_UserVoucherPage] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            
            if (q==3)
            {
                if ([[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"]objectForKey:@"totalCount"] intValue]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"]objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.name=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"usedDate"];
                    sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"price"];
                    sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"additional"];
                    [_listModelArr addObject:sortModel];
                }
                q=6;
            }
            else
            {
                NSArray * zaojiaoListArr=[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"]objectForKey:@"list"];;
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
                        sortModel.name=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                        sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"usedDate"];
                        sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"price"];
                        sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"additional"];
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
    
    [statueArr addObject:@"Settled"];
    
    if ([SOAPRequest checkNet])
    {
        AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",self.idStr,@"statementId",statueArr,@"status",[NSString stringWithFormat:@"%d",pageNum],@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_UserVoucherPage] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if ([[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"] objectForKey:@"list"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[[[zaojiaoDic objectForKey:@"userVoucherPage"] objectForKey:@"page"]objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.name=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.beginDate=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"usedDate"];
                sortModel.style=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"price"];
                sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"additional"];
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
@end

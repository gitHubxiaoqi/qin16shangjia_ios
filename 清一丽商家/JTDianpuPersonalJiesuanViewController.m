//
//  JTDianpuPersonalJiesuanViewController.m
//  清一丽
//
//  Created by 小七 on 15-1-6.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDianpuPersonalJiesuanViewController.h"
#import "JTDianpuPersonalJisuanTabviewCell.h"
#import "JTDianpuPersonalJisuanMingxiViewcontroller.h"
@interface JTDianpuPersonalJiesuanViewController()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listModelArr;
    int pageNum;
    int p;
    int q;
    UIButton * _selectedBtn1;
    UIButton * _selectedBtn2;
    BOOL  isFinish;
    
    UILabel * _countLab;
    int totalCount;
}
@end
@implementation JTDianpuPersonalJiesuanViewController
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

   
    if (p==1)
    {
         [self sendPost];
        
    }
    p=2;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    totalCount=0;
    isFinish=0;
    p=1;
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
    navTitailLab.text=@"商家结算清单";
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
    _selectedBtn1.frame=CGRectMake(self.view.frame.size.width/2.0-80, 64+10, 80, 25);
    [_selectedBtn1 setImage:[UIImage imageNamed:@"未确认1.png"] forState:UIControlStateSelected];
    [_selectedBtn1 setImage:[UIImage imageNamed:@"未确认2.png"] forState:UIControlStateNormal];
    [_selectedBtn1 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn1.selected=YES;
    [self.view addSubview:_selectedBtn1];
    
    
    _selectedBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn2.frame=CGRectMake(self.view.frame.size.width/2.0, 64+10, 80, 25);
    [_selectedBtn2 setImage:[UIImage imageNamed:@"已确认2.png"] forState:UIControlStateSelected];
    [_selectedBtn2 setImage:[UIImage imageNamed:@"已确认1.png"] forState:UIControlStateNormal];
    [_selectedBtn2 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn2.selected=NO;
    [self.view addSubview:_selectedBtn2];
    
    _countLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 64+10+25+5, self.view.frame.size.width, 20)];
    _countLab.text=@"您有X份代金券未确认";
    _countLab.textColor=[UIColor orangeColor];
    _countLab.textAlignment=NSTextAlignmentCenter;
    _countLab.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:_countLab];
    
    UIView * longView=[[UIView alloc] initWithFrame:CGRectMake(0,64+10+25+5+20+5 , self.view.frame.size.width, 30)];
    longView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [self.view addSubview:longView];
    
    UILabel * lab1=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 20)];
    lab1.font=[UIFont systemFontOfSize:14];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.textColor=[UIColor blackColor];
    lab1.text=@"结算日期";
    [longView addSubview:lab1];
    
    UILabel * lab2=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 50, 20)];
    lab2.font=[UIFont systemFontOfSize:14];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.textColor=[UIColor blackColor];
    lab2.text=@"金额";
    [longView addSubview:lab2];
    
    UILabel * lab3=[[UILabel alloc] initWithFrame:CGRectMake(150, 5, 50, 20)];
    lab3.font=[UIFont systemFontOfSize:14];
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.textColor=[UIColor blackColor];
    lab3.text=@"数量";
    [longView addSubview:lab3];
    
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64+10+25+5+20+5+30+5, self.view.frame.size.width, self.view.frame.size.height-164) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
}
-(void)qiehuan:(UIButton *)sender
{
    if (sender==_selectedBtn1)
    {
        _selectedBtn1.selected=YES;
        _selectedBtn2.selected=NO;
        isFinish=0;
        [self sendPost];
        _countLab.hidden=NO;
    }
    else if (sender==_selectedBtn2)
    {
        _selectedBtn1.selected=NO;
        _selectedBtn2.selected=YES;
        isFinish=1;
        [self sendPost];
        _countLab.hidden=YES;
    }
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
    
    JTDianpuPersonalJisuanTabviewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTDianpuPersonalJisuanTabviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    JTSortModel * model=[_listModelArr objectAtIndex:indexPath.row];
    cell.dateLab.text=[NSString stringWithFormat:@"%@",model.openDay];
    cell.priceLab.text=[NSString stringWithFormat:@"%@元",model.cost];
    cell.countLab.text=[NSString stringWithFormat:@"%@",model.commentCount];
    if (isFinish==0)
    {
        cell.sureBtn.hidden=NO;
    }
    else if(isFinish==1)
    {
        cell.sureBtn.hidden=YES;
    }
    [cell.detailBtn addTarget:self action:@selector(mingxi:) forControlEvents:UIControlEventTouchUpInside];
    cell.detailBtn.tag=10000+indexPath.row;
    [cell.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.sureBtn.tag=20000+indexPath.row;
    return cell;
}
-(void)mingxi:(UIButton *)sender
{
    JTSortModel * model=[_listModelArr objectAtIndex:sender.tag-10000];
    JTDianpuPersonalJisuanMingxiViewcontroller * mcVC=[[JTDianpuPersonalJisuanMingxiViewcontroller alloc] init];
    mcVC.idStr=model.idStr;
    [self.navigationController pushViewController:mcVC animated:YES];

}
-(void)sureBtnClick:(UIButton *)sender
{
    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请再次确认是否已结算并收款，操作将不可逆！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    alertView.tag=sender.tag+10000;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        JTSortModel * model=[_listModelArr objectAtIndex:alertView.tag-10000-20000];
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id", nil];
            NSDictionary * zaojiaoCollectionDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_VoucherStatementConfirm] jsonDic:jsondic]];
            
            if ([[NSString stringWithFormat:@"%@",[zaojiaoCollectionDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
            {
                UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确认成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道了。。", nil];
                [alertView show];
                [self sendPost];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            
        }
    }
    else
    {
    }
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
        
        _countLab.text=[NSString stringWithFormat:@"您有%d份优惠券没有确认",totalCount];
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
        [statueArr addObject:@"Unconfirmed"];
    }
    else if(isFinish==1)
    {
        [statueArr addObject:@"Confirmed"];
    }
    
    AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",statueArr,@"status",@"1",@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_VoucherStatement] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            totalCount=[[[zaojiaoDic objectForKey:@"voucherStatementPage"] objectForKey:@"totalCount"] intValue];
            if (q==3)
            {
                if ([[[zaojiaoDic objectForKey:@"voucherStatementPage"] objectForKey:@"totalCount"] intValue]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"voucherStatementPage"] objectForKey:@"list"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[NSString stringWithFormat:@"%@",[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"]];
                    sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"settledDate"];
                    sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"totalAmount"];
                    sortModel.commentCount=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"totalCount"];
                    [_listModelArr addObject:sortModel];
                }
                q=6;
            }
            else
            {
                NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"voucherStatementPage"] objectForKey:@"list"];;
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
                        sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"settledDate"];
                        sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"totalAmount"];
                        sortModel.commentCount=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"totalCount"];
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
        [statueArr addObject:@"Unconfirmed"];
    }
    else if(isFinish==1)
    {
        [statueArr addObject:@"Confirmed"];
    }
    if ([SOAPRequest checkNet])
    {
        AppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",appdelegate.appUser.userShangjiaID],@"shopId",statueArr,@"status",[NSString stringWithFormat:@"%d",pageNum],@"page",@"20",@"pageSize", nil];
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_VoucherStatement] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if ([[[zaojiaoDic objectForKey:@"voucherStatementPage"] objectForKey:@"list"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[[zaojiaoDic objectForKey:@"voucherStatementPage"] objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.openDay=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"settledDate"];
                sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"totalAmount"];
                sortModel.commentCount=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"totalCount"];
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

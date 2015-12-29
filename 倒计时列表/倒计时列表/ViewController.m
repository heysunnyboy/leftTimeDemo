//
//  ViewController.m
//  倒计时列表
//
//  Created by yebaojia on 15/12/29.
//  Copyright © 2015年 mjia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource , UITableViewDelegate>
{
     NSArray *timeArr;//时间数组
}
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化时间数组
    timeArr = @[@"2015-12-31 19:23:20",@"2015-12-31 20:23:20",@"2015-12-30 19:23:20",@"2015-12-30 19:23:20",@"2015-12-31 22:23:20",@"2015-12-31 19:23:20",@"2015-12-31 20:23:20",@"2015-12-30 19:23:20",@"2015-12-30 19:23:20",@"2015-12-31 22:23:20",@"2015-12-31 19:23:20",@"2015-12-31 20:23:20",@"2015-12-30 19:23:20",@"2015-12-30 19:23:20",@"2015-12-31 22:23:20",@"2015-12-31 19:23:20",@"2015-12-31 20:23:20",@"2015-12-30 19:23:20",@"2015-12-30 19:23:20",@"2015-12-31 22:23:20"];
    //去掉tableview 多余分割线
    _tableView.tableFooterView = [[UIView alloc]init];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calTime) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}
//定时器刷新倒计时
-(void)calTime
{
    NSArray  *cells = _tableView.visibleCells; //取出屏幕可见ceLl
    for (UITableViewCell *cell in cells) {
        cell.textLabel.text = [self getTimeStr:timeArr[cell.tag]];
    }
}
//返回倒计时
-(NSString *)getTimeStr:(NSString *)fireStr
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* fireDate = [formater dateFromString:fireStr];
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    long hour = [d day] *24 + [d hour];
    NSString *seconds;
    NSString *minutes;
    NSString *hours;
    if([d second]<10)
        seconds = [NSString stringWithFormat:@"0%ld",[d second]];
    else
        seconds = [NSString stringWithFormat:@"%ld",[d second]];
    if([d minute]<10)
        minutes = [NSString stringWithFormat:@"0%ld",[d minute]];
    else
        minutes = [NSString stringWithFormat:@"%ld",[d minute]];
    if(hour < 10)
        hours = [NSString stringWithFormat:@"0%ld", hour];
    else
        hours = [NSString stringWithFormat:@"%ld",hour];
    return [NSString stringWithFormat:@"            倒计时%@:%@:%@", hours, minutes,seconds];
}

#pragma mark -- delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self getTimeStr:timeArr[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.tag = indexPath.row;//通过tag 获取对应cell的位置
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  20;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calTime) userInfo:nil repeats:YES];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if(_timer)
    {
        _timer = nil;//关闭定时器，
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

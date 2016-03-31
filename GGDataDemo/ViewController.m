//
//  ViewController.m
//  GGDataDemo
//
//  Created by MacBook on 16/3/30.
//  Copyright © 2016年 xm. All rights reserved.
//

#import "ViewController.h"
#import "GGParser.h"
#import "Parser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = @{@"name":@"ycc",
                           @"age":@"12",
                           @"phone":@"1592172366",
                           @"cpass":@"96833",
                           @"emile":@"ccyang@cpass.cn",
                           @"dwell":@"嘉定",@"dog":@[@"1",@"2",@"3"]};
    //字典转其他
    NSData *dict2data = [dict GGData];//OK
    NSString *dict2str = [dict GGString];//OK
    Parser *dict2Obj = [dict GGDictionaryToModel:@"Parser"];//OK
    //data转其他
    NSDictionary *data2dict = [dict2data GGDictionary];
    NSString *data2Str = [dict2data GGString];//OK
    Parser *data2Obj = [dict2data GGDataToModel:@"Parser"];//OK
    //字符串转其他
    NSData *str2data = [data2Str GGData];
    NSDictionary *str2dict = [data2Str GGDictionary];
    Parser *str2Obj = [data2Str GGStringToModel:@"Parser"];
    //对象转其他
    NSDictionary *obj2dict = [str2Obj GGDictionary];
    NSData *obj2data = [str2Obj GGData];//
    NSString *obj2str = [str2Obj GGString];//
    NSLog(@"Ok");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

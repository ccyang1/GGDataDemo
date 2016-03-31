//
//  Parser.h
//  GGDataDemo
//
//  Created by MacBook on 16/3/30.
//  Copyright © 2016年 xm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dog;
@interface Parser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *cpass;
@property (nonatomic, strong) NSString *emile;
@property (nonatomic, strong) NSString *dwell;

@property (nonatomic, strong) NSArray *dog;

@end


@interface Dog : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;

@end
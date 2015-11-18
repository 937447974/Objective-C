//
//  ViewController.m
//  CommonDataType
//
//  Created by yangjun on 15/10/13.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "ViewController.h"
#import "Dictionary.h"
#import "MutableDictionary.h"
#import "Array.h"
#import "MutableArray.h"
#import "Date.h"
#import "DateFormatter.h"
#import "Calendar.h"
#import "DateComponents.h"
#import "String.h"
#import "MutableString.h"
#import "Set.h"
#import "MutableSet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    id obj;
    
    obj = [[Dictionary alloc] init];
    obj = [[MutableDictionary alloc] init];
    
    obj = [[Array alloc] init];
    obj = [[MutableArray alloc] init];
    
    obj = [[Date alloc] init];
    obj = [[DateFormatter alloc] init];
    obj = [[Calendar alloc] init];
    obj = [[DateComponents alloc] init];
    
    obj = [[String alloc] init];
    obj = [[MutableString alloc] init];
    
    obj = [[Set alloc] init];
    obj = [[MutableSet alloc] init];
    
}

@end

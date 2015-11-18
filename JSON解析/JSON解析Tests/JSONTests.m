//
//  JSONTests.m
//  JSON解析
//
//  Created by yangjun on 15/10/9.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JSONTests : XCTestCase
{
    NSString *_jsonString;
}

@end

@implementation JSONTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"jun" forKey:@"yang"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];// NSMutableDictionary转NSData
    _jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];// NSData转NSString
    NSLog(@"JSON:%@", _jsonString);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSData *data = [_jsonString dataUsingEncoding:NSUTF8StringEncoding];// NSString转NSData
    // NSData转NSMutableDictionary
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil){
        NSLog(@"%@", jsonObject);
    }
}

@end

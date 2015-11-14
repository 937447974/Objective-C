//
//  XMLTests.m
//  XML解析
//
//  Created by yangjun on 15/10/9.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XMLTests : XCTestCase <NSXMLParserDelegate>
{
    NSXMLParser *_parser;
}

@end

@implementation XMLTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Main" withExtension:@"xml"];
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    _parser.delegate = self;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [_parser parse];// 解析xml
}

#pragma mark - NSXMLParserDelegate
#pragma mark 解析开始
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark 解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [parser abortParsing];// 停止解析
}

#pragma mark 解析出错
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"解析错误: %@", parseError.localizedDescription);
}

#pragma mark 解析器每次在XML中找到新的元素时，会调用该方法
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ - %@ - %@ - %@",elementName,namespaceURI, qName,attributeDict);
}

@end

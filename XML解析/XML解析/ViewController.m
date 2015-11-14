//
//  ViewController.m
//  XML解析
//
//  Created by yangjun on 15/10/9.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSXMLParserDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Main" withExtension:@"xml"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];// 解析xml
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

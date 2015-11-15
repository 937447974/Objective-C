//
//  ClassTest.m
//  Runtime
//
//  Created by ： on 15/9/22.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "ClassTest.h"
#import <objc/runtime.h>
#import "User.h"

NSString *classAddMethodIMP(id self, SEL _cmd, NSString *str) {
    // implementation ....
    NSLog(@"值:%@", str);
    return str;
}

NSString *userName(id self, SEL _cmd) {
    return @"OC";
}

@implementation ClassTest

- (void)test
{
//    [self testClass];
//    [self testName];
//    [self testPropertyName];
    [self testMethod];
}

#pragma mark - 类
- (void)testClass
{
    // 获取类
    id userClass = objc_getClass("User");
    NSLog(@"%@", userClass);
    // 等价
    userClass = [User class];
    NSLog(@"%@", userClass);
    
    // 父类
    fprintf(stdout, "\n父类\n");
    id superUserClass = class_getSuperclass(userClass);
    NSLog(@"%@", superUserClass);
    // 等价
    superUserClass = [User new].superclass;
    NSLog(@"%@", superUserClass);
    
    // 更改对象的类
    fprintf(stdout, "\n更改对象的类\n");
    User *user = [User new];
    NSLog(@"类:%@ userName:%@", user, user.userName);
    userClass = object_setClass(user, [ClassTest class]);// 类替换，并返回原来的类属性
    NSLog(@"类:%@ userName:%@", user, user.userName);
}

#pragma mark - 类名
- (void)testName{
    // 获取class
    id userClass = objc_getClass("User");
    const char *className = class_getName(userClass);
    fprintf(stdout, "类名:%s\n", className);
    // 等价
    className = object_getClassName(userClass);
    fprintf(stdout, "类名:%s\n", className);
    // 等价OC
    userClass = [User class];
    NSString *name = NSStringFromClass(userClass);
    NSLog(@"类名:%@", name);
    // 底层转换
    name = [NSString stringWithCString:className encoding:NSUTF8StringEncoding];
    NSLog(@"类名:%@", name);
}

#pragma mark - 属性
- (void)testPropertyName
{
    // 获取所有属性
    fprintf(stdout, "获取所有属性\n");
    id userClass = objc_getClass("User");
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(userClass, &outCount);// 所有属性
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];// 属性
        const char *propertyName = property_getName(property);// 属性名
        const char *propertyAttributes = property_getAttributes(property); //属性类型
        fprintf(stdout, "%s %s\n", propertyName, propertyAttributes);
        // 等价输出
        NSLog(@"%@", [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]);
    }
    
    // 单一属性
    fprintf(stdout, "\n单一属性\n");
    Ivar var = class_getInstanceVariable(userClass, "_userName");
    const char *typeEncoding =ivar_getTypeEncoding(var);
    const char *ivarName = ivar_getName(var);
    fprintf(stdout, "属性名:%s; 类型:%s\n", ivarName, typeEncoding);
    
#if !defined(OBJC_ARC_UNAVAILABLE)
    // 设置/获取属性值,需要关闭ARC模式
    fprintf(stdout, "\n设置/获取属性值\n");
    User *user = [[[User alloc] init] autorelease];
    NSString *userName = @"阳君";
    object_setInstanceVariable(user, "_userName", userName);
    NSLog(@"user.userName:%@", user.userName);
    user.userName = @"开启ARC";// 修改值
    object_getInstanceVariable(user, "_userName", (void*)&userName);
    NSLog(@"user.userName:%@", userName);
#endif
    
}

#pragma mark - 方法
- (void)testMethod
{
    // 获取所有方法
    fprintf(stdout, "获取所有方法\n");
    id userClass = objc_getClass("User");
    u_int count;// unsigned int
    Method *methods= class_copyMethodList(userClass, &count);// 所有方法,只包含实例方法）
    for (int i = 0; i < count ; i++) {
        Method method = methods[i];
        SEL name = method_getName(method);// 转为方法
        const char *selName = sel_getName(name);// 转为方法名
        const char *methodTypeEncoding = method_getTypeEncoding(method);// 方法传输的参数
        char *methodType = method_copyReturnType(method);// 方法返回的类型
        fprintf(stdout, "方法名:%s; 返回类型%s; 参数:%s\n", selName, methodType, methodTypeEncoding);
    }
    
    // 1.提取Method(类方法)
    fprintf(stdout, "\n方法提取\n");
    SEL name = sel_registerName("userWithUserName:");
    Method method = class_getClassMethod(userClass, name);
    name = method_getName(method);
    fprintf(stdout, "提取方法(+):%s\n", sel_getName(name));
    // 2.提取Method(实例方法)
    name = sel_registerName("initWithUserName:");
    method = class_getInstanceMethod(userClass, name);
    name = method_getName(method);
    fprintf(stdout, "提取方法(-):%s\n", sel_getName(name));
    // 3.提取IMP
    IMP imp = method_getImplementation(method);
    // 只能获取(-)方法
    imp = class_getMethodImplementation(userClass, name);
    imp = class_getMethodImplementation_stret(userClass, name);
    // 等价
    User *user = [[User alloc] init];
    imp = [user methodForSelector:name];
    
    // 类增加方法(全局方法)
    fprintf(stdout, "\n类增加方法\n");
    name = sel_registerName("classAddMethodIMP");
    BOOL addMethod = class_addMethod(userClass, name, (IMP)classAddMethodIMP,"i@:@");
    // 判断类是否有此方法
    if (addMethod && class_respondsToSelector(userClass, name) && [user respondsToSelector:name]) {
        fprintf(stdout, "类%s添加方法%s成功\n", class_getName(userClass), sel_getName(name));
    }
    // 类添加方法(-)
    name = @selector(classAddMethod:);
    method = class_getInstanceMethod(self.class, name);// 方法体
    imp = method_getImplementation(method);// 方法的实现
    class_addMethod(userClass, name, imp, "v@:");
    // 方法调用
    id methodBack = [user performSelector:@selector(classAddMethod:) withObject:@"阳君"];
    NSLog(@"类%@调用方法%@ 返回:%@", NSStringFromClass(user.class), [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding], methodBack);
    
    // 方法交换
    fprintf(stdout, "\n方法交换\n");
    Method m1 = class_getInstanceMethod([self class], @selector(userName));
    Method m2 = class_getInstanceMethod([self class], @selector(userName2));
    method_exchangeImplementations(m1, m2);
    NSLog(@"%@", [self userName]);
    NSLog(@"%@", [self userName2]);
    
    // 方法替换
    fprintf(stdout, "\n方法替换\n");
    Method userNameMethod = class_getInstanceMethod(self.class, @selector(userName));
    IMP userNameImp = method_getImplementation(userNameMethod);
    Method setUserNameMethod = class_getInstanceMethod(self.class, @selector(userName2));
    method_setImplementation(setUserNameMethod, userNameImp);
    NSLog(@"%@", [self userName]);
    NSLog(@"%@", [self userName2]);
    
    // 方法覆盖,只能使用全局方法替换,方法名需要一致
    fprintf(stdout, "\n方法覆盖\n");
    NSLog(@"%@", user.userName);
    name = sel_registerName("userName");
    imp = class_replaceMethod(userClass, name, (IMP)userName,"i@:@");
    NSLog(@"%@", user.userName);
}

#pragma mark 覆盖的方法
- (NSString *)userName
{
    return @"阳君";
}

- (NSString *)userName2
{
    return @"IOS";
}

#pragma mark 增加的方法
- (NSString *)classAddMethod:(NSString *)str
{
    return str;
}

@end

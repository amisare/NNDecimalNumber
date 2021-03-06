<h1 align = "center">NNDecimalNumber</h1>

[![GitHub release](https://img.shields.io/github/release/amisare/NNDecimalNumber.svg)](https://github.com/amisare/NNDecimalNumber/releases)
[![CocoaPods](https://img.shields.io/cocoapods/v/NNDecimalNumber.svg)](https://cocoapods.org/pods/NNDecimalNumber)
[![CocoaPods](https://img.shields.io/cocoapods/p/NNDecimalNumber.svg)](https://cocoapods.org/pods/NNDecimalNumber)
[![GitHub license](https://img.shields.io/github/license/amisare/NNDecimalNumber.svg)](https://github.com/amisare/NNDecimalNumber/blob/master/LICENSE)

## 介绍

提供 NSDecimalNumber 运算扩展 ，通过链式调用简化数值计算。

## 使用

- 示例一：全部使用 NSNumber 计算

```
    //( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
    NSString *v = @(3).nn_sub(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2))).nn_div(@(2));
```

- 示例二：全部使用 NSString 计算

```
    //( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
    NSString *v = @"3".nn_sub(@"2").nn_add(@"5").nn_mul(@"3").nn_mul(@"10".nn_mul(@"2")).nn_div(@"2");
```

- 示例三：使用 NSNumber 与 NSString 混合计算

```
    //( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
    NSString *v = @(3).nn_sub(@"2").nn_add(@(5)).nn_mul(@"3").nn_mul(@(10).nn_mul(@"2")).nn_div(@(2));
```

- 示例四：幂运算

```
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) ^ 2 )
        NSString *v = @"2".nn_mul(@(5)).nn_add(@"2".nn_mul(@"2")).nn_power(@(2));
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) × 10 ^ 2 )
        NSString *v = @(2).nn_mul(@"5").nn_add(@"2".nn_mul(@(2))).nn_mulPowerOf10(@(2));
    }
```

- 示例五：数值比较

```
    NSString *v0 = @"100";
    NSNumber *v1 = @(100.1);
    if ([v0 nn_decimalIsEqualTo:v1]) {
        NSLog(@"v0 == v1 : v0 = %@, v1 = %@", v0, v1);
    }
    else if ([v0 nn_decimalIsGreaterThan:v1]) {
        NSLog(@"v0 > v1 : v0 = %@, v1 = %@", v0, v1);
    }
    else if ([v0 nn_decimalIsGreaterThanOrEqualTo:v1]) {
        NSLog(@"v0 <= v1 : v0 = %@, v1 = %@", v0, v1);
    }
    else if ([v0 nn_decimalIsLessThan:v1]) {
        NSLog(@"v0 < v1 : v0 = %@, v1 = %@", v0, v1);
    }
```

- 示例六：设置 NSDecimalNumberBehaviors

```
    // 设置全局 NSDecimalNumberBehaviors
    {
        [NSString nn_setDecimalNumberGlobalBehavior:[DecimalNumberGlobalBehavior class]];
        NSString *v = @"1".nn_div(@(3));
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    // 当前计算式 NSDecimalNumberBehaviors
    {
        DecimalNumberBehavior *behavior = [DecimalNumberBehavior new];
        NSString *v = @"1".nn_behavior(behavior).nn_div(@(3)).nn_div(@(2));
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    // 使用 NSDecimalNumberHandler
    {
        NSDecimalNumberHandler *behavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain
                                                                                          scale:4
                                                                               raiseOnExactness:false
                                                                                raiseOnOverflow:false
                                                                               raiseOnUnderflow:false
                                                                            raiseOnDivideByZero:false];
        NSString *v = @"1".nn_behavior(behavior).nn_div(@(3));
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
```

- 示例六：异常计算（异常计算结果统一为字符串：@"NaN"，即`[[NSDecimalNumber notANumber] stringValue]`）

```
    {
        //( 2 × [UIView new] )
        NSString *v = @"2".nn_mul([UIView new]);
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( 2 / 0 )
        NSString *v = @"2".nn_div(@"0");
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / nil )
        NSString *v =  NN_Trust(nil).nn_div(nil);
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / 0 )
        NSString *v =  NN_Trust(nil).nn_div(@(0));
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / [UIView new] )
        NSString *v =  NN_Trust(nil).nn_div([UIView new]);
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / [NSNull null] )
        NSString *v =  NN_Trust(nil).nn_div([NSNull null]);
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / [NSNull null] )
        NSString *v =  [NSNull null].nn_div([NSNull null]);
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / 0 )
        NSString *v =  [NSNull null].nn_div(@(0));
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / [UIView new] )
        NSString *v =  [NSNull null].nn_div([UIView new]);
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / nil )
        NSString *v =  [NSNull null].nn_div(nil);
        NSLog(@"%@ = %@", v, v.nn_formula);
    }
```

- 示例七：计算式输出

```
    //( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
    NSString *v = @(3).nn_sub(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2))).nn_div(@(2));
    NSLog(@"%@", v.nn_formula); //打印值：( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
```

## 安装

### 通过 CocoaPods 集成

安装最新版的 CocoaPods：

```bash
$ gem install cocoapods
```

在 `podfile` 中添加：

```ruby
pod 'NNDecimalNumber', '~> 2.0.1'
```

然后在终端执行：

```bash
$ pod install
```

如安装失败，提示：

```bash
[!] Unable to find a specification for `NNDecimalNumber`
```

尝试使用命令：

```bash
pod install --repo-update
```

### 通过 Carthage 集成

[Carthage](https://github.com/Carthage/Carthage) 是一个去中心化的依赖管理器，用于构建依赖和提供二进制 Framework 。

可以通过以下 [Homebrew](http://brew.sh/) 命令安装 Carthage ：

```bash
$ brew update
$ brew install carthage
```

通过 Carthage 将 NNDecimalNumber 集成到 Xcode 项目中，需要在 `Cartfile` 中添加：

```ogdl
github "amisare/NNDecimalNumber" ~> 2.0.1
```

执行 `carthage` 构建 Framework ，并将 `NNDecimalNumber.framework` 添加到 Xcode 项目中。

## 其他
Inspiration [RLArithmetic](https://github.com/RylynnLai/RLArithmetic)

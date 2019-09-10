<h1 align = "center">NNDecimalNumber</h1>

[![GitHub release](https://img.shields.io/github/release/amisare/NNDecimalNumber.svg)](https://github.com/amisare/NNDecimalNumber/releases)
[![CocoaPods](https://img.shields.io/cocoapods/v/NNDecimalNumber.svg)](https://cocoapods.org/pods/NNDecimalNumber)
[![CocoaPods](https://img.shields.io/cocoapods/p/NNDecimalNumber.svg)](https://cocoapods.org/pods/NNDecimalNumber)
[![GitHub license](https://img.shields.io/github/license/amisare/NNDecimalNumber.svg)](https://github.com/amisare/NNDecimalNumber/blob/master/LICENSE)

## 介绍

提供 NNString， NSNumber 的 NSDecimalNumber 的计算及比较`分类` ，通过链式调用简化数值计算。

## 使用

- 示例一：全部使用 NSNumber 计算

```
    //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
    NSString *c = @(3).nn_add(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2)));
```

- 示例二：全部使用 NSString 计算

```
    //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
    NSString *c = @"3".nn_add(@"2").nn_add(@"5").nn_mul(@"3").nn_mul(@"10".nn_mul(@"2"));
```

- 示例三：使用 NSNumber 与 NSString 混合计算

```
    //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
    NSString *c = @(3).nn_add(@"2").nn_add(@(5)).nn_mul(@"3").nn_mul(@(10).nn_mul(@"2"));
```

- 示例四：幂运算

```
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) ^ 2 )
        NSString *c = @"2".nn_mul(@(5)).nn_add(@"2".nn_mul(@"2")).nn_power(@(2));
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) × 10 ^ 2 )
        NSString *c = @(2).nn_mul(@"5").nn_add(@"2".nn_mul(@(2))).nn_mulPowerOf10(@(2));
    }
```

- 示例五：数值比较

```
    NSString *c0 = @"100";
    NSNumber *c1 = @(100.1);
    if ([c0 nn_decimalIsEqualTo:c1]) {
        NSLog(@"c == c1");
    }
    else if ([c0 nn_decimalIsGreaterThan:c1]) {
        NSLog(@"c > c1");
    }
    else if ([c0 nn_decimalIsGreaterThanOrEqualTo:c1]) {
        NSLog(@"c >= c1");
    }
    else if ([c0 nn_decimalIsLessThan:c1]) {
        NSLog(@"c < c1");
    }
```

- 示例六：设置 NSDecimalNumberBehaviors

```
    // 设置全局 NSDecimalNumberBehaviors
    {
        [NSString nn_setDecimalNumberGlobalBehavior:[DecimalNumberGlobalBehavior class]];
        NSString *c = @"1".nn_div(@(3));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    // 当前计算式 NSDecimalNumberBehaviors
    {
        DecimalNumberBehavior *behavior = [DecimalNumberBehavior new];
        NSString *c = @"1".nn_behavior(behavior).nn_div(@(3)).nn_div(@(2));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    // 使用 NSDecimalNumberHandler
    {
        NSDecimalNumberHandler *behavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain
                                                                                          scale:4
                                                                               raiseOnExactness:false
                                                                                raiseOnOverflow:false
                                                                               raiseOnUnderflow:false
                                                                            raiseOnDivideByZero:false];
        NSString *c = @"1".nn_behavior(behavior).nn_div(@(3));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
```

- 示例六：异常计算（异常计算结果统一为字符串：@"NaN"，即`[[NSDecimalNumber notANumber] stringValue]`）

```
    {
        //( 2 × [UIView new] )
        NSString *c = @"2".nn_mul([UIView new]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( 2 / 0 )
        NSString *c = @"2".nn_div(@"0");
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / nil )
        NSString *c =  NN_Trust(nil).nn_div(nil);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / 0 )
        NSString *c =  NN_Trust(nil).nn_div(@(0));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / [UIView new] )
        NSString *c =  NN_Trust(nil).nn_div([UIView new]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / [NSNull null] )
        NSString *c =  NN_Trust(nil).nn_div([NSNull null]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / [NSNull null] )
        NSString *c =  NN_Trust([NSNull null]).nn_div([NSNull null]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / 0 )
        NSString *c =  NN_Trust([NSNull null]).nn_div(@(0));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / [UIView new] )
        NSString *c =  NN_Trust([NSNull null]).nn_div([UIView new]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / nil )
        NSString *c =  NN_Trust([NSNull null]).nn_div(nil);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
```

- 示例七：计算式输出

```
    //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
    NSString *c = @(3).nn_add(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2)));
    NSLog(@"%@", c.nn_formula); //打印值：( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
```

## 安装

### CocoaPods

安装最新版的 CocoaPods：

```bash
$ gem install cocoapods
```

在 `podfile` 中添加：

```ruby
pod 'NNDecimalNumber', '~> 1.1.0'
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

## 其他
Inspiration [RLArithmetic](https://github.com/RylynnLai/RLArithmetic)

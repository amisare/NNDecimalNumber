# NNDecimalNumber

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
    if ([c0 nn_isEqualTo:c1]) {
        NSLog(@"c == c1");
    }
    else if ([c0 nn_isGreaterThan:c1]) {
        NSLog(@"c > c1");
    }
    else if ([c0 nn_isGreaterThanOrEqualTo:c1]) {
        NSLog(@"c >= c1");
    }
    else if ([c0 nn_isLessThan:c1]) {
        NSLog(@"c < c1");
    }
```

- 示例六：异常计算（异常计算结果统一为字符串：@"NaN"，即`[[NSDecimalNumber notANumber] stringValue]`）

```
    //( 2 × [UIView new] )
    NSString *c = @"2".nn_mul([UIView new]);
    NSLog(@"%@", c); //打印值：NaN
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
pod 'NNDecimalNumber', '~> 0.1.0'
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

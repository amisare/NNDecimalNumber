//
//  NNDecimalNumber.h
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for NNDecimalNumber.
FOUNDATION_EXPORT double NNDecimalNumberVersionNumber;

//! Project version string for NNDecimalNumber.
FOUNDATION_EXPORT const unsigned char NNDecimalNumberVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <NNDecimalNumber/PublicHeader.h>

@protocol NNDecimalNumberGlobalBehavior <NSObject>

/// 设置 DecimalNumber 运算中 Rounding 和 Exception 的处理类
/// @discussion 不设置，默认使用 NNDecimalNumberDefaultBehavior 类
/// @param decimalNumberGlobalBehavior 参数类必须遵守 NSDecimalNumberBehaviors 协议
+ (void)nn_setDecimalNumberGlobalBehavior:(Class)decimalNumberGlobalBehavior;

/// 获取 DecimalNumber 运算中 Rounding 和 Exception 的处理类
/// @return decimalNumberBehaviors 类
+ (Class)nn_decimalNumberGlobalBehavior;

@end

@protocol NNDecimalNumber <NSObject>

@property (nonatomic, copy, readonly) NSString *(^nn_behavior)(id <NSDecimalNumberBehaviors>);

@property (nonatomic, copy, readonly) NSString *(^nn_add)(id value);
@property (nonatomic, copy, readonly) NSString *(^nn_sub)(id value);
@property (nonatomic, copy, readonly) NSString *(^nn_mul)(id value);
@property (nonatomic, copy, readonly) NSString *(^nn_div)(id value);
@property (nonatomic, copy, readonly) NSString *(^nn_power)(id value);
@property (nonatomic, copy, readonly) NSString *(^nn_mulPowerOf10)(id value);

@end

@protocol NNDecimalNumberFormula <NSObject>

/// 运算公式
@property (nonatomic, copy, readonly) NSString *nn_formula;

@end

@protocol NNDecimalNumberCompare <NSObject>

/// 以下方法基于 NSNumber compare: 实现
- (NSComparisonResult)nn_decimalCompare:(id)value;
- (BOOL)nn_decimalIsEqualTo:(id)value;
- (BOOL)nn_decimalIsGreaterThan:(id)value;
- (BOOL)nn_decimalIsGreaterThanOrEqualTo:(id)value;
- (BOOL)nn_decimalIsLessThan:(id)value;
- (BOOL)nn_decimalIsLessThanOrEqualTo:(id)value;

@end

@interface NSObject (NNDecimalNumber) <NNDecimalNumber, NNDecimalNumberCompare, NNDecimalNumberFormula, NNDecimalNumberGlobalBehavior>
@end

/// 防止空对象安全函数
/// @param value 非空对象
NS_INLINE NSObject *NN_Trust(id value) {
    if (value == nil) {
        return [NSMutableString stringWithString:[[NSDecimalNumber notANumber] stringValue]];
    }
    return value;
}

/// NaN 值判断
/// @param value 运算值
NS_INLINE BOOL NN_isNaN(id value) {
    if (value == nil) {
        return true;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSDecimalNumber *d = [NSDecimalNumber decimalNumberWithString:value];
        if (![[NSDecimalNumber notANumber] isEqualToNumber:d]) {
            return false;
        }
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        if (![[NSDecimalNumber notANumber] isEqualToNumber:value]) {
            return false;
        }
    }
    return true;
    
}

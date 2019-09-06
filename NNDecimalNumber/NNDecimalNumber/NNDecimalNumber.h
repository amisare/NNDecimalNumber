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

/**
 设置 DecimalNumber 计算中 Rounding 和 Exception 的处理类
 
 @discussion 不设置，默认使用 NNDecimalNumberDefaultBehavior 类
 @param decimalNumberGlobalBehavior 参数类必须遵守 NSDecimalNumberBehaviors 协议
 */
+ (void)nn_setDecimalNumberGlobalBehavior:(Class)decimalNumberGlobalBehavior;

/**
 获取 DecimalNumber 计算中 Rounding 和 Exception 的处理类

 @return decimalNumberBehaviors 类
 */
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

@property (nonatomic, copy, readonly) NSString *nn_formula;

@end

@protocol NNDecimalNumberCompare <NSObject>

- (NSComparisonResult)nn_decimalCompare:(id)value;
- (BOOL)nn_decimalIsEqualTo:(id)value;
- (BOOL)nn_decimalIsGreaterThan:(id)value;
- (BOOL)nn_decimalIsLessThan:(id)value;
- (BOOL)nn_decimalIsGreaterThanOrEqualTo:(id)value;
- (BOOL)nn_decimalIsLessThanOrEqualTo:(id)value;

@end

@interface NSString (NNDecimalNumber) <NNDecimalNumber, NNDecimalNumberCompare, NNDecimalNumberFormula, NNDecimalNumberGlobalBehavior>
@end

@interface NSNumber (NNDecimalNumber) <NNDecimalNumber, NNDecimalNumberCompare>
@end

@interface NSDecimalNumber (NNDecimalNumber) <NNDecimalNumberCompare>
@end


NS_INLINE NSString *NN_Trust(id value) {
    if (value == nil) {
        return [NSMutableString stringWithString:[[NSDecimalNumber notANumber] stringValue]];
    }
    if ([value isKindOfClass:[NSString class]]) {
        if ([value isKindOfClass:[NSMutableString class]]) {
            return value;
        }
        else {
            return [NSMutableString stringWithString:value];
        }
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSMutableString stringWithString:[value stringValue]];
    }
    return [NSMutableString stringWithString:[value description]];
}

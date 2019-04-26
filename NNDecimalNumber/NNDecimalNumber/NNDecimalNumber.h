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

@protocol NNDecimalNumberBehaviors <NSObject>

/**
 设置 DecimalNumber 计算中 Rounding 和 Exception 的处理类
 
 @discussion 不设置，默认使用 NNDecimalNumberHandler 类
 @param decimalNumberBehaviors 参数类必须遵守 NSDecimalNumberBehaviors 协议
 */
+ (void)nn_setDecimalNumberBehaviors:(Class)decimalNumberBehaviors;

/**
 获取 DecimalNumber 计算中 Rounding 和 Exception 的处理类

 @return decimalNumberBehaviors 类
 */
+ (Class)nn_decimalNumberBehaviors;

@end

@protocol NNDecimalNumber <NSObject>

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

- (BOOL)nn_isEqualTo:(id)value;
- (BOOL)nn_isGreaterThan:(id)value;
- (BOOL)nn_isLessThan:(id)value;
- (BOOL)nn_isGreaterThanOrEqualTo:(id)value;
- (BOOL)nn_isLessThanOrEqualTo:(id)value;
- (NSComparisonResult)nn_compare:(id)value;

@end

@interface NSString (NNDecimalNumber) <NNDecimalNumber, NNDecimalNumberCompare, NNDecimalNumberFormula, NNDecimalNumberBehaviors>

@end

@interface NSNumber (NNDecimalNumber) <NNDecimalNumber, NNDecimalNumberCompare>

@end

@interface NSDecimalNumber (NNDecimalNumber) <NNDecimalNumberCompare>

@end



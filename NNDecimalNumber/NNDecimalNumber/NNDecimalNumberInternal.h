//
//  NNDecimalNumberInternal.h
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/25.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#ifndef NNDecimalNumberInternal_h
#define NNDecimalNumberInternal_h

@interface NSString (NNDecimalNumberFormulaStack)

@property (nonatomic, copy) NSArray *nn_formulaStack;

@end

@interface NSDecimalNumber (NNDecimalNumberStringValue)

@property (nonatomic, copy) NSString *nn_stringValue;

@end

/**
 value 转 字符串
 
 @param value 数字字符串，或 NSNumber
 @return 字符串
 */
NS_INLINE NSString *__nn_stringWithValue(id value) {
    NSString *ret = nil;
    if ([value isKindOfClass:[NSString class]]) {
        ret = value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        ret = [value nn_stringValue];
    }
    else {
        ret = [NSMutableString stringWithString:[value description]];
    }
    return ret;
}

/**
 value 转 NSDecimalNumber
 
 @param value 数字字符串，或 NSNumber
 @return NSDecimalNumber
 */
NS_INLINE NSDecimalNumber *__nn_decimalNumberWithValue(id value) {
    if ([value isKindOfClass:[NSString class]]) {
        return [NSDecimalNumber decimalNumberWithString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
    }
    return [NSDecimalNumber notANumber];
}

/**
 解析计算栈

 @param formulaStack 计算栈
 @return 计算公式字符串
 */
NS_INLINE NSString *__nn_formulaFromFormulaStack(NSArray *formulaStack) {
    NSMutableString *formula = [NSMutableString new];
    [formula appendString:@"("];
    [formula appendString:@" "];
    if (formulaStack) {
        for (id f in formulaStack) {
            if ([f isKindOfClass:[NSString class]]) {
                [formula appendString:f];
                [formula appendString:@" "];
            }
            else {
                [formula appendString:__nn_formulaFromFormulaStack(f)];
                [formula appendString:@" "];
            }
        }
    }
    [formula appendString:@")"];
    return formula;
}


#endif /* NNDecimalNumberInternal_h */

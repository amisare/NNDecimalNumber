//
//  NNDecimalNumberInternal.h
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/25.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#ifndef NNDecimalNumberInternal_h
#define NNDecimalNumberInternal_h

#import "NSObject+NNDecimalNumberBehavior.h"
#import "NSObject+NNDecimalNumberFormulaStack.h"

/// value 转 NSDecimalNumber
/// @param value 数字字符串或 NSNumber
/// @return NSDecimalNumber
NS_INLINE NSDecimalNumber *__nn_decimalNumberWithValue(id value) {
    if ([value isKindOfClass:[NSString class]]) {
        return [NSDecimalNumber decimalNumberWithString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
    }
    return [NSDecimalNumber notANumber];
}

/// 解析运算栈
/// @param formulaStack 运算公式栈
/// @return 运算公式字符串
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

/// value 转 NSMutableString
/// @discussion 检查入参值 value ，进行判空和类型转换，最终返回值类型为 NSMutableString 。value 为 nil 返回字符串 NaN ，除 NSMutableString 、NSString 、NSNumber 之外的类型返回实例的 description 。
/// @param value 入参值
/// @return 返回 NSMutableString 值
NS_INLINE NSMutableString *__nn_convertToMutableString(id value) {
    if (value == nil) {
        return [NSMutableString stringWithString:[[NSDecimalNumber notANumber] stringValue]];
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSMutableString *mValue = [NSMutableString stringWithString:value];
        mValue.nn_formulaStack = [value nn_formulaStack];
        mValue.nn_decimalNumberBehavior = [value nn_decimalNumberBehavior];
        return mValue;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSMutableString stringWithString:[value stringValue]];
    }
    return [NSMutableString stringWithString:[value description]];
}


/// 运算类型
typedef NS_ENUM(NSUInteger, NNDecimalNumberOperatorType) {
    NNDecimalNumberOperatorTypeAdd,
    NNDecimalNumberOperatorTypeSub,
    NNDecimalNumberOperatorTypeMul,
    NNDecimalNumberOperatorTypeDiv,
    NNDecimalNumberOperatorTypePower,
    NNDecimalNumberOperatorTypeMulPowerOf10,
};

/// 运算函数
/// @param operatorType 运算类型
/// @param l 运算符左侧运算值
/// @param r 运算符右侧运算值
NS_INLINE NSMutableString *__nn_calculate(NNDecimalNumberOperatorType operatorType, id l, id r) {
    
    NSString *ls = __nn_convertToMutableString(l);
    NSString *rs = __nn_convertToMutableString(r);
    
    NSDecimalNumber *ld = [NSDecimalNumber decimalNumberWithString:ls];
    NSDecimalNumber *rd = [NSDecimalNumber decimalNumberWithString:rs];
    NSDecimalNumber *xd = [NSDecimalNumber notANumber];
    
    NSMutableArray *formulaStack = ({
        NSMutableArray *formulaStack = [NSMutableArray new];
        if (ls.nn_formulaStack) {
            [formulaStack addObjectsFromArray:ls.nn_formulaStack];
        }
        else {
            [formulaStack addObject:ls];
        }
        formulaStack;
    });
    
    id <NSDecimalNumberBehaviors> behavior = ({
        id <NSDecimalNumberBehaviors> behavior = ls.nn_decimalNumberBehavior;
        if (ls.nn_decimalNumberBehavior == nil) {
            behavior = [[NSObject nn_decimalNumberGlobalBehavior] new];
        }
        behavior;
    });
    
    switch (operatorType) {
        case NNDecimalNumberOperatorTypeAdd:
            [formulaStack addObject:@"+"];
            xd = [ld decimalNumberByAdding:rd withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeSub:
            [formulaStack addObject:@"-"];
            xd = [ld decimalNumberBySubtracting:rd withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeMul:
            if (ls.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"×"];
            xd = [ld decimalNumberByMultiplyingBy:rd withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeDiv:
            if (ls.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"÷"];
            xd = [ld decimalNumberByDividingBy:rd withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypePower:
            if (ls.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"^"];
            xd = [ld decimalNumberByRaisingToPower:[rd unsignedIntegerValue] withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeMulPowerOf10:
            if (ls.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"× 10 ^"];
            xd = [ld decimalNumberByMultiplyingByPowerOf10:[rd shortValue] withBehavior:behavior];
            break;
    }
    
    NSMutableString *xs = [NSMutableString stringWithString:[xd stringValue]];
    
    xs.nn_decimalNumberBehavior = behavior;
    
    if (rs.nn_formulaStack) {
        [formulaStack addObject:rs.nn_formulaStack];
    }
    else {
        [formulaStack addObject:rs];
    }
    xs.nn_formulaStack = formulaStack;
    
    return xs;
}

#endif /* NNDecimalNumberInternal_h */

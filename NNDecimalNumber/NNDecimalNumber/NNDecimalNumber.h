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

+ (void)nn_setDecimalNumberBehaviors:(Class)decimalNumberBehaviors;
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



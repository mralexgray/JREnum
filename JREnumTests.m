
#import <XCTest/XCTest.h>
#import "JREnum.h"

#define XCTAssertEqualStrings(A,B,...) XCTAssertTrue([A isEqualToString:B] __VA_ARGS__)

JREnumDeclare(SplitEnumWith1ConstantSansExplicitValues,
              SplitEnumWith1ConstantSansExplicitValues_Constant1);

JREnumDeclare(SplitEnumWith2ConstantsSansExplicitValues,
              SplitEnumWith2ConstantsSansExplicitValues_Constant1,
              SplitEnumWith2ConstantsSansExplicitValues_Constant2);

JREnumDeclare(SplitEnumWith1ConstantWithExplicitValues,
              SplitEnumWith1ConstantWithExplicitValues_Constant1 = 42);

JREnumDeclare(TestClassState, TestClassState_Closed, TestClassState_Opening, TestClassState_Open, TestClassState_Closing);

JREnumDeclare(Align, AlignLeft         = 1 << 0,
                     AlignRight        = 1 << 1,
                     AlignTop          = 1 << 2,
                     AlignBottom       = 1 << 3,
                     AlignTopLeft      = 0x05,
                     AlignBottomLeft   = 0x09,
                     AlignTopRight     = 0x06,
                     AlignBottomRight  = 0x0A );

JREnumDefine(SplitEnumWith1ConstantSansExplicitValues);
JREnumDefine(SplitEnumWith2ConstantsSansExplicitValues);
JREnumDefine(SplitEnumWith1ConstantWithExplicitValues);
JREnumDefine(TestClassState);
JREnumDefine(Align);

JREnum(EnumWith1ConstantSansExplicitValues,              EnumWith1ConstantSansExplicitValues_Constant1);
JREnum(EnumWith1ConstantSansExplicitValuesTrailingComma, EnumWith1ConstantSansExplicitValuesTrailingComma_Constant1, );
JREnum(EnumWith1ConstantWithExplicitValues,              EnumWith1ConstantWithExplicitValues_Constant1 = 42);

JREnum(EnumWith3BitshiftConstants,
       EnumWith2BitshiftConstants_1           = 1 << 0,
       EnumWith2BitshiftConstants_2           = 1 << 1,
       EnumWith2BitshiftConstants_4           = 1 << 2,
       EnumWith2BitshiftConstants_1073741824  = 1 << 30);


@interface      JREnumTests : XCTestCase  @end
@implementation JREnumTests

- (void) runTests {

  XCTAssertEqual(EnumWith1ConstantSansExplicitValuesByLabel().count, 1);
  XCTAssertTrue([EnumWith1ConstantSansExplicitValuesByLabel()[@"EnumWith1ConstantSansExplicitValues_Constant1"] isEqual:@0]);

  XCTAssertEqual(EnumWith1ConstantSansExplicitValuesByValue().count, 1);
  XCTAssertTrue([EnumWith1ConstantSansExplicitValuesByValue()[@0]
       isEqual:@"EnumWith1ConstantSansExplicitValues_Constant1"]);

  EnumWith1ConstantSansExplicitValues a = 0;

  XCTAssertEqual(EnumWith1ConstantSansExplicitValues_Constant1,a);
  XCTAssertEqualStrings(@"EnumWith1ConstantSansExplicitValues_Constant1", EnumWith1ConstantSansExplicitValuesToString(a));

  
XCTAssertTrue(EnumWith1ConstantSansExplicitValuesFromString(EnumWith1ConstantSansExplicitValuesToString(EnumWith1ConstantSansExplicitValues_Constant1), 
&a));
  XCTAssertEqual(EnumWith1ConstantSansExplicitValues_Constant1, a);

  a++;
  XCTAssertEqualStrings(@"<unknown EnumWith1ConstantSansExplicitValues: 1>", EnumWith1ConstantSansExplicitValuesToString(a));

  XCTAssertTrue(!EnumWith1ConstantSansExplicitValuesFromString(@"foo", &a));

  XCTAssertEqual(EnumWith1ConstantSansExplicitValuesTrailingCommaByLabel().count, 1);
}
- (void) testSplitEnumWith1ConstantSansExplicitValues {

  SplitEnumWith1ConstantSansExplicitValues a = 0; unsigned int b = 99;

  XCTAssertEqual(SplitEnumWith1ConstantSansExplicitValues_Constant1, a);
  XCTAssertEqualStrings(@"SplitEnumWith1ConstantSansExplicitValues_Constant1",
                          SplitEnumWith1ConstantSansExplicitValuesToString(a));

  NSString *byValue = SplitEnumWith1ConstantSansExplicitValuesToString(SplitEnumWith1ConstantSansExplicitValues_Constant1);

  SplitEnumWith1ConstantSansExplicitValuesFromString(byValue,&b);

  XCTAssertTrue(b != 99, @"should init");
  XCTAssertEqual(SplitEnumWith1ConstantSansExplicitValues_Constant1, a);

  a++;

  XCTAssertEqualStrings(@"<unknown SplitEnumWith1ConstantSansExplicitValues: 1>",
                            SplitEnumWith1ConstantSansExplicitValuesToString(a));

  XCTAssertTrue(!SplitEnumWith1ConstantSansExplicitValuesFromString(@"foo", &a));

  XCTAssertEqual( SplitEnumWith1ConstantSansExplicitValuesByLabel().count, 1);
  XCTAssertEqual(SplitEnumWith2ConstantsSansExplicitValuesByLabel().count, 2);
}

- (void) testSplitEnumWith1ConstantWithExplicitValues {

  SplitEnumWith1ConstantWithExplicitValues a = 42;

  XCTAssertEqual(SplitEnumWith1ConstantWithExplicitValues_Constant1, a);
  XCTAssertEqualStrings(@"SplitEnumWith1ConstantWithExplicitValues_Constant1", SplitEnumWith1ConstantWithExplicitValuesToString(a));

  NSString *byValue = SplitEnumWith1ConstantWithExplicitValuesToString(SplitEnumWith1ConstantWithExplicitValues_Constant1);

  XCTAssertTrue(SplitEnumWith1ConstantWithExplicitValuesFromString(byValue,&a));
  XCTAssertEqual(SplitEnumWith1ConstantWithExplicitValues_Constant1, a);

  a++;

  XCTAssertEqualStrings(@"<unknown SplitEnumWith1ConstantWithExplicitValues: 43>",
                                   SplitEnumWith1ConstantWithExplicitValuesToString(a));
  XCTAssertTrue(!SplitEnumWith1ConstantWithExplicitValuesFromString(@"foo", &a));
}

- (void) testEnumWith3BitshiftConstants {

  XCTAssertEqual(EnumWith3BitshiftConstantsByLabel().count, 4);

  XCTAssertEqual(EnumWith2BitshiftConstants_1, 1);
  XCTAssertEqualStrings(EnumWith3BitshiftConstantsToString(EnumWith2BitshiftConstants_1),
                                                         @"EnumWith2BitshiftConstants_1");
  XCTAssertEqual(EnumWith2BitshiftConstants_2, 2);
  XCTAssertEqualStrings(EnumWith3BitshiftConstantsToString(EnumWith2BitshiftConstants_2),
                                                         @"EnumWith2BitshiftConstants_2");
  XCTAssertEqual(EnumWith2BitshiftConstants_4, 4);
  XCTAssertEqualStrings(EnumWith3BitshiftConstantsToString(EnumWith2BitshiftConstants_4),
                                                         @"EnumWith2BitshiftConstants_4");

  XCTAssertEqual(EnumWith2BitshiftConstants_1073741824,1073741824);
  XCTAssertEqualStrings(EnumWith3BitshiftConstantsToString(EnumWith2BitshiftConstants_1073741824),
                                                         @"EnumWith2BitshiftConstants_1073741824");

  XCTAssertEqualStrings(@"<unknown EnumWith3BitshiftConstants: 3>",
                            EnumWith3BitshiftConstantsToString(3));

  EnumWith3BitshiftConstants value;

  XCTAssertTrue(EnumWith3BitshiftConstantsFromString(@"EnumWith2BitshiftConstants_1", &value));
  XCTAssertEqual(EnumWith2BitshiftConstants_1, value);
  XCTAssertTrue(!EnumWith3BitshiftConstantsFromString(@"bogus", &value));
}

- (void) testAligns {

  XCTAssertEqualStrings(@"AlignLeft",        AlignToString( 1 << 0 ));
  XCTAssertEqualStrings(@"AlignRight",       AlignToString( 1 << 1 ));
  XCTAssertEqualStrings(@"AlignTop",         AlignToString( 1 << 2 ));
  XCTAssertEqualStrings(@"AlignBottom",      AlignToString( 1 << 3 ));

  XCTAssertEqualStrings(@"AlignTopLeft",     AlignToString(    AlignTop | AlignLeft  ));
  XCTAssertEqualStrings(@"AlignBottomLeft",  AlignToString( AlignBottom | AlignLeft  ));
  XCTAssertEqualStrings(@"AlignTopRight",    AlignToString(    AlignTop | AlignRight ));
  XCTAssertEqualStrings(@"AlignBottomRight", AlignToString( AlignBottom | AlignRight ));

  Align a;
  XCTAssertTrue(AlignFromString(AlignToString(AlignLeft), &a));
  XCTAssertEqual(AlignLeft,a);

  XCTAssertEqualStrings(@"<unknown Align: 3>", AlignToString(3));
}

@end

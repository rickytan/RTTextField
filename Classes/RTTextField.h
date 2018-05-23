// RTTextField.h
// 
// Copyright (c) 2018年 XcoderTips
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface RTTextField : UITextField

@property (nonatomic, assign) IBInspectable NSUInteger maximumLength;   // Default 0, unlimited

@property (nonatomic, assign) IBInspectable NSUInteger maximumComposedCharacterLength;  // Default 0, unlimited

@property (nonatomic, copy) IBInspectable NSString *inputPattern;

- (BOOL)validateText:(NSString *)text;

@end

#define RT_DEFINE_INPUT_PATTERN(name, pattern) static NSString *const name = @"^"pattern"$";

RT_DEFINE_INPUT_PATTERN(RTInputTypeAlphabet, "[a-zA-Z]*")
RT_DEFINE_INPUT_PATTERN(RTInputTypeAlphanumeric, "\\w*")
RT_DEFINE_INPUT_PATTERN(RTInputTypeDigit, "\\d*")
RT_DEFINE_INPUT_PATTERN(RTInputTypeNickname, "[^`@!#$%^&*()+={}|[];:'\",.<>/?\\ ]*")
RT_DEFINE_INPUT_PATTERN(RTInputTypeChineseCellPhone, "(1\\d{0,10})?")
RT_DEFINE_INPUT_PATTERN(RTInputTypeChineseSimplified, "[ a-z\u4E00-\u9FA5]*")
RT_DEFINE_INPUT_PATTERN(RTInputTypePrice, "(0|[1-9]\\d*)?(\\.\\d{0,2})?")
RT_DEFINE_INPUT_PATTERN(RTInputTypeNonnegtiveInterger, "(0|[1-9]\\d*)?")
RT_DEFINE_INPUT_PATTERN(RTInputTypeNonnegtiveFloat, "(0|[1-9]\\d*)?(\\.\\d*)?")


@interface NSString (RTTextField)

/**
 * @description @b NSString use UTF-16 encode to store characters internally, in
 * most cast, the @c length of a @b NSString is the number visible characters.
 * But not for some special Characters like Emoji.
 * @"😃🤡⛹🏿‍♀️⚫️🤥🤕💪🏾" this @b NSString only has 7 Emojis, but its @c length is
 * 20. Sometimes we only want the human visible charater count.
 *
 * @code
 * @"😃🤡⛹🏿‍♀️⚫️🤥🤕💪🏾".length == 20
 * @"😃🤡⛹🏿‍♀️⚫️🤥🤕💪🏾".rt_composedCharacterLength == 7
 *
 * ++ ++ ++++++ ++ ++ ++ ++++
 * 😃 🤡 ⛹🏿‍♀️    ⚫️ 🤥 🤕 💪🏾
 * @endcode
 *
 *
 * @return number of visible charaters
 * @warning Emoji is System sensitive, and its behavior differ on different
 * systems, so dose this property.
 */
@property (nonatomic, assign, readonly) NSUInteger rt_composedCharacterLength;
@end

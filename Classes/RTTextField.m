// RTTextField.m
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

#import "RTTextField.h"

@interface RTTextField ()
@property (nonatomic, strong) NSRegularExpression *regexp;
@end

@implementation RTTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (void)setInputPattern:(NSString *)inputPattern
{
    if (![_inputPattern isEqualToString:inputPattern]) {
        _inputPattern = [inputPattern copy];

        NSError *error = nil;
        self.regexp = [NSRegularExpression regularExpressionWithPattern:_inputPattern
                                                                options:0
                                                                  error:&error];
#ifdef DEBUG
        if (error) {
            NSLog(@"%@", error);
        }
#endif
    }
}

- (BOOL)validateText:(NSString *)text
{
    if (self.maximumLength > 0 && text.length > self.maximumLength) {
        return NO;
    }
    if (self.maximumComposedCharacterLength > 0 && text.rt_composedCharacterLength > self.maximumComposedCharacterLength) {
        return NO;
    }
    
    if (self.regexp) {
        return [self.regexp firstMatchInString:text options:0 range:NSMakeRange(0, text.length)] != nil;
    }
    return YES;
}

- (BOOL)keyboardInput:(UITextField *)textField shouldInsertText:(NSString *)text isMarkedText:(BOOL)marked
{
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger length = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];

    NSString *proposedText = [self.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:text];

    if (![self validateText:proposedText]) {
        return NO;
    }

    IMP imp = [[self.class superclass] instanceMethodForSelector:_cmd];
    return ((BOOL (*)(id, SEL, id, id, BOOL))imp)(self, _cmd, textField, text, marked);
}

- (BOOL)keyboardInput:(UITextField *)textField shouldReplaceTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *proposedText = [self.text stringByReplacingCharactersInRange:range withString:text];

    if (![self validateText:proposedText]) {
        return NO;
    }

    IMP imp = [[self.class superclass] instanceMethodForSelector:_cmd];
    return ((BOOL (*)(id, SEL, id, NSRange, id))imp)(self, _cmd, textField, range, text);
}

- (BOOL)fieldEditor:(id)editor shouldInsertText:(NSString *)text replacingRange:(NSRange)range
{
    NSString *proposedText = [self.text stringByReplacingCharactersInRange:range withString:text];

    if (![self validateText:proposedText]) {
        return NO;
    }

    IMP imp = [[self.class superclass] instanceMethodForSelector:_cmd];
    return ((BOOL (*)(id, SEL, id, id, NSRange))imp)(self, _cmd, editor, text, range);
}

@end


@implementation NSString (RTTextField)

- (NSUInteger)rt_composedCharacterLength __attribute((const))
{
    NSUInteger numberOfComposedCharaters = 0;

    NSUInteger length = self.length;
    while (length > 0) {
        NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:length - 1];
        length -= range.length;
        ++ numberOfComposedCharaters;
    }
    return numberOfComposedCharaters;
}

@end

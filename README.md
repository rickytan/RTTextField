# RTTextField
## Introduction
This is a drop-in replacement for UITextField with input limitation, which means a user can't input arbitrary text anymore. You may point out that is pretty easy to do it with implementing the **delegate** method:

```objc
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
```

Yeah, right. But as a common UI component, this method should not be used internally, in case developers may use it for some other requirements. So my solution is to override some **private** methods:

```objc
- (BOOL)keyboardInput:(UITextField *)textField shouldInsertText:(NSString *)text isMarkedText:(BOOL)marked;

- (BOOL)keyboardInput:(UITextField *)textField shouldReplaceTextInRange:(NSRange)range replacementText:(NSString *)text;

- (BOOL)fieldEditor:(id)editor shouldInsertText:(NSString *)text replacingRange:(NSRange)range;
```

These methods are not officially documented by Apple, but it will be invoked by **iOS** system at some point while you typing with keyboard.

> **Notice:** These methods are not invoked when user select the input prediction words from the candidate list above the keyboard, so sometimes user may type in some thing that is not allowed. This can be solved by changing the keyboard type and disable auto-correction & spell-checking

And it is safe to override these method, because I'm not call them directly.

## Usage

It's quite simple to use, just create a instance, and set your pattern:

```objc
RTTextField *textField = [RTTextField new];
textField.inputPattern = ...; // Regular expression
```

This project already provides some useful patterns for your:

* `RTInputTypeAlphabet`, user can only type in **a-zA-Z**
* `RTInputTypeAlphanumeric `, user can only type in **0-9a-zA-Z_**
* `RTInputTypeDigit`, user can only type in **0-9**
* ​ `RTInputTypeNickname`, user can only type in a nickname, a nickname may not contain **space**, **@**, **#**, **()**, and so on
*  `RTInputTypeChineseCellPhone`, a Chinese cell phone number is a 11-digits number start with 1
* ~~`RTInputTypeChineseSimplified`~~, user can only type in simplified Chinese. Note that in order to allow user s to input with Pinyin, this pattern has to allow type in **a-z** and **non-breaking space** `\u+00A0`
*  `RTInputTypePrice`, a price is a non-negtive decimal with two decimal places, and start with two or more **0** is not allowed. `0.00`👍, ~~`00.12`~~👎
*  `RTInputTypeNonnegtiveInterger`
*  `RTInputTypeNonnegtiveFloat` 

## Demo

![demo](https://user-images.githubusercontent.com/1250207/41805231-49424546-76d8-11e8-9746-ee1f7d90a843.gif)

## License

**MIT**
### KeyboardMonitor

监听键盘显示、高度变化、消失的事件并反馈给调用者

#### 使用方法 
将`KeyboardMonitor.h`和`KeyboardMonitor.m`两个文件导入你的工程，然后在使用的地方`import`头文件。

下面是`Objective-C`使用的例子：
```objc

// 注册代理并实现协议方法实现监听
[KeyboardMonitor sltObject].delegate = self;
- (void)keyBoardWillChanged:(CGFloat)deviant {
        // Do Something...
}
- (void)keyBoardWillDismiss {
        // Do Something...
}

Or

// 注册block回调实现监听
[KeyboardMonitor sltObject].keyboardChanged = ^(CGFloat deviant) {
        // Do Something...
};
[KeyboardMonitor sltObject].keyboardDismiss = ^{
        // Do Something...
};


// 获取输入框控件(这里以UITextField为例)相对Window的坐标
UIWindow *window = [UIApplication sharedApplication].delegate.window;
[KeyboardMonitor sltObject].targetBounds = [textField convertRect:textField.bounds toView:window];

### Demo
更详细的使用可以通过使用Demo理解。

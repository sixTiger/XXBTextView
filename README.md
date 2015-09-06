# XXBTextView
## 好用的textView 跟系统的一样好用,多了一个占位文本，代理方法之类的完全是对系统的相关方法进行了一次嫁接。
```c
    self.textView = [[XXBTextView alloc] initWithFrame:CGRectMake(10, 64, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    [self.view addSubview:self.textView];
    self.textView.font = [UIFont systemFontOfSize:20];
    self.textView.text = @"a";
    self.textView.placeHoder = @"请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入";
    self.textView.placeHoderColor = [UIColor grayColor];
```

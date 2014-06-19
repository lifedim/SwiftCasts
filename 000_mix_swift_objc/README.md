# Swift与Objective-C混用简明教程

我想很多iOS开发者在知道Swift后，心中最大的问题就是如何将Swift应用到原有项目之中。下面我将简要介绍这2种语言的混用方法，内容参考自官方文档 [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/buildingcocoaapps/index.html) ，推荐大家阅读。


## 在Swift中使用Objective-C类

- 在Xcode6中新建文件(⌘+N)，选择Swift，然后系统框提示是否同时创建XXX-Bridging-Header.h文件(XXX为你的项目名称)，确定。

  *这个自动创建出来的Bridging-Header.h文件是沟通Swift世界和Objective-C世界的桥梁*。任何需要在Swift文件中使用的自定义Objective-C类，必需先引入此Header文件。

  假设项目名称为`TestSwift`，其中存在Objective-C类Note（在`Note.m`中定义）:

		@interface Note : NSObject
		- (void)log;
		@end


  想在Swift中引用这个类，首先需要在`TestSwift-Bridging-Header.h`文件中import Note：

	    #import "Note.h"

  然后在Swift代码中就能使用Note了:

	    class ViewController: UIViewController {
		    override func viewDidLoad() {
		        super.viewDidLoad()

		        var a:Note = Note()
		        a.log()

		    }
	    }


## 在Objective-C中使用Swift类

- 想在Objective-C文件中引用Swift文件中定义的类，*需要在Objective-C文件中引入一个特殊的头文件: XXX-Swift.h*，假设项目名称为 `TestSwift`，那么这个需要引入的header文件为 `TestSwift-Swift.h`：

  假设存在Book类(在`Book.swift`文件中定义）：

		import Foundation

		class Book : NSObject {
		    var title:String

		    init() {
		        self.title = "Default Book"
		    }

		    func log() {
		        println(self.title)
		    }

		}

  在需要引用Book类的Objective-C文件中，先引入`TestSwift-Swift.h`头文件

        #import "TestSwift-Swift.h"

  然后就能使用Book了：

        Book *book = [Book new];
	    [book log];

  最后再啰嗦一句，`XXX-Swift.h`文件在项目中是不可见的（估计此文件在编译时自动生成），在使用时只需遵循苹果既定规则就OK了。


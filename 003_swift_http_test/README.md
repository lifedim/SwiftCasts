## Swift中的HTTP请求

iOS开发中大部分App的网络数据交换是基于`HTTP`协议的。本文将简单介绍在Swift中使用HTTP进行网络请求的几种方法。

> 注意：网络请求完成后会获得一个`NSData`类型的返回数据，如果数据格式为`JSON`，那么可以使用系统自带的`NSJSONSerialization`类来解析数据；或者使用[SwiftyJSON库的使用和思考](http://swiftist.org/topics/124)一文中提到的JSON解析库来解析数据。

### 1. 使用`NSURLConnection`

下面例子使用`NSURLConnection`实现了一个简单的异步GET操作：

```js
    func requestUrl(urlString: String){
        var url: NSURL = NSURL(string: urlString)
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
                if error? {
                    //Handle Error here
                }else{
                    //Handle data in NSData type
                }
            
            })
    }
```

### 2. 使用[YYHRequest-Swift](https://github.com/yayuhh/YYHRequest-Swift)库

这个库通过封装`NSURLConnection`和`NSOperationQueue`实现了简单的HTTP GET/POST/PUT/DELETE操作：

```js
let request = YYHRequest(url: NSURL(string: "http://www.google.com/"))

request.loadWithCompletion { response, data, error in
    // request complete!
}
```

### 3. 使用[SwiftHTTP](https://github.com/daltoniam/SwiftHTTP)库。

这个库通过封装`NSURLSession`，提供了GET/POST/PUT/DELETE以及上传和下载的支持，比较全面：

```js
var request = HTTPTask()
request.GET("http://vluxe.io", parameters: nil, success: {(response: AnyObject?) -> Void in

    },failure: {(error: NSError) -> Void in

    })
```

### 4. 使用Objective-C中的[AFNetworking](https://github.com/AFNetworking/AFNetworking)网络库

`AFNetworking`库是在iOS开发领域享有盛名、功能强大的网络请求库。

- 首先将AFNetworking库引入工程，请参考这篇[教程](http://www.raywenderlich.com/zh-hans/36079/afnetworking%E9%80%9F%E6%88%90%E6%95%99%E7%A8%8B%EF%BC%881%EF%BC%89)
- 然后在`<ProjectName>-Bridging-Header.h `头文件中引入AFNetworking:

```js
#import “AFNetworking/AFNetworking.h”
```

下面简单展示了`AFNetworking`中`GET`的用法：

```js
    func requestUrl(urlString: String) {
        let manager = AFHTTPRequestOperationManager()
        
        let params = ["a":1, "b":2]
        
        manager.GET(urlString,
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                
                let responseDict = responseObject as NSDictionary!
                
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                //Handle Error
            })
    }
```

### 实例

最后，我写了一个简单的例子来通过调用金山词霸的API获取单词`swift`的解释。项目使用`SwiftHTTP`来作网络请求，使用`SwiftyJSON`来解析JSON数据，代码托管在[Github](https://github.com/lifedim/SwiftCasts/tree/master/003_swift_http_test)，核心代码如下：

```js

        //请求金山词霸API获取单词`swift`的解释
        var request = HTTPTask()
        var params: Dictionary<String, AnyObject> = ["w": "swift", "key": "30CBA9DDD34B16DB669A9B214C941F14", "type": "json"]
        request.GET("http://dict-co.iciba.com/api/dictionary.php", parameters: params, success: {(response: AnyObject?) -> Void in
            
                let json = JSONValue(response!)
                println("\(json)")
            
            },failure: {(error: NSError) -> Void in

                println("\(error)")
            })

```

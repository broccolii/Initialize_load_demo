title: Objective-C 中的 load 和 initialize
date: 2016-03-15 02:11:34
tags: Objective-C
---

水叔在技术分享的周会上提到了这两个方法 `+ (void)load;` 和 `+ (void)initialize;` 的区别。还是对一些继承或者 `category` 调用先后顺序并不是很清楚，所以搜罗了一些博文整理出这篇文章。

### 两者区别
在官方文档中（Documentation and API Reference）两者的描述分别是：
**+ (void)load;**
> The load message is sent to classes and categories that are both dynamically loaded and statically linked, but *only if the newly loaded class or category implements a method that can respond.*
> The order of initialization is as follows:

> 1. All initializers in any framework you link to.
> 2. All +load methods in your image.
> 3. All C++ static initializers and C/C++ __attribute__(constructor) functions in your image.
> 4. All initializers in frameworks that link to you.

> In addition:

> * A class’s +load method is called after all of its superclasses’ +load  methods.
> * A category +load method is called after the class’s own +load method.

> In a custom implementation of load you can therefore safely message other unrelated classes from the same image, but any load methods implemented by those classes may not have run yet.

1. `+ (void)load;` 在类文件被加载到 runtime 时被调用，即使没有被 `#import` 引用。调用顺序是 `super class` -> `self class` -> `category`。 每次 `runtime` 启动只会调用一次该方法。
2. `+ (void)load;` 调用的时候尚未有自动释放池，所以如果 `+ (void)load;` 中的内容使用到了自动释放池，则代码需要用 `@autoreleasepool{}` 包含。
3. 对应Category中的 `+ (void)load;` 方法并不会覆盖类自身中的 `+ (void)load;` 方法，两个 `+ (void)load;` 方法都会调用，而且Category的 `+ (void)load;` 方法在类自身的 `+ (void)load;` 方法之后调用。

**+ (void)initialize;**
> *The runtime sends initialize to each class in a program just before the class, or any class that inherits from it, is sent its first message from within the program.* The runtime sends the initialize message to classes in a thread-safe manner. Superclasses receive this message before their subclasses.The superclass implementation may be called multiple times if subclasses do not implement initialize—the runtime will call the inherited implementation—or if subclasses explicitly call [super initialize]. 

1. `+ (void)initialize;` 在该类第一次发送消息（`objc_msgSend(receiver, selector)`）时被调用。
2. 在应用程序的生命周期中，`runtime` 只会向每个类发送一次 `+ (void)initialize;` 消息，如果该类是子类，且该子类中没有实现 `+ (void)initialize;` 方法，或者子类显示调用父类实现 `[super initialize]`, 那么则会调用其父类的实现。也就是说，父类的 `+ (void)initialize;` 可能会被调用多次。
	 如果不想子类使用父类的 `+ (void)initialize;` 方法可以
	 
	 ```
	 + (void)initialize {
	 	if (self == [ClassName self]) {
	 		// ... do the initialization ...
	 	}
	 }
	 ```
3. 如果类包含分类，且分类重写了 `+ (void)initialize;` 方法，那么则会调用分类的 `+ (void)initialize;` 实现，而原类的该方法实现不会被调用，这个机制同 NSObject 的其他方法(除 + (void)load 方法) 一样，即如果原类同该类的分类包含有相同的方法实现，那么原类的该方法被隐藏而无法被调用。
4. 父类的 `+ (void)initialize;` 方法先于子类的 `+ (void)initialize;` 方法调用。

放一张系统启动时的流程图：
<div style="text-align: center">
<img src="https://raw.githubusercontent.com/broccolii/broccolii.github.io/master/images/Objective-C_initialize_load/startupMain.png"/>
</div>




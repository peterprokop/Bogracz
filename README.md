Bogracz
======

# Intro

Bogracz is really smal and nifty dependency injection (DI) framework. 

Compared to Swinject it has some nice properties like thread safety 
and type-safe arguments.

# Installation
TBD

# Usage
Do `import Bogracz`
Then create a container: `let container = DependencyContainer()`

Then you can add dependencies as static (dependency will be created once and you are responsible for it):

```swift
let myService: MyServiceProviding = MyService()
container.addStatic(MyServiceProviding, instance: myService)
```

... dynamic (dependency will be created every time you get it):
```swift
container.addDynamic(MyServiceProviding.self, block: { _ in
  return MyService()
})
```

... or dynamic with config:
```swift
let config = MyServiceConfig(answer: 42)

container.addDynamic(MyServiceProviding.self, block: { (r, config: MyServiceConfig) in
  return MyService(config: config)
})
```

Then you can get your dependency in following way:

For dependencies without config - 
```swift
container.get(MyServiceProviding.self)
```

For configurable dependencies -
```swift
container.get(MyServiceProviding.self, config: config)
```

# Dependency Injection
Some useful articles about this topic:
- https://martinfowler.com/articles/injection.html
- https://www.martinfowler.com/articles/dipInTheWild.html
- https://www.martinfowler.com/bliki/InversionOfControl.html


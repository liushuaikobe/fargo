# fargo

Shorten an URL won't bother you.

![demo.gif](http://7xjdjy.com1.z0.glb.clouddn.com/fargo_demo.gif)

## Install

### Carthage

    github "liushuaikobe/fargo"
    
## Usage

Fargo has already integrated two built-in URL shorten serivces:

* goo.gl
* t.cn

And, you could add your own service easily.

```swift
GooglFargoTask("YOUR_API_KEY").shorten("http://github.com/liushuaikobe")
	.success {
		origin, shorten in
		// do something with shorten result
    	}.error {
		error in
		// error handling
    	}.fargo()
```

## Advanced

To add your own URL shorten serivce (support GET/POST on HTTP(S) currently), just inherit from `FargoTask` and overide some methods, see [`GooglFargoTask`](https://github.com/liushuaikobe/fargo/blob/master/fargo/GooglFargoTask.swift) for POST example and [`TcnFargoTask`](https://github.com/liushuaikobe/fargo/blob/master/fargo/TcnFargoTask.swift) for GET example.

## License

GNU GENERAL PUBLIC LICENSE

## Donated via WeChat

![WeChat](http://7xjdjy.com1.z0.glb.clouddn.com/wechat_pay.JPG)



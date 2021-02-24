# SwiftyDefaults
Swifty UserDefaults by strong type

## How to use

####Setup:


```
enum Config {

	@DefaultsKey(key: "token", defaultValue: "defaultValue", type: .device/.user)
	static var token: String
}

```

#### Get Vlaue:

```
let key = Config.token // done
```

### Monitoring value changes

```
observation = Config.token.observe { newToken in
	// newToken
}
```
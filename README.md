# NEIApplicationConfig

[![CI Status](http://img.shields.io/travis/ghost/NEIApplicationConfig.svg?style=flat)](https://travis-ci.org/ghost/NEIApplicationConfig)
[![Version](https://img.shields.io/cocoapods/v/NEIApplicationConfig.svg?style=flat)](http://cocoapods.org/pods/NEIApplicationConfig)
[![License](https://img.shields.io/cocoapods/l/NEIApplicationConfig.svg?style=flat)](http://cocoapods.org/pods/NEIApplicationConfig)
[![Platform](https://img.shields.io/cocoapods/p/NEIApplicationConfig.svg?style=flat)](http://cocoapods.org/pods/NEIApplicationConfig)

*NEIApplicationConfig* allows developers to have configurations defined in a config file per environment,
which makes deployment and testing easier. While usage of application properties via *.plist* is useful,
NEIApplicationConfig allows you can easily target Simulator, Device and Production 
environments respectively. With NEIApplicationConfig, you will specify a default configuration as a baseline, and overrides that are 
pertinent to their respective environments.

 
## Requirements

## Installation

NEIApplicationConfig is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NEIApplicationConfig"
```

## Usage
### Initialization

Create ApplicationConfig plist for each environment:
```
ApplicationConfig.plist
ApplicationConfig.debug.plist
ApplicationConfig.simulator.plist
```
Upon loading, the application will ALWAYS load *ApplicationConfig.plist*, and optionally *ApplicaitonConfig.debug.plist*
if the **DEBUG** macro is enabled, and *ApplicationConfig.simulator.plist* if the application is running in the simulator.

Using this method, a released application will only utilize *ApplicationConfig.plist*, as it is neither being *debuged*, 
nor is it running in the *simulator*, and if its being debugged on a device, both *ApplicationConfig.plist* and
*ApplicationConfig.debug.plist* will be loaded and merged.


### Utilization

*NEIApplicationConfig* may always use static singleton method *defaults()* to get the default/merged configuration, or 
assign the defaults to a variable *config* which will be used to reference configuration.

**Swift**
```swift
import NEIApplicationConfig

class YourViewController : UIViewController {
    let config = NEIApplicationConfig.defaults()
    
    func methodUsingConfig() {
        let booleanValue = config.get(booleanForKey: "VALUE_ENABLED", defaultValue: false)
        let stringWithDefaultValue = config.get(stringForKey: "STRING_KEY", defaultValue: "DEFAULT_VALUE")
        let stringOrNil =  config.get(stringForKey: "STRING_KEY")
        
        config.set(object:true,forKey:"IS_AWESOME_API") //sets or overrides a value set in the config. However, setting is not persisted
        
        if let truth = config.get(booleanForKey: "IS_AWESOME_API", defaultValue: true) {
            // 
        }
    }
}
```

**Objective C**
```objectivec
@implementation YouViewController {

    - (void) methodUsingConfig() {
            NEIApplicationConfig * config = [NEIApplicationConfig defaults];
            BOOL enabled = [config booleanForKey:@"VALUE_ENABLED" value:false];
            NSString * stringValue = [config stringForKey:@"STRING_KEY" value:@"defualt value"];
            
            [config setObject:@(true) forKey:@"IS_AWESOME_API"];
            
            if([config booleanForKey:@"IS_AWESOME_API" value:NO]) {
                
            }

            // ....
    }
}
```


### Definition

```objectivec
@interface NEIApplicationConfig : NSObject

+ (nonnull NEIApplicationConfig *)defaults;

+ (nonnull NEIApplicationConfig *)setObject:(nullable id)object forKey:(nonnull NSString *)key NS_SWIFT_NAME(set(value:key:));

+ (nullable NSObject *)objectForKey:(nonnull NSString *)key NS_SWIFT_NAME( get(objectForKey:) );

+ (nonnull NSArray *)allKeys  NS_SWIFT_NAME(keys());

+ (nonnull NSObject *)objectForKey:(nonnull NSString *)key value:(nonnull NSObject *)value  NS_SWIFT_NAME( get(objectForKey:defaultValue:) );

+ (nonnull NSString *)stringForKey:(nonnull NSString *)key value:(nonnull NSString *)default_value  NS_SWIFT_NAME( get(stringForKey:defaultValue:));

+ (nullable NSString *)stringForKey:(nonnull NSString *)key  NS_SWIFT_NAME( get(stringForKey:) );

+ (nullable Class)classForKey:(nonnull NSString *)key value:(nullable NSString *)value NS_SWIFT_NAME(get(classForKey:defaultValue:));

+ (nullable Class)classForKey:(nonnull NSString *)key NS_SWIFT_NAME(get(classForKey:));

+ (BOOL)booleanForKey:(nonnull NSString *)key value:(BOOL)default_value  NS_SWIFT_NAME(get(boolforKey:defaultValue:));

+ (NSInteger)intForKey:(nonnull NSString *)key value:(NSInteger)default_value   NS_SWIFT_NAME(get(intForKey:defaultValue:));

+ (float)floatForKey:(nonnull NSString *)key value:(float)default_value   NS_SWIFT_NAME(get(floatForKey:defaultValue:));

+ (nullable CTFontRef)createFontWithName:(nonnull NSString *)name ;

+ (nullable UIFont *)fontWithName: (nonnull NSString *)name  NS_SWIFT_NAME(font(named:));

+ (nonnull NEIApplicationConfig *)configWithScope:(nullable NSString *)scope NS_SWIFT_NAME(with(scope:));

+ (nonnull NEIApplicationConfig *)configWithDictionary:(nullable NSDictionary *)dictionary  NS_SWIFT_NAME(with(dictionary:));

#pragma mark - Instance Methods

- (nonnull NEIApplicationConfig *)setObject:(nullable id)value forKey:(nonnull NSString *)key NS_SWIFT_NAME(set(object:forKey:));

- (nullable NSObject *)objectForKey:(nonnull NSString *)key  NS_SWIFT_NAME(get(objectForKey:));

- (nonnull NSString *)stringForKey:(nonnull NSString *)key value:(nonnull NSString *)default_value  NS_SWIFT_NAME(get(stringForKey:defaultValue:));

- (nullable NSString *)stringForKey:(nonnull NSString *)key NS_SWIFT_NAME(get(stringForKey:));

- (float)floatForKey:(nonnull NSString *)key value:(float)default_value NS_SWIFT_NAME(get(floatForKey:value:));

- (nullable UIFont *)fontWithName:(nonnull NSString *)name  NS_SWIFT_NAME(font(named:));

- (nullable CTFontRef)createFontWithName:(nonnull NSString *)name ;

- (nonnull NSArray *)allKeys  NS_SWIFT_NAME(keys());

- (nullable Class)classForKey:(nonnull NSString *)key value:(nonnull NSString *)value NS_SWIFT_NAME(get(classForKey:defaultValue:));

- (BOOL)booleanForKey:(nonnull NSString *)key value:(BOOL)default_value  NS_SWIFT_NAME(get(booleanForKey:defaultValue:));

- (NSInteger)intForKey:(nonnull NSString *)key value:(NSInteger)default_value  NS_SWIFT_NAME(get(intForKey:defaultValue:));

- (nonnull NSObject *)objectForKey:(nonnull NSString *)key value:(nonnull NSObject *)default_value;

#pragma mark -

- (nullable id)objectForKeyedSubscript:(nonnull NSString*)key;
- (void)setObject:(nullable id)obj forKeyedSubscript:(nonnull NSString *)key;

@end



```


## Author

GHOST, ghost [at] neilab.com

## License

NEIApplicationConfig is available under the MIT license. See the LICENSE file for more info.

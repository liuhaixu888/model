//
//  UIDevice(Common).m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UIDevice+Common.h"

#include <net/if.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <sys/types.h>
#include <net/if_dl.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <sys/param.h>
#include <sys/mount.h>
#import <mach/mach.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AVFoundation/AVFoundation.h>
#import <AdSupport/ASIdentifierManager.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/stat.h>

@implementation UIDevice (Common)

const char* key = "hoolai";

+ (NSString *)deviceToken
{
//    NSData *deviceToken = [userDefaults objectForKey:UserDefaultKey_DeviceToken];
    NSData *deviceToken = [NSData data];

    if (deviceToken) {
        NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        return [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return @"";
}

+ (NSString *)BIData
{
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *name = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    CGRect rect_screen = [[UIScreen mainScreen]bounds];
//    CGSize size_screen = rect_screen.size;
//    CGFloat scale_screen = [UIScreen mainScreen].scale;
//    NSString *ratio = [NSString stringWithFormat:@"%.0f*%.0f",size_screen.width*scale_screen,size_screen.height*scale_screen];
//    NSDictionary *mi_info = [userDefaults objectForKey:UserDefaultKey_MiPushInfo];
//    NSString *mi_regid = mi_info?[mi_info objectForKey:@"regid"]:@"";
//    
////    NSDictionary *biData = @{@"udid":[OpenUDID value], @"client_version":version, @"model":[UIDevice deviceModel], @"name":name,
////                             @"client_version_code": XcodeBundleVersion, @"idfv":[self idfv], @"token":[self deviceToken],
////                             @"operator":[self chinaMobileModel], @"product":[self deviceName], @"device":@"iOS", @"ratio":ratio,
////                             @"os_version":[[UIDevice currentDevice] systemVersion], @"ip":[self IPv4], @"os":@"iOS",
////                             @"mi_regid":mi_regid, @"jailbroken":@([self jailbroken]), @"idfa":[self idfa], @"network":[self network]};
//    NSDictionary *biData = [NSDictionary dictionary];
////    return [biData json];
    
    return nil;
}

////???????????????
//+ (NSString *)idfa
//{
//    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
//    {
//        NSUUID *IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
//        
//        return [IDFA UUIDString];
//    }
//    
//    return @"";
//}

+ (NSString *)idfv
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)network
{
    NSString *net = @"";
//    switch ([NetManager networkStatus]) {
//        case AFNetworkReachabilityStatusUnknown:
//            net = @"Unknown";
//            break;
//        case AFNetworkReachabilityStatusNotReachable:
//            net = @"NO";
//            break;
//        case AFNetworkReachabilityStatusReachableViaWiFi:
//            net = @"WIFI";
//            break;
//        case AFNetworkReachabilityStatusReachableViaWWAN:{
//            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
//            if (currentRadioAccessTechnology) {
//                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
//                    net = @"4G";
//                } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] ||
//                           [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
//                    net = @"2G";
//                } else {
//                    net = @"3G";
//                }
//            }
//            break;
//        }
//    }
//    
    return net;
}

+ (NSString *)chinaMobileModel
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return @"?????????";
    }
    
    NSString *code = [carrier mobileNetworkCode];
    if (code == nil) {
        return @"?????????";
    }
    
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"])
    {
        return @"??????";
    }else if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"])
    {
        return @"??????";
    }else if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"])
    {
        return @"??????";
    }else if ([code isEqualToString:@"20"])
    {
        return @"??????";
    }
    return @"?????????";
}

+ (NSString *)IPv4
{
    return [self ipAddressIsV4:YES];
}

+ (NSString *)IPv6
{
    return [self ipAddressIsV4:NO];
}

+ (NSString *)deviceModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return deviceModel;
}

// https://github.com/squarefrog/UIDeviceIdentifier
+ (NSString *)deviceName
{
    NSString *platform = [self deviceModel];
    
    NSDictionary *platformStrings = @{
#if !defined(TARGET_OS_IOS) || TARGET_OS_IOS
                                      @"iPhone1,1": @"iPhone 1G",
                                      @"iPhone1,2": @"iPhone 3G",
                                      @"iPhone2,1": @"iPhone 3GS",
                                      @"iPhone3,1": @"iPhone 4 (GSM)",
                                      @"iPhone3,2": @"iPhone 4 (GSM Rev A)",
                                      @"iPhone3,3": @"iPhone 4 (CDMA)",
                                      @"iPhone4,1": @"iPhone 4S",
                                      @"iPhone5,1": @"iPhone 5 (GSM)",
                                      @"iPhone5,2": @"iPhone 5 (GSM+CDMA)",
                                      @"iPhone5,3": @"iPhone 5C (GSM)",
                                      @"iPhone5,4": @"iPhone 5C (GSM+CDMA)",
                                      @"iPhone6,1": @"iPhone 5S (GSM)",
                                      @"iPhone6,2": @"iPhone 5S (GSM+CDMA)",
                                      @"iPhone7,1": @"iPhone 6 Plus",
                                      @"iPhone7,2": @"iPhone 6",
                                      @"iPhone8,1": @"iPhone 6s",
                                      @"iPhone8,2": @"iPhone 6s Plus",
                                      @"iPhone8,4": @"iPhone SE",
                                      @"iPod1,1": @"iPod Touch 1G",
                                      @"iPod2,1": @"iPod Touch 2G",
                                      @"iPod3,1": @"iPod Touch 3G",
                                      @"iPod4,1": @"iPod Touch 4G",
                                      @"iPod5,1": @"iPod Touch 5G",
                                      @"iPod7,1": @"iPod Touch 6G",
                                      @"iPad1,1": @"iPad 1",
                                      @"iPad2,1": @"iPad 2 (WiFi)",
                                      @"iPad2,2": @"iPad 2 (GSM)",
                                      @"iPad2,3": @"iPad 2 (CDMA)",
                                      @"iPad2,4": @"iPad 2",
                                      @"iPad2,5": @"iPad Mini (WiFi)",
                                      @"iPad2,6": @"iPad Mini (GSM)",
                                      @"iPad2,7": @"iPad Mini (GSM+CDMA)",
                                      @"iPad3,1": @"iPad 3 (WiFi)",
                                      @"iPad3,2": @"iPad 3 (GSM+CDMA)",
                                      @"iPad3,3": @"iPad 3 (GSM)",
                                      @"iPad3,4": @"iPad 4 (WiFi)",
                                      @"iPad3,5": @"iPad 4 (GSM)",
                                      @"iPad3,6": @"iPad 4 (GSM+CDMA)",
                                      @"iPad4,1": @"iPad Air (WiFi)",
                                      @"iPad4,2": @"iPad Air (WiFi/Cellular)",
                                      @"iPad4,3": @"iPad Air (China)",
                                      @"iPad4,4": @"iPad Mini Retina (WiFi)",
                                      @"iPad4,5": @"iPad Mini Retina (WiFi/Cellular)",
                                      @"iPad4,6": @"iPad Mini Retina (China)",
                                      @"iPad4,7": @"iPad Mini 3 (WiFi)",
                                      @"iPad4,8": @"iPad Mini 3 (WiFi/Cellular)",
                                      @"iPad5,1": @"iPad Mini 4 (WiFi)",
                                      @"iPad5,2": @"iPad Mini 4 (WiFi/Cellular)",
                                      @"iPad5,3": @"iPad Air 2 (WiFi)",
                                      @"iPad5,4": @"iPad Air 2 (WiFi/Cellular)",
                                      @"iPad6,3": @"iPad Pro 9.7-inch (WiFi)",
                                      @"iPad6,4": @"iPad Pro 9.7-inch (WiFi/Cellular)",
                                      @"iPad6,7": @"iPad Pro 12.9-inch (WiFi)",
                                      @"iPad6,8": @"iPad Pro 12.9-inch (WiFi/Cellular)",
#endif
#if TARGET_OS_TV
                                      @"AppleTV5,3": @"Apple TV 4G",
#endif
#if !defined(TARGET_OS_SIMULATOR) || TARGET_OS_SIMULATOR
                                      @"i386": @"Simulator",
                                      @"x86_64": @"Simulator",
#endif
                                      };
    
    return platformStrings[platform] ?: platform;
}

+ (NSDictionary *)wifiInfo
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

+ (NSString *)ipAddressIsV4:(BOOL)v4
{
    NSArray *searchArray = v4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self addressInfo];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)addressInfo
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

//??????????????????????????????
+ (void)recordPermission:(void (^)(BOOL granted))response
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if([audioSession respondsToSelector:@selector(requestRecordPermission:)])
    {
        [audioSession requestRecordPermission:response];
    }else{
        response ? response(true) : nil;
    }
}


//?????????????????????
+ (BOOL)headphonesConnected
{
#if TARGET_IPHONE_SIMULATOR
    return NO;
#endif
    
    
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    CFStringRef route;
    UInt32 propertySize = sizeof(CFStringRef);
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, &route);
    
    BOOL hasHeadset = NO;
    if((route == NULL) || (CFStringGetLength(route) == 0))
    {
        // Silent Mode
    }
    else
    {
        /* Known values of route:
         * "Headset"
         * "Headphone"
         * "Speaker"
         * "SpeakerAndMicrophone"
         * "HeadphonesAndMicrophone"
         * "HeadsetInOut"
         * "ReceiverAndMicrophone"
         * "Lineout"
         */
        NSString* routeStr = (__bridge NSString*)route;
        NSRange headphoneRange = [routeStr rangeOfString : @"Headphone"];
        NSRange headsetRange = [routeStr rangeOfString : @"Headset"];
        
        if (headphoneRange.location != NSNotFound)
        {
            hasHeadset = YES;
        }
        else if(headsetRange.location != NSNotFound)
        {
            hasHeadset = YES;
        }
    }
    
    if (route)
    {
        CFRelease(route);
    }
#pragma GCC diagnostic pop
    
    return hasHeadset;
}

//???????????????Airplay
+ (BOOL)isAirplayActived
{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    CFDictionaryRef currentRouteDescriptionDictionary = nil;
    UInt32 dataSize = sizeof(currentRouteDescriptionDictionary);
    AudioSessionGetProperty(kAudioSessionProperty_AudioRouteDescription, &dataSize, &currentRouteDescriptionDictionary);
    
    BOOL airplayActived = NO;
    if (currentRouteDescriptionDictionary)
    {
        CFArrayRef outputs = CFDictionaryGetValue(currentRouteDescriptionDictionary, kAudioSession_AudioRouteKey_Outputs);
        if(outputs != NULL && CFArrayGetCount(outputs) > 0)
        {
            CFDictionaryRef currentOutput = CFArrayGetValueAtIndex(outputs, 0);
            //Get the output type (will show airplay / hdmi etc
            CFStringRef outputType = CFDictionaryGetValue(currentOutput, kAudioSession_AudioRouteKey_Type);
            
            airplayActived = (CFStringCompare(outputType, kAudioSessionOutputRoute_AirPlay, 0) == kCFCompareEqualTo);
        }
        CFRelease(currentRouteDescriptionDictionary);
    }
#pragma GCC diagnostic pop
    return airplayActived;
}

//????????????
+ (BOOL)jailbroken
{
#if !TARGET_IPHONE_SIMULATOR
    
    //Apps and System check list
    BOOL isDirectory;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"bla", @"ckra1n.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Fake", @"Carrier.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Ic", @"y.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Inte", @"lliScreen.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"MxT", @"ube.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Roc", @"kApp.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"SBSet", @"ttings.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Wint", @"erBoard.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/c", @"ydia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/mobile", @"Library/SBSettings", @"Themes/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/t", @"mp/cyd", @"ia.log"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/s", @"tash/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/b",@"in", @"s", @"shd"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/sb",@"in", @"s", @"shd"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/sftp-", @"server"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@",@"/Syste",@"tem/Lib",@"rary/Lau",@"nchDae",@"mons/com.ike",@"y.bbot.plist"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@%@",@"/Sy",@"stem/Lib",@"rary/Laun",@"chDae",@"mons/com.saur",@"ik.Cy",@"@dia.Star",@"tup.plist"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/Libr",@"ary/Mo",@"bileSubstra",@"te/MobileSubs",@"trate.dylib"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"og/s",@"yslog"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/bi",@"n/b",@"ash"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/b",@"in/",@"sh"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/et",@"c/a",@"pt/"]isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/etc/s",@"sh/s",@"shd_config"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/us",@"r/li",@"bexe",@"c/ssh-k",@"eysign"]])
        
    {
        return YES;
    }
    
    // SandBox Integrity Check
    int pid = fork(); //???????????????????????????0??????????????????????????????ID??????????????????-1
    if(!pid){
        exit(0);
    }
    if(pid>=0)
    {
        return YES;
    }
    
    //Symbolic link verification
    struct stat s;
    if(lstat("/Applications", &s) || lstat("/var/stash/Library/Ringtones", &s) || lstat("/var/stash/Library/Wallpaper", &s)
       || lstat("/var/stash/usr/include", &s) || lstat("/var/stash/usr/libexec", &s)  || lstat("/var/stash/usr/share", &s)
       || lstat("/var/stash/usr/arm-apple-darwin9", &s))
    {
        if(s.st_mode & S_IFLNK){
            return YES;
        }
    }
    
    //Try to write file in private
    NSError *error;
    [[NSString stringWithFormat:@"Jailbreak test string"] writeToFile:@"/private/test_jb.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if(nil==error){
        //Writed
        return YES;
    } else {
        [defaultManager removeItemAtPath:@"/private/test_jb.txt" error:nil];
    }
    
#endif
    return NO;
}

//?????????????????????
+ (BOOL)isCracked
{
#if !TARGET_IPHONE_SIMULATOR
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString* bundlePath = [bundle bundlePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    static NSString *str;
    BOOL fileExists;
    
    //Check to see if the app is running on root
    int root = getgid();
    if (root <= 10) {
        return YES;
    }
    
    //Checking for identity signature
    char symCipher[] = { '(', 'H', 'Z', '[', '9', '{', '+', 'k', ',', 'o', 'g', 'U', ':', 'D', 'L', '#', 'S', ')', '!', 'F', '^', 'T', 'u', 'd', 'a', '-', 'A', 'f', 'z', ';', 'b', '\'', 'v', 'm', 'B', '0', 'J', 'c', 'W', 't', '*', '|', 'O', '\\', '7', 'E', '@', 'x', '"', 'X', 'V', 'r', 'n', 'Q', 'y', '>', ']', '$', '%', '_', '/', 'P', 'R', 'K', '}', '?', 'I', '8', 'Y', '=', 'N', '3', '.', 's', '<', 'l', '4', 'w', 'j', 'G', '`', '2', 'i', 'C', '6', 'q', 'M', 'p', '1', '5', '&', 'e', 'h' };
    char csignid[] = "V.NwY2*8YwC.C1";
    for(int i=0;i<strlen(csignid);i++)
    {
        for(int j=0;j<sizeof(symCipher);j++)
        {
            if(csignid[i] == symCipher[j])
            {
                csignid[i] = j+0x21;
                break;
            }
        }
    }
    NSString* signIdentity = [[NSString alloc] initWithCString:csignid encoding:NSUTF8StringEncoding];
    
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:signIdentity] != nil)
    {
        return YES;
    }
    
    // Check if the below .plist files exists in the app bundle
    fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"_C",@"odeS",@"igna",@"ture"]])];
    if (!fileExists) {
        return YES;
    }
    
    
    fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"Re",@"sour",@"ceRules.p",@"list"]])];
    if (!fileExists) {
        return YES;
    }
    
    
    fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"S",@"C_",@"In",@"fo"]])];
    if (!fileExists) {
        return YES;
    }
    
    
    //Check if the info.plist and exectable files have been modified
    str= [NSString stringWithFormat:@"%@%@%@%@", @"Pk",@"gI",@"nf",@"o"];
    NSDate* pkgInfoModifiedDate = [[manager attributesOfItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:str] error:nil] fileModificationDate];
    
    str= [NSString stringWithFormat:@"%@%@%@%@", @"In",@"fo.p",@"li",@"st"];
    NSString* infoPath = [NSString stringWithFormat:@"%@/%@", bundlePath,str];
    NSDate* infoModifiedDate = [[manager attributesOfItemAtPath:infoPath error:nil] fileModificationDate];
    if([infoModifiedDate timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
        return YES;
    }
    
    str = [[bundle infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString* appPathName = [NSString stringWithFormat:@"%@/%@", bundlePath,str];
    NSDate* appPathNameModifiedDate = [[manager attributesOfItemAtPath:appPathName error:nil]  fileModificationDate];
    if([appPathNameModifiedDate timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
        return YES;
    }
    
#endif
    return NO;
}

//????????????????????????
+ (NSString *)freeMemory {
    return [NSByteCountFormatter stringFromByteCount:[self freeMemoryInBytes] countStyle:NSByteCountFormatterCountStyleMemory];
}

// ??????????????????????????????(?????????MB???
+ (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}


// ????????????????????????????????????????????????MB???
+ (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}


+ (vm_size_t)freeMemoryInBytes {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return vm_page_size * vmStats.free_count;
}

+ (vm_size_t)usedMemoryInBytes {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return taskInfo.resident_size;
}

//??????????????????????????????
+ (NSString *)totalDiskSpace {
    return [NSByteCountFormatter stringFromByteCount:[self totalDiskSpaceInBytes] countStyle:NSByteCountFormatterCountStyleBinary];
}

+ (NSString *)freeDiskSpace {
    return [NSByteCountFormatter stringFromByteCount:[self freeDiskSpaceInBytes] countStyle:NSByteCountFormatterCountStyleBinary];
}

+ (NSString *)usedDiskSpace {
    return [NSByteCountFormatter stringFromByteCount:[self usedDiskSpaceInBytes] countStyle:NSByteCountFormatterCountStyleBinary];
}

+ (CGFloat)totalDiskSpaceInBytes {
    return [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemSize] longLongValue];
}

+ (CGFloat)freeDiskSpaceInBytes {
    return [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
}

+ (CGFloat)usedDiskSpaceInBytes {
    return [self totalDiskSpaceInBytes] - [self freeDiskSpaceInBytes];
}

@end

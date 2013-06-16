//
//  BtcePublicApiV3Handler.m
//
//  Created by Nikita Kolmogorov on 16.06.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "BtcePublicApiV3Handler.h"

static int disconnectIncrement;

@implementation BtcePublicApiV3Handler

+ (NSDictionary *)getRatesForPairs:(NSArray *)pairs {
    NSString *url = @"https://btc-e.com/api/3/ticker/";
    
    for (int i = 0; i < pairs.count; i++) {
        NSString *pairString = getStringForPair([[pairs objectAtIndex:i] intValue]);
        if (i == (pairs.count - 1)) {
            url = [url stringByAppendingString:pairString];
        } else {
            url = [url stringByAppendingString:pairString];
            url = [url stringByAppendingString:@"-"];
        }
    }
    
    NSData *data = [self getResponseFromPublicServerUrl:url];
    
    NSDictionary *result;
    if (data != nil) {
        NSError *error;
        result = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
    }
    return result;
}

+ (NSDictionary *)getDepthForPairs:(NSArray *)pairs {
    NSString *url = @"https://btc-e.com/api/3/depth/";
    
    for (int i = 0; i < pairs.count; i++) {
        NSString *pairString = getStringForPair([[pairs objectAtIndex:i] intValue]);
        if (i == (pairs.count - 1)) {
            url = [url stringByAppendingString:pairString];
        } else {
            url = [url stringByAppendingString:pairString];
            url = [url stringByAppendingString:@"-"];
        }
    }
    
    NSData *data = [self getResponseFromPublicServerUrl:url];
    
    NSDictionary *result;
    if (data != nil) {
        NSError *error;
        result = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
    }
    return result;
}

+ (NSDictionary *)getTradesForPairs:(NSArray *)pairs {
    NSString *url = @"https://btc-e.com/api/3/trades/";
    
    for (int i = 0; i < pairs.count; i++) {
        NSString *pairString = getStringForPair([[pairs objectAtIndex:i] intValue]);
        if (i == (pairs.count - 1)) {
            url = [url stringByAppendingString:pairString];
        } else {
            url = [url stringByAppendingString:pairString];
            url = [url stringByAppendingString:@"-"];
        }
    }
    
    NSData *data = [self getResponseFromPublicServerUrl:url];
    
    NSDictionary *result;
    if (data != nil) {
        NSError *error;
        result = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
    }
    return result;
}

+ (NSDictionary *)getInfo {
    NSString *url = @"https://btc-e.com/api/3/info/";
    
    NSData *data = [self getResponseFromPublicServerUrl:url];
    
    NSDictionary *result;
    if (data != nil) {
        NSError *error;
        result = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
    }
    return result;
}

#pragma mark -
#pragma mark Methods for deep work with server
#pragma mark -

+ (NSData *)getResponseFromPublicServerUrl:(NSString *)urlString {
    NSData *data = nil;
    NSURL *url = [NSURL URLWithString:urlString];
    data = [NSData dataWithContentsOfURL:url];
    [self checkIfDataIsReturnedAndValid:data];
    return data;
}

// returns valid data or nil
+ (NSData *)checkIfDataIsReturnedAndValid:(NSData *)data {
    if (data == nil) {
        disconnectIncrement++;
        if (disconnectIncrement > 5) {
            NSLog(@"No connection to server!");
        }
    } else {
        disconnectIncrement = 0;
        NSError *error;
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        if ([[[json objectForKey:@"success"] stringValue] isEqualToString:@"0"]) {
            NSLog(@"Error: %@",[json objectForKey:@"error"]);
            data = nil;
        }
    }
    return data;
}

#pragma mark -
#pragma mark Useful functions
#pragma mark -

NSString *getStringForPair(Pair pair) {
    NSString *pairStr;
    if (pair == btc_usd) {
        pairStr = @"btc_usd";
    } else if (pair == btc_eur) {
        pairStr = @"btc_eur";
    } else if (pair == btc_rur) {
        pairStr = @"btc_rur";
    } else if (pair == ltc_btc) {
        pairStr = @"ltc_btc";
    } else if (pair == ltc_usd) {
        pairStr = @"ltc_usd";
    } else if (pair == ltc_rur) {
        pairStr = @"ltc_rur";
    } else if (pair == nmc_btc) {
        pairStr = @"nmc_btc";
    } else if (pair == usd_rur) {
        pairStr = @"usd_rur";
    } else if (pair == eur_usd) {
        pairStr = @"eur_usd";
    } else {
        pairStr = @"ERROR!";
    }
    return pairStr;
}

@end

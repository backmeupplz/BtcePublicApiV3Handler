//
//  BtcePublicApiV3Handler.h
//
//  Created by Nikita Kolmogorov on 16.06.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

// Typedef for simple representation of pairs. You can add more pairs - these are just examples
typedef enum {
    btc_usd = 1,
    btc_eur,
    btc_rur,
    ltc_btc,
    ltc_usd,
    ltc_rur,
    nmc_btc,
    usd_rur,
    eur_usd
} Pair;

#import <Foundation/Foundation.h>

@interface BtcePublicApiV3Handler : NSObject

/*! Method to get all sale and buy rates of given pairs
 * \param pairs Array of required pairs (better to pass NSArray of int)
 * \return returns a dictionary with all the required data
 */
+ (NSDictionary *)getRatesForPairs:(NSArray *)pairs;

/*! Method to get depth of given pairs
 * \param pairs Array of required pairs (better to pass NSArray of int)
 * \return returns a dictionary with all the required data
 */
+ (NSDictionary *)getDepthForPairs:(NSArray *)pairs;

/*! Method to get trades of given pairs
 * \param pairs Array of required pairs (better to pass NSArray of int)
 * \return returns a dictionary with all the required data
 */
+ (NSDictionary *)getTradesForPairs:(NSArray *)pairs;

/*! Method to get info from server
 * \return returns a dictionary with all the required data
 */
+ (NSDictionary *)getInfo;

@end

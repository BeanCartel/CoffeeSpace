//
//  Yelp_Client.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 4/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager
//////////////////////////////////////THIS CLASS IS NOT BEING USED FOR THE APP, SEE OTHER CLIENT FOR THAT////////////////////////////////

//This key was generated for CoffeeSpace
let yelpConsumerKey = "cm0UQ3yr5FSBBENLE5-EIw"
let yelpConsumerSecret = "X5MJuQWENNUMEOeKbyZMmIqdZr0"
let yelpToken = "R2MatmBqezWSdstZPs-OmK8xA2Xx3Ppl"
let yelpTokenSecret = "T0E_sGI1SEiELVv0GQexPd3lkis"

enum YelpSortMode: Int {
    case BestMatched = 0, Distance, HighestRated
}

class Yelp_Client: BDBOAuth1SessionManager {

    var accessToken: String!
    var accessSecret: String!
    
    class var sharedInstance : Yelp_Client {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : Yelp_Client? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Yelp_Client(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return Static.instance!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = NSURL(string: "https://api.yelp.com/v2/")
        //super.init(baseURL: baseUrl, sessionConfiguration: NSURLSessionConfiguration?)
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, completion: ([ShopsWithYelp]!, NSError!) -> Void) -> NSURLSessionDataTask {
        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, completion: completion)
    }
    
    func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: ([ShopsWithYelp]!, NSError!) -> Void) -> NSURLSessionDataTask {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to Mayaguez
        var parameters: [String : AnyObject] = ["term": term, "ll": "18.208677,-67.144818"]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joinWithSeparator(",")
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals!
        }
        
        print(parameters)
        
        return self.GET("search", parameters: parameters, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            let dictionaries = response!["businesses"] as? [NSDictionary]
            if dictionaries != nil {
                completion(ShopsWithYelp.Shops(array: dictionaries!), nil)
            }
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) in
                completion(nil, error)
        })!
        
      
    }
    
   


}

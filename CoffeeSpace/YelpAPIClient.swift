//
//  YelpAPIClient.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 4/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import OAuthSwift

struct YelpAPIConsole {
    var consumerKey = "cm0UQ3yr5FSBBENLE5-EIw"
    var consumerSecret = "X5MJuQWENNUMEOeKbyZMmIqdZr0"
    var accessToken = "R2MatmBqezWSdstZPs-OmK8xA2Xx3Ppl"
    var accessTokenSecret = "T0E_sGI1SEiELVv0GQexPd3lkis"
}

class YelpAPIClient: NSObject {

    let APIBaseUrl = "https://api.yelp.com/v2/"
    let clientOAuth: OAuthSwiftClient?
    let apiConsoleInfo: YelpAPIConsole
    
    class var sharedInstance : YelpAPIClient {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : YelpAPIClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = YelpAPIClient()
        }
        return Static.instance!
    }
    
    
    
    override init() {
        apiConsoleInfo = YelpAPIConsole()
        self.clientOAuth = OAuthSwiftClient(consumerKey: apiConsoleInfo.consumerKey, consumerSecret: apiConsoleInfo.consumerSecret, accessToken: apiConsoleInfo.accessToken, accessTokenSecret: apiConsoleInfo.accessTokenSecret)
        super.init()
    }
    
    /*
     
     searchPlacesWithParameters: Function that can search for places using any specified API parameter
     
     Arguments:
     
     searchParameters: Dictionary<String, String>, optional (See https://www.yelp.co.uk/developers/documentation/v2/search_api )
     successSearch: success callback with data (NSData) and response (NSHTTPURLResponse) as parameters
     failureSearch: error callback with error (NSError) as parameter
     
     Example:
     
     var parameters = ["ll": "37.788022,-122.399797", "category_filter": "burgers", "radius_filter": "3000", "sort": "0"]
     
     searchPlacesWithParameters(parameters, successSearch: { (data, response) -> Void in
     println(NSString(data: data, encoding: NSUTF8StringEncoding))
     }, failureSearch: { (error) -> Void in
     println(error)
     })
     
     
     */
    
    func searchPlacesWithParameters(searchParameters: Dictionary<String, String>, successSearch: (data: AnyObject, response: NSHTTPURLResponse) -> Void, failureSearch: (error: NSError) -> Void) {
        let searchUrl = APIBaseUrl + "search"
        clientOAuth!.get(searchUrl, parameters: searchParameters, success: successSearch, failure: failureSearch)
    }
    
    /*
     
     getBusinessInformationOf: Retrieve all the business data using the id of the place
     
     Arguments:
     
     businessId: String
     localeParameters: Dictionary<String, String>, optional (See https://www.yelp.co.uk/developers/documentation/v2/business )
     successSearch: success callback with data (NSData) and response (NSHTTPURLResponse) as parameters
     failureSearch: error callback with error (NSError) as parameter
     
     Example:
     
     getBusinessInformationOf("custom-burger-san-francisco", successSearch: { (data, response) -> Void in
     println(NSString(data: data, encoding: NSUTF8StringEncoding))
     }) { (error) -> Void in
     println(error)
     }
     
     */
    
    func getBusinessInformationOf(businessId: String, localeParameters: Dictionary<String, String>? = nil, completion: (data: NSData, response: NSHTTPURLResponse) -> Void, failureSearch: (error: NSError) -> Void) {
        let businessInformationUrl = APIBaseUrl + "business/" + businessId
        var parameters = localeParameters
        
        if parameters == nil {
            parameters = Dictionary<String, String>()
        }
        clientOAuth!.get(businessInformationUrl, parameters: parameters!, success: completion, failure: failureSearch)
       
    }
    
}

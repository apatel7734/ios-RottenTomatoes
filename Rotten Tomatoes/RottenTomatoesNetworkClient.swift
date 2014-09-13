//
//  RottenTomatoesNetworkClient.swift
//  Rotten Tomatoes
//
//  Created by Ashish Patel on 9/11/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class RottenTomatoesNetworkClient: NSObject {
    
    let RTAPIKEY:String = "kbaevw39bnwehvgepssgthad"
    var RottenTomatoesURLString:String = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=kbaevw39bnwehvgepssgthad"
    
    func getRentalMovies(){
        
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue)
            if parsedResult != nil {
                let dictionary = parsedResult! as NSDictionary
            }
        })
    }
   
}

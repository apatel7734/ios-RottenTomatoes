//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by Ashish Patel on 9/13/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    
    var movieUrl :String! = ""
    var poster :NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var posterUrl = poster["thumbnail"] as String
        //load low res image
        var detPosterUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "mob", options: nil, range: nil)
                println("detPosterUrl \(detPosterUrl)")
        imageViewMoviePoster.setImageWithURL(NSURL(string: detPosterUrl))

        //load high res image
        var origPosterUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: nil, range: nil)
        println("OrigPosterUrl \(origPosterUrl)")
        imageViewMoviePoster.setImageWithURL(NSURL(string: origPosterUrl))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}

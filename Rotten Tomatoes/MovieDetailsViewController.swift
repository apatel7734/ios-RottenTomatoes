//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by Ashish Patel on 9/13/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    
    @IBOutlet weak var scrollViewMovieDetail: UIScrollView!
    
    @IBOutlet weak var labelMovieDetail: UILabel!
    
    @IBOutlet weak var uiView: UIView!
    var movieUrl :String! = ""
    var poster :NSDictionary = [:]
    var synopsis :String = "The epic action of \"Edge of Tomorrow\" unfolds in a near future in which an alien race has hit the Earth in an unrelenting assault, unbeatable by any military unit in the world. Major William Cage (Tom Cruise) is an officer who has never seen a day of combat when he is unceremoniously dropped into what amounts to a suicide mission. Killed within minutes, Cage now finds himself inexplicably thrown into a time loop-forcing him to live out the same brutal combat over and over, fighting and dying again...and again. But with each battle, Cage becomes able to engage the adversaries with increasing skill, alongside Special Forces warrior Rita Vrataski (Emily Blunt). And, as Cage and Rita take the fight to the aliens, each repeated encounter gets them one step closer to defeating the enemy.(C) Warner Bros"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewMovieDetail.delegate = self
        
        // Do any additional setup after loading the view.
        var posterUrl = poster["thumbnail"] as String
        //load low res image
        var detPosterUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "mob", options: nil, range: nil)
        imageViewMoviePoster.setImageWithURL(NSURL(string: detPosterUrl))
        
        //load high res image
        var origPosterUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: nil, range: nil)
        imageViewMoviePoster.setImageWithURL(NSURL(string: origPosterUrl))

        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        labelMovieDetail.text = synopsis
        labelMovieDetail.sizeToFit()
        
        let visibleHeight = screenSize.height - uiView.frame.origin.y
        let hiddenHeight = labelMovieDetail.frame.height - visibleHeight
        
        scrollViewMovieDetail.contentSize = CGSize(width: labelMovieDetail.frame.size.width, height: screenSize.height + hiddenHeight + labelMovieDetail.frame.origin.y)
        
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

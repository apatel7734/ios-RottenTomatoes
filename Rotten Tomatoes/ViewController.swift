//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by Ashish Patel on 9/10/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{
    
    
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet var tableViewMovies: UITableView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    
    var RottenTomatoesURLString:String = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?limit=30&country=us&apikey=kbaevw39bnwehvgepssgthad"
    var movies: [NSDictionary] = []
    var searchResultMovies: [NSDictionary] = []
    var imageCache = [String : UIImage]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //MARK: register all delegates
        tableViewMovies.dataSource = self
        moviesSearchBar.delegate = self
        moviesSearchBar.setShowsCancelButton(true, animated: true)
        self.networkErrorView.hidden=true
        
        //Refresh Control
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        self.refreshControl.addTarget(self, action: "reloadMoviesFromNetwork", forControlEvents: UIControlEvents.ValueChanged)
        self.tableViewMovies.addSubview(refreshControl)
        
        //before sending asynchronouse call
        progressView.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible=true
        reloadMoviesFromNetwork()
    }
    
    func reloadMoviesFromNetwork(){
        var request = NSURLRequest(URL: NSURL(string: RottenTomatoesURLString));
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response : NSURLResponse!, data : NSData!, error :NSError!) -> Void in
            //check for network error
            if(error != nil && error.code == -1009){
                println("Error code = \(error.code)")
                self.networkErrorView.hidden = false
            }else if(data != nil){
                //response recieved
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                self.movies = object["movies"] as [NSDictionary]
                self.searchResultMovies = self.movies
                UIApplication.sharedApplication().networkActivityIndicatorVisible=false
                self.tableViewMovies.reloadData()
            }
            if(self.refreshControl.refreshing){
                self.refreshControl.endRefreshing()
            }
            self.progressView.hidden=true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "moviecelltodetail"){
            if((sender?.isKindOfClass(MovieTableViewCell)) != nil){
                if(segue.destinationViewController.isKindOfClass(MovieDetailsViewController)){
                    var destinationVC = segue.destinationViewController as MovieDetailsViewController
                    let indexPath = self.tableViewMovies.indexPathForSelectedRow() as NSIndexPath?
                    let row = indexPath?.row
                    let movie = self.movies[row!]
                    destinationVC.poster = movie["posters"] as NSDictionary
                }
            }
        }
    }
    
    //MARK: Table view Delegate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var movieCell = tableView.dequeueReusableCellWithIdentifier("moviecell") as MovieTableViewCell
        var movie = searchResultMovies[indexPath.row]
        movieCell.labelMovieTitle.text = movie["title"] as? String
        movieCell.labelMovieSynopsis.text = movie["synopsis"] as? String
        
        
        var poster = movie["posters"] as NSDictionary
        var posterUrl = poster["thumbnail"] as String
        var mobPosterUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "mob", options: nil, range: nil)
        movieCell.imageViewMoviePoster.setImageWithURL(NSURL(string: mobPosterUrl))
        
        return movieCell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultMovies.count;
    }
    
    //MARK: Search Delegate Methods
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        println("searchBarTextDidEndEditing")
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        println("searchBarCancelButtonClicked")
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(!searchText.isEmpty){
            self.searchResultMovies.removeAll(keepCapacity: true)
            searchMovie(searchText)
        }else{
            searchResultMovies = movies
        }
        self.tableViewMovies.reloadData()
    }
    // search movies in original movies array and update to search result movies array
    func searchMovie(searchQuery: String){
        var counter: Int = 0
        for var i = 0 ;i < self.movies.count;i++ {
            var movie = self.movies[i] as NSDictionary
            var title  = movie["title"] as? String
            if(title?.rangeOfString(searchQuery) != nil){
                self.searchResultMovies.insert(movie, atIndex: counter  )
                counter++
            }
        }
    }
    
}


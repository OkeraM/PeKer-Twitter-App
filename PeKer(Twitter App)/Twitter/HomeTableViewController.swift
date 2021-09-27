//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Okera Murray on 9/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    @IBOutlet var twitterTableView: UITableView!
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    //code to refresh the screen to display new tweets
    let RefreshScreen = UIRefreshControl()
    
    //Code for logout
    @IBAction func LogoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.setValue(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      }
    
    //Section used to call functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweet()
       //Code for infinite scrolling of tweets. It adds 20 tweets at a time
       
        //code to refresh the screen to display new tweets
        RefreshScreen.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = RefreshScreen

        
    }
    
    @objc func loadTweet(){
        
        numberOfTweets = 20
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParam = ["count": numberOfTweets]
        

            TwitterAPICaller.client?.getDictionariesRequest(url: myURL
                                                            , parameters: myParam, success: { (tweets: [NSDictionary]) in self.tweetArray.removeAll()
                                                                for tweet in tweets
                                                                { self.tweetArray.append(tweet)}
                                                                self.tableView.reloadData()
                                                                self.RefreshScreen.endRefreshing()
                                                            },
                                                            
                                                            failure: { (Error) in print("Could not retrieve tweets!")
                                                                
                                                            
                                                            })
}
    
    
    
    func InfiniteScrollTweets() {
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        
        let myParam = ["count": numberOfTweets]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL
                                                        , parameters: myParam, success: { (tweets: [NSDictionary]) in self.tweetArray.removeAll()
                                                            for tweet in tweets
                                                            { self.tweetArray.append(tweet)}
                                                            self.tableView.reloadData()
                                                            self.RefreshScreen.endRefreshing()
                                                        },
                                                        
                                                        failure: { (Error) in print("Could not retrieve tweets!")
                                                            
                                                        
                                                        })
}
        
        
    
    

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let tweet_content = tweetArray[indexPath.row]["text"] as! String
        let twit_name = tweetArray[indexPath.row]["user"] as! NSDictionary
        //code for twitter account name
        cell.TwitterName.text = twit_name["name"] as? String
        //code for tweet data
        cell.TweetSection.text = tweet_content
        //code for profile pic in twitter
        let imageUrl = URL(string: (twit_name["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.ProfilePic.image = UIImage(data: imageData)
        }
        
        return cell
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
   
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return tweetArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        if indexPath.row + 1 == tweetArray.count {
            //Code for infinite scrolling of tweets. It adds 20 tweets at a time
            InfiniteScrollTweets()
        }
    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

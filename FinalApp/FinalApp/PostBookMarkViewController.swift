//
//  PostBookMarkViewController.swift
//  FinalApp
//
//  Created by KPUGAME on 17/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class PostBookMarkViewController: UITableViewController {

    @IBOutlet var postBookMarkTableView: UITableView!
    
    var postName = [String]()
    var postAddr = [String]()
    
    var name : String = ""
    var name_utf8 : String = ""
    
    var url : String = "http://www.koreapost.go.kr/koreapost/openapi/searchPostSearchList.do?serviceKey=z7190426177ek62828gd178482447&pageCount=20&postTextType=A"
    
    func loadData() {
        
        //for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
        //    print("\(key) : \(value)")
        //}
        
        let data = UserDefaults.standard.value(forKey: "title")
        let data2 = UserDefaults.standard.value(forKey: "address")
        
        if data != nil {
            postName = data as! [String]
        }
        if data2 != nil {
             postAddr = data2 as! [String]
        }
        
        postBookMarkTableView!.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPostDetail" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                name = postName[(indexPath?.row)!].components(separatedBy: [" ", "\n"]).joined()
                
                print(postName)
                // url에서 한글을 쓸수 있도록 코딩
                name_utf8 = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                
                print(name_utf8)
                // 선택한 row의 병원명을 추가하여 url 구성하고 넘겨줌
                if let postDetailViewController = segue.destination as? PostDetail2ViewController  {
                    
                    postDetailViewController.posturl = url + "&postTopId=se&postSearchText=" + name_utf8
                    //print(postDetailViewController.posturl)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        cell.textLabel?.text = postName[indexPath.row]
        cell.detailTextLabel?.text = postAddr[indexPath.row]
        
        return cell
    }
    

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


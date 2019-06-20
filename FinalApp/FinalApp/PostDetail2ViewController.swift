//
//  PostDetailViewController.swift
//  FinalApp
//
//  Created by KPUGAME on 03/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class PostDetail2ViewController: UITableViewController, XMLParserDelegate {
    
    @IBOutlet var detailTableView : UITableView!
    
    var posturl : String?
    
    var parser = XMLParser()
    let postname : [String] = ["우체국 지점명", "우체국 주소", "우체국 전화번호", "우체국 운영시간", "365코너 유무", "주변 교통"]
    
    var posts : [String] = ["", "", "", "", "", ""]
    
    var element = NSString()
    
    var postNm = NSMutableString()      // 병원지점이름
    var postAddr = NSMutableString()        // 병원주소
    var postTel = NSMutableString()
    var postTime = NSMutableString()
    var post365Yn = NSMutableString()
    var postSubWay = NSMutableString()
    
    
    // parser 오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML 파싱시작
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:posturl!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    // parser가 새로운 element를 발견하면 변수를 생성한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "postItem")
        {
            posts = ["", "", "", "", "", ""]
            
            postNm = NSMutableString()
            postNm = ""
            postAddr = NSMutableString()
            postAddr = ""
            postTel = NSMutableString()
            postTel = ""
            postTime = NSMutableString()
            postTime = ""
            post365Yn = NSMutableString()
            post365Yn = ""
            postSubWay = NSMutableString()
            postSubWay = ""
        }
    }
    
    // title과 pubData를 발견하면 title1과 date에 완성한다.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "postNm") {
            postNm.append(string)
        } else if element.isEqual(to: "postAddr") {
            postAddr.append(string)
        } else if element.isEqual(to: "postTel") {
            postTel.append(string)
        } else if element.isEqual(to: "postTime") {
            postTime.append(string)
        } else if element.isEqual(to: "post365Yn") {
            post365Yn.append(string)
        } else if element.isEqual(to: "postSubWay") {
            postSubWay.append(string)
        }
    }
    
    // element의 끝에서 feed데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "postItem") {
            if !postNm.isEqual(nil) {
                posts[0] = postNm as String
            }
            if !postNm.isEqual(nil) {
                posts[1] = postAddr as String
            }
            if !postNm.isEqual(nil) {
                posts[2] = postTel as String
            }
            if !postNm.isEqual(nil) {
                posts[3] = postTime as String
            }
            if !postNm.isEqual(nil) {
                posts[4] = post365Yn as String
            }
            if !postNm.isEqual(nil) {
                posts[5] = postSubWay as String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = postname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        
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


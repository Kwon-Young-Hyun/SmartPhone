//
//  PostResultViewController.swift
//  FinalApp
//
//  Created by KPUGAME on 03/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class PostResultViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbData : UITableView!
    
    var posturl : String?
    
    // Xml 파일을 다운로드 및 파싱하는 오브젝트
    var parser = XMLParser()
    // feed 데이터를 저장하는 mutalble array
    var posts = NSMutableArray()
    // title과 data같은 feed 데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    
    // 저장 문자열 변수
    var postNm = NSMutableString()      // 병원지점이름
    var postAddr = NSMutableString()        // 병원주소
    var postLat = NSMutableString()        // 위도 정보
    var postLon = NSMutableString()        // 경도 정보
    var postDiv = NSMutableString()
    
    var postTotalPage = NSMutableString()
    
    // 병원이름 변수와 utf8 변수 추가
    var postName = ""
    var postName_utf8 = ""
    var pageNum = 1
    var pageTotalNum : Int? = 0
    var temp : Int? = 0
    
    let divarray : [Int : String] = [0 : "우체국",  1 : "우체국", 2 : "우체통", 5 : "우표판매소", 7 : "택배방"]
    
    let searchController = UISearchController(searchResultsController: nil)
    var filtered = NSArray()
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "모두") {
        filtered = posts.filter { (post) -> Bool in
            let temp = (post as! NSMutableDictionary).value(forKey: "postNm") as! NSString as String
            let div = ((post as! NSMutableDictionary).value(forKey: "postDiv") as! NSString).integerValue
            
            let doesCategoryMatch = (scope == "모두") || (divarray[div] == scope)
            
            if searchBarIsEmpty() {
                //print(doesCategoryMatch)
                return doesCategoryMatch
            } else {
                //print(temp, " : ", searchText)
                //print(doesCategoryMatch)
                return doesCategoryMatch && temp.contains(searchText)
            }
        } as NSArray
        print(filtered)
        tbData.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPostMap" {
            if let postMapViewController = segue.destination as? PostMapViewController {
                postMapViewController.posts = posts
            }
        }
        if segue.identifier == "segueToPostDetail" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                postName = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "postNm") as! NSString as String
                postName = postName.components(separatedBy: [" ", "\n"]).joined()
                print(postName)
                // url에서 한글을 쓸수 있도록 코딩
                postName_utf8 = postName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                
                print(postName_utf8)
                // 선택한 row의 병원명을 추가하여 url 구성하고 넘겨줌
                if let postDetailViewController = segue.destination as? PostDetailViewController  {
                    
                    let range = posturl!.range(of: "SearchText=")!
                    let range2 = posturl!.startIndex..<range.upperBound
                    
                    postDetailViewController.posturl = posturl![range2] + postName_utf8
                    //print(postDetailViewController.posturl)
                }
            }
        }
    }
    
    // parser 오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML 파싱시작
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:posturl!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func moreParsing()
    {
        parser = XMLParser(contentsOf: (URL(string:posturl!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    // parser가 새로운 element를 발견하면 변수를 생성한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "postItem")
        {
            elements = NSMutableDictionary()
            elements = [:]
            postNm = NSMutableString()
            postNm = ""
            postAddr = NSMutableString()
            postAddr = ""
            postLat = NSMutableString()
            postLat = ""
            postLon = NSMutableString()
            postLon = ""
            postDiv = NSMutableString()
            postDiv = ""
        }
        if (elementName as NSString).isEqual(to: "postMsgHeader")
        {
            postTotalPage = NSMutableString()
            postTotalPage = ""
        }
    }
    
    // title과 pubData를 발견하면 title1과 date에 완성한다.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "postNm") {
            postNm.append(string)
        } else if element.isEqual(to: "postAddr") {
            postAddr.append(string)
        } else if element.isEqual(to: "postLat") {
            postLat.append(string)
        } else if element.isEqual(to: "postLon") {
            postLon.append(string)
        } else if element.isEqual(to: "postDiv") {
            postDiv.append(string)
        } else if element.isEqual(to: "totalPage") {
            postTotalPage.append(string)
        }
    }
    
    // element의 끝에서 feed데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "postItem") {
            if !postNm.isEqual(nil) {
                elements.setObject(postNm, forKey: "postNm" as NSCopying)
            }
            if !postAddr.isEqual(nil) {
                elements.setObject(postAddr, forKey: "postAddr" as NSCopying)
            }
            if !postLat.isEqual(nil) {
                elements.setObject(postLat, forKey: "postLat" as NSCopying)
            }
            if !postLon.isEqual(nil) {
                elements.setObject(postLon, forKey: "postLon" as NSCopying)
            }
            if !postDiv.isEqual(nil) {
                elements.setObject(postDiv, forKey: "postDiv" as NSCopying)
            }
            posts.add(elements)
        }
        if (elementName as NSString).isEqual(to: "postMsgHeader") {
            if !postTotalPage.isEqual(nil) {
                pageTotalNum = (postTotalPage as NSString).integerValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
       
        tbData.estimatedRowHeight = 100.0;
        tbData.rowHeight = UITableView.automaticDimension;
        tbData.tableFooterView = UIView(frame: .zero)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Posts"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = ["모두", "우체국", "우체통", "우표판매소", "택배방"]
        searchController.searchBar.delegate = self
        
        
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
        if isFiltering() {
            return filtered.count
        }
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        var imageType = NSString()
        
        if isFiltering() {
            cell.TitleText?.text = (filtered.object(at: indexPath.row) as AnyObject).value(forKey: "postNm") as! NSString as String
            cell.AddressText?.text = (filtered.object(at: indexPath.row) as AnyObject).value(forKey: "postAddr") as! NSString as String
            
            imageType = (filtered.object(at: indexPath.row) as AnyObject).value(forKey: "postDiv") as! NSString
        } else {
            cell.TitleText?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "postNm") as! NSString as String
            cell.AddressText?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "postAddr") as! NSString as String
            
            imageType = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "postDiv") as! NSString
        }
        
        if imageType.contains("0") {
            cell.ImageView?.image = UIImage(named:"우체국")
        } else if imageType.contains("1") {
            cell.ImageView?.image = UIImage(named:"우체국")
        } else if imageType.contains("2") {
            cell.ImageView?.image = UIImage(named:"우체통")
        } else if imageType.contains("3") {
            cell.ImageView?.image = UIImage(named:"365")
        } else if imageType.contains("4") {
            cell.ImageView?.image = UIImage(named:"무인창구")
        } else if imageType.contains("5") {
            cell.ImageView?.image = UIImage(named:"우표")
        } else if imageType.contains("7") {
            cell.ImageView?.image = UIImage(named:"택배방")
        } else {
            cell.ImageView?.image = UIImage(named:"365")
        }
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if indexPath.row == posts.count - 1{
            if pageNum < pageTotalNum! {
                let range = posturl!.startIndex..<posturl!.index(before: posturl!.endIndex)
                pageNum += 1
                posturl = posturl![range] + String(pageNum)
                moreParsing()
            }
        }
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

extension PostResultViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension PostResultViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope : Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles! [selectedScope])
    }
}

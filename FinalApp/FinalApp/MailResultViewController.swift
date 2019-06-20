//
//  MailResultViewController.swift
//  FinalApp
//
//  Created by KPUGAME on 03/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class MailResultViewController: UITableViewController, XMLParserDelegate {

     @IBOutlet var tbData : UITableView!
    
    var mailurl : String?
    
    // Xml 파일을 다운로드 및 파싱하는 오브젝트
    var parser = XMLParser()
    // feed 데이터를 저장하는 mutalble array
    var mails = NSMutableArray()
    // title과 data같은 feed 데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    
    // 저장 문자열 변수
    var zipNo = NSMutableString()      // 병원지점이름
    var lnmAdres = NSMutableString()        // 병원주소
    
    // parser 오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML 파싱시작
    func beginParsing()
    {
        mails = []
        parser = XMLParser(contentsOf: (URL(string:mailurl!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    // parser가 새로운 element를 발견하면 변수를 생성한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "newAddressListAreaCdSearchAll")
        {
            elements = NSMutableDictionary()
            elements = [:]
            zipNo = NSMutableString()
            zipNo = ""
            lnmAdres = NSMutableString()
            lnmAdres = ""
        }
    }
    
    // title과 pubData를 발견하면 title1과 date에 완성한다.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "zipNo") {
            zipNo.append(string)
        } else if element.isEqual(to: "lnmAdres") {
            lnmAdres.append(string)
        }
    }
    
    // element의 끝에서 feed데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "newAddressListAreaCdSearchAll") {
            if !zipNo.isEqual(nil) {
                elements.setObject(zipNo, forKey: "zipNo" as NSCopying)
            }
            if !lnmAdres.isEqual(nil) {
                elements.setObject(lnmAdres, forKey: "lnmAdres" as NSCopying)
            }
            mails.add(elements)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        tbData.estimatedRowHeight = 100.0;
        tbData.rowHeight = UITableView.automaticDimension;
        tbData.tableFooterView = UIView(frame: .zero)
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
        return mails.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell2
        
        cell.TitleText?.text = (mails.object(at: indexPath.row) as AnyObject).value(forKey: "zipNo") as! NSString as String
        cell.AddText?.text = (mails.object(at: indexPath.row) as AnyObject).value(forKey: "lnmAdres") as! NSString as String
        
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

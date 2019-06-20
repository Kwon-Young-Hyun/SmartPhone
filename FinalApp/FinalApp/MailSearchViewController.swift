//
//  MailSearchViewController.swift
//  FinalApp
//
//  Created by KPUGAME on 03/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class MailSearchViewController: UIViewController {
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var mailButton: UIButton!
    
    var mailurl : String = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll?serviceKey=em%2B7JHjdb1%2BmiNAV%2BTUXV6JLNMJJJ0T64rIzngv9LRGamxn%2F5m86Wu9sa38ldjNlKT1YYBXD6niqvh1g%2Bd31Fw%3D%3D&countPerPage=10&currentPage=1&srchwrd="
    
    var searchText : String = ""
    
    @IBAction func doneToMailSearchViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMailResult" {
            if let navController = segue.destination as? UINavigationController {
                if let mailResultViewController = navController.topViewController as? MailResultViewController {
                    mailResultViewController.mailurl = mailurl + searchText
                }
            }
        }
    }
    
    @IBAction func mailButtonPush(_ sender: Any) {
        searchText = mailText.text as! String
        searchText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let width = UIScreen.main.bounds.size.width
        
        let startX : CGFloat = width / 2
        let startY : CGFloat = -50
        
        let rain = RainView(frame: CGRect(x: startX, y: startY, width: 50, height: 50))
        self.view.addSubview(rain)
        self.view.sendSubviewToBack(_: rain)
        
        self.view.addBackground2()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
    func addBackground2() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "바탕3.png")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}

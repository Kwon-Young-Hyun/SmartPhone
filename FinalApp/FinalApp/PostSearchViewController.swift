//
//  PostSearchViewController.swift
//  FinalApp
//
//  Created by KPUGAME on 03/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class PostSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var PostText: UITextField!
    @IBOutlet weak var PostButton: UIButton!
    @IBOutlet weak var PostLocalPickerView: UIPickerView!
    @IBOutlet weak var imageCar: UIImageView!
    @IBOutlet weak var imageBox: UIImageView!
    
    var startX : CGFloat = 47
    
    var LocalDataSource = ["서울", "경기도&인천", "부산", "충청도", "경상도", "강원도", "전라남도", "전라북도", "제주도"]
    
    var posturl : String = "http://www.koreapost.go.kr/koreapost/openapi/searchPostSearchList.do?serviceKey=z7190426177ek62828gd178482447&pageCount=20&postTextType=A"
    
    var searchText : String = ""
    var localText : String = "se"
    var Boxjump = false;
    
    // HospitalTableView의 Done 버튼을 누르면 동작하는 unwind 메소드
    // 아무 동작도 하지 않지만 이 메소드가 있어야지 HospitalTableViewController에서 unwind 연결이 가능
    @IBAction func doneToPostSearchViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPostResult" {
            if let navController = segue.destination as? UINavigationController {
                if let postResultViewController = navController.topViewController as? PostResultViewController {
                    postResultViewController.posturl = posturl + "&postTopId=" + localText + "&postSearchText=" + searchText + "&nowPage=1"
                    print(posturl + "&postTopId=" + localText + "&postSearchText=" + searchText + "&nowPage=1")
                }
            }
        }
    }
    
    @IBAction func PostButtonPush(_ sender: Any) {
        searchText = PostText.text as! String
        searchText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LocalDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LocalDataSource[row]
    }
    
    //"서울", "경기도&인천", "부산", "충청도", "경상도", "강원도", "전라남도", "전라북도", "제주도"
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {               // 서울
            localText = "se"
        } else if row == 1 {        // 경인
            localText = "gi"
        } else if row == 2 {       // 부산
             localText = "bs"
        } else if row == 3 {        // 충청도
            localText = "cc"
        } else if row == 4 {        // 경상도
             localText = "kb"
        } else if row == 5 {        // 강원도
             localText = "kw"
        } else if row == 6 {        // 전라남도
             localText = "jn"
        } else if row == 7 {        // 전라북도
             localText = "jb"
        } else if row == 8 {        // 제주도
             localText = "jj"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addBackground1()
        
        self.PostLocalPickerView.delegate = self;
        self.PostLocalPickerView.dataSource = self;

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.imageCar?.center.x = startX
        
        let endX = startX + UIScreen.main.bounds.size.width - 100
        let endY = imageCar.center.y
        
        UIView.animate(
            withDuration: 2.0,
            delay: 0,
            options: [UIView.AnimationOptions.curveEaseOut, .repeat],
            animations: {
                self.imageCar?.center = CGPoint(x: endX, y: endY)
        },
            completion: nil)
        
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
    func addBackground1() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height - 200))
        imageViewBackground.image = UIImage(named: "바탕3.png")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}

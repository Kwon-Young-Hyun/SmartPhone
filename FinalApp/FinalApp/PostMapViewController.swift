//
//  PostMapViewController.swift
//  FinalApp
//
//  Created by KPUGAME on 03/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit
import MapKit

class PostMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    
    // 이 지역은 regionRadius (5000m)의 거리에 따라 남북 및 동서에 걸쳐있을 것이다.
    let regionRadius: CLLocationDistance = 5000
    // regionRadius 사용
    // setRegion은 region을 표시하도록 mapView에 지시
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)

        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var postitems : [Post] = []
    
    // 전송받은 posts배열에서 정보를 얻어서 Hospital 객체를 샘ㅇ성하고 배열에 추가 생성
    func loadInitialData() {
        for post in posts {
            let postNm = (post as AnyObject).value(forKey: "postNm") as! NSString as String
            let postAddr = (post as AnyObject).value(forKey: "postAddr") as! NSString as String
            let postLat = (post as AnyObject).value(forKey: "postLat") as! NSString as String
            let postLon = (post as AnyObject).value(forKey: "postLon") as! NSString as String
            let lat = (postLat as NSString).doubleValue
            let lon = (postLon as NSString).doubleValue
            let postitem = Post(title: postNm, locationName: postAddr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            postitems.append(postitem)
        }
    }
    
    // 사용자가 지도 주석 마커를 탭하면 설명 선에 info button이 표시.
    // info button을 누르면 mapView(_:annotationView:calloutAccesssoryControlTapped:)메서드가 호출
    // Artwork탭에서 참조하는 객체 항목을 만들고 지도 항목을 MkMapItem호출하여 지도 앱을 실행합니다.
    // openInMaps(launchOption:) 몇 가지 옵션을 지저할 수 있음. 여기는 DirectionModeKey로 Driving 설정
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Post
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    // 1. mapView는 tableView 테이블 보기로 작업 할 때와 마찬가지로,
    // 지도에 추가하는 모든 주석이 호출되어 각 주석에 대한 보기를 반환
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2. 주석이 Artwork객체 인지 확인! 그렇지 않으면 nil지도 뷰에서 기본 주석 뷰를 사용하도록 돌아감.
        guard let annotation = annotation as? Post else { return nil }
        // 3. 마커가 나타나게 MKMarkerAnnotationView뷰를 만듦
        // 이 자습서의 뒷부분에서는 MKAnnotaionView마커 대신 이미지를 표시하는 객체를 만듭니다.
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4. 코드를 새로 생성하기 전에 재사용 가능한 주석 뷰를 사용할 수 있는 지 먼저 확인
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5. MKMarkerAnnotationView 주석보기에서 대기열에서 삭제할 수 없는 경우 여기에서 새 객체를 만듭니다.
            // Artwork클래스의 title 및 subtitle 속성을 사용하여 콜 아웃에 표시할 내용을 결정
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let postLat = (posts[0] as AnyObject).value(forKey: "postLat") as! NSString as String
        let postLon = (posts[0] as AnyObject).value(forKey: "postLon") as! NSString as String
        let lat : CLLocationDegrees = (postLat as NSString).doubleValue as CLLocationDegrees
        let lon : CLLocationDegrees = (postLon as NSString).doubleValue as CLLocationDegrees

        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        centerMapOnLocation(location: initialLocation)

        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(postitems)
        
        // Do any additional setup after loading the view.
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

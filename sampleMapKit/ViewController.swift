//
//  ViewController.swift
//  sampleMapKit
//
//  Created by yuka on 08/11/2017.
//  Copyright © 2017 yuka. All rights reserved.
//

import UIKit
import MapKit //地図用のフレームワーク

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //display a map centered on the ayala
        
        //1.pinオブジェクトを生成
        let cPin1 = MKPointAnnotation()
        let cPin2 = MKPointAnnotation()
        let cPin3 = MKPointAnnotation()
        //2.pinの座標を設定
        //直接指定することも、クラスのインスタンスを代入することもできる
        cPin1.coordinate = CLLocationCoordinate2DMake(10.317347, 123.905759)
        cPin2.coordinate = CLLocationCoordinate2DMake(9.834949, 118.738362)
        cPin3.coordinate = CLLocationCoordinate2DMake(9.199878, 123.595193)
        
        //3.タイトル、サブタイトルを設定（タップした時に出る吹き出し(最新は吹き出しじゃない)の情報）
        cPin1.title = "アヤラショッピングモール"
        cPin1.subtitle = "迷いやすいぞ"
        
        cPin2.title = "パラワン"
        cPin2.subtitle = "行きたいぞ"
        
        
        cPin3.title = "シキホル島"
        cPin3.subtitle = "来月行こっと"
 
        var cPins:[MKAnnotation] = [ cPin1,cPin2,cPin3]
        //1.中心となる場所の座標オブジェクトを作成
        
        //３点の最大と最小を出して、両端の中央を中心地にする
        //倍率は最大値と最小値の差で出す（といい感じで両端になったので）
        
        //緯度経度、それぞれ最大最小値の計算
        var maxlat = cPin1.coordinate.latitude
        var minlat = cPin1.coordinate.latitude
        var maxlong = cPin1.coordinate.longitude
        var minlong = cPin1.coordinate.longitude
        
        for i in 1...2 {
            if maxlat < cPins[i].coordinate.latitude {
                maxlat = cPins[i].coordinate.latitude
            }
            else if minlat > cPins[i].coordinate.latitude {
                minlat = cPins[i].coordinate.latitude
            }
            if maxlong < cPins[i].coordinate.longitude {
                maxlong = cPins[i].coordinate.longitude
            }
            else if minlong > cPins[i].coordinate.longitude {
                minlong = cPins[i].coordinate.longitude
            }
        }
        print("maxlat: \(maxlat)")
        print("minlat: \(minlat)")
        print("maxlong: \(maxlong)")
        print("minlong: \(minlong)")

        // 中央値の緯度と経度の設定
        let latitude = ( maxlat + minlat ) / 2

        let longitude = ( maxlong + minlong ) / 2

       
        let coodinate = CLLocationCoordinate2DMake(latitude,longitude)
        
        //2.縮尺を設定
        //  let span = MKCoordinateSpanMake(1, 1)
        
        //最大と最小の差
        let bairitsu_lat: CLLocationDegrees  = CLLocationDegrees( maxlat - minlat )
        let bairitsu_long: CLLocationDegrees  = CLLocationDegrees( maxlong - minlong )
            // * 1度は110.94297キロ
        print("bairitsu_lat: \(bairitsu_lat)")
        print("bairitsu_long: \(bairitsu_long)")
        let span = MKCoordinateSpanMake(bairitsu_lat, bairitsu_long
        )
        
        //3.範囲オブジェクトを作成する
        let region = MKCoordinateRegionMake(coodinate, span)
        
        
        //4.MapViewに範囲オブジェクトを設定
        mapView.setRegion(region, animated: true)
        
        
        //4.mapViewにPinを追加
        for i in 0...cPins.count-1 {
            mapView.addAnnotation(cPins[i])
        }
    
        mapView.delegate = self

        
    }
    
    
    //ピンの設定。delegate時に設定したピンごとに実行されるのかな？
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let myMkAntView = MKPinAnnotationView()

        myMkAntView.annotation = annotation

        myMkAntView.canShowCallout = true
        
        if(annotation.title! == "アヤラショッピングモール") {
            myMkAntView.pinTintColor = UIColor.purple

        }
        
        //ナニコレ？
        myMkAntView.image = UIImage(named: "Red-Kitten.jpg")
        
        return myMkAntView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


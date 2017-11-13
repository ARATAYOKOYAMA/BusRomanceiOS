//
//  InitialSettingThirdViewController.swift
//  BusRomance
//
//  Created by 山口賢登 on 2017/10/19.
//  Copyright © 2017年 バスロマン. All rights reserved.
//

import UIKit
import RealmSwift

class FrequentlyPlaceObject:Object{
    @objc dynamic var busStop1 = ""
    @objc dynamic var busStop2 = ""
    @objc dynamic var busStop3 = ""
}

class InitialSettingThirdViewController: UIViewController {

    
    @IBOutlet weak var entryPlaceTextField: PickerTextField!
    @IBOutlet weak var entryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //グラデーションの開始色
        let topColor = UIColor(red:0.416, green:0.608, blue:0.784, alpha:1)
        //グラデーションの開始色
        let bottomColor = UIColor(red:0.459, green:0.996, blue:0.992, alpha:1)
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds
        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        entryButton.layer.borderWidth = 4.0 // 枠線の幅
        entryButton.layer.borderColor = UIColor.white.cgColor // 枠線の色
        entryButton.layer.cornerRadius = 8.0 // 角丸のサイズ
        entryPlaceTextField.setup(dataList: ["バス停を選択してください","はこだて未来大学", "赤川貯水池", "赤川3区", "赤川小学校", "浄水場下", "低区貯水池", "赤川入口", "赤川１丁目ライフプレステージ白ゆり美原前", "赤川通","函館地方気象台前"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func entryButton(_ sender: Any) {
        let realm = try! Realm()
        let obj = FrequentlyPlaceObject()
        if entryPlaceTextField.text! != ""{//何か選ばれているとき
            obj.busStop1 = entryPlaceTextField.text!
            try! realm.write {
                realm.add(obj)
            }
            let resutls = realm.objects(FrequentlyPlaceObject.self)
            print(resutls.last!.busStop1)
            performSegue(withIdentifier: "toMain",sender: nil)
              }else {//何も入っていないとき
                let alertController = UIAlertController(title: "",message: "バス停を登録してください", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
                    print("OK")
                }
                let cancelButton = UIAlertAction(title: "閉じる", style: UIAlertActionStyle.cancel, handler: nil)
                alertController.addAction(okAction)
                alertController.addAction(cancelButton)
                present(alertController,animated: true,completion: nil)
            
            }
            
        }



}

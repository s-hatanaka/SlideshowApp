//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 畑中 彩里 on 2020/04/14.
//  Copyright © 2020 sari.hatanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    
    
    
    // 画像の名前の配列
    
    let imageNameArray = ["dog.jpg", "cat.jpg", "monkey.jpg"]
    
    // 表示している画像の番号
    var displayImageNo = 0
    var timer: Timer!
    var timer_sec: Float = 0
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval:2.0,target: self, selector: #selector(updateTimer(_:)),
                    userInfo: nil, repeats: true)
        
//　　　　　 初期画面
            let image = UIImage(named: "dog.jpg")
            self.imageView.image = image
        
            
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "nextView" {
           let nextViewController: NextViewController = segue.destination as! NextViewController
            
                    let name = imageNameArray[displayImageNo]
                
                       let image =  UIImage(named: name)
                      
                       nextViewController.zoomimg = image
              
            
            
           }
           
       }
    
    
    
    func displayImage() {
            
            let name = self.imageNameArray[self.displayImageNo]
            
            let image = UIImage(named: name)

            self.imageView.image = image
            
      
        }
 
    
  /// 戻るボタン
    @IBAction func backButton(_ sender: Any) {
        
        if  self.displayImageNo >= 1 && self.displayImageNo <= self.imageNameArray.count - 1 {
            self.displayImageNo -= 1
            self.displayImage()
        } else{
            self.displayImageNo = self.imageNameArray.count - 1
            self.displayImage()
            
            }
    }
    
    
   /// 進むボタン
    @IBAction func nextButton(_ sender: Any) {
               
        if  self.displayImageNo < self.imageNameArray.count - 1 {
            self.displayImageNo += 1
            self.displayImage()
        } else {
            self.displayImageNo = 0
            self.displayImage()
            }
           
    }
    
    
   
    /// 再生/停止ボタン
    @IBAction func switchButton(_ sender: Any) {
    
    
        if self.timer == nil {
           timer = Timer.scheduledTimer(timeInterval:2.0,target: self, selector: #selector(updateTimer(_:)),
           userInfo: nil, repeats: true)
            
            nextButton.isEnabled = false
            backButton.isEnabled = false
            
            switchButton.setTitle("停止", for: .normal)
            
            
    } else  if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
       
            nextButton.isEnabled = true
            backButton.isEnabled = true
            
            switchButton.setTitle("再生", for: .normal)
        }
       
    }
    
    
    
    @objc func updateTimer(_ timer: Timer) {
       if  self.displayImageNo < self.imageNameArray.count - 1 {
           self.displayImageNo += 1
           self.displayImage()
    } else {
           self.displayImageNo = 0
           self.displayImage()
         }
    }
    
 ///  画像タップの処理
    @IBAction func tapAction(_ sender: Any) {
        self.performSegue(withIdentifier: "nextView", sender: nil)
        
        if self.timer != nil {
             self.timer.invalidate()
             self.timer = nil
        
             nextButton.isEnabled = true
             backButton.isEnabled = true
             
             switchButton.setTitle("再生", for: .normal)
         }
    }
    
    
    
      
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
    }
    
    
    
    }
    







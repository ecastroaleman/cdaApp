//
//  MainMenu.swift
//  cda2
//
//  Created by Emilio Castro on 12/31/19.
//  Copyright © 2019 Emilio Castro. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {

            	    
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    let imageArray = ["img1","img2","img3"]
    
  
    var imgArr = [UIImage(named: "img1"), UIImage(named: "img2"), UIImage(named: "img3")]
    
    var timer = Timer()
    var counter = 0
    var token = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0

    /*         pageControl.numberOfPages = imageArray.count
        for i in 0..<imageArray.count{
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: imageArray[i])
            let xPos = CGFloat(i)*self.view.bounds.size.width
            imageView.frame = CGRect(x:
                xPos, y: 0, width: view.frame.size.width, height: imageScroll2.frame.size.height)
            imageScroll2.contentSize.width = view.frame.size.width*CGFloat(i+1)
            imageScroll2.addSubview(imageView)
            
            
        }*/

        // Do any additional setup after loading the view.
        
    DispatchQueue.main.async {
               self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
@objc func changeImage() {
    
    if counter < imgArr.count {
        let index = IndexPath.init(item: counter, section: 0)
        self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        pageView.currentPage = counter
        counter += 1
    } else {
        counter = 0
        let index = IndexPath.init(item: counter, section: 0)
        self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        pageView.currentPage = counter
        counter = 1
    }
        
    }


}

extension MainMenu: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        return cell
    }
}

extension MainMenu: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

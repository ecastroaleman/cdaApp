//
//  MenuPrincipal.swift
//  cda2
//
//  Created by Emilio Castro on 1/1/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import UIKit

class MenuPrincipal: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
     var imgArr = [UIImage(named: "imag1"), UIImage(named: "imag2"), UIImage(named: "imag3")]
    let itemMenu = ["bus","cafeteria","uniformes","CL","eliminar"]
    let itemLabelMenu = ["Cambio de Bus","Pedido Cafeteria","Pedido Uniformes","Cursos Cocurriculares","Anular Pedido"]
    var timer = Timer()
     var counter = 0
    var token = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageControl.currentPage = 0
        pageControl.size(forNumberOfPages: imgArr.count)
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        print("El token obtenido es:"+token)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
           
           if segue.identifier == "bus" {
           let vc = segue.destination as! cambiosBus
            vc.items = "Cambios de Bus "
           }
       }
    
    @objc func changeImage() {
       
       if counter < imgArr.count {
           let index = IndexPath.init(item: counter, section: 0)
           self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
           pageControl.currentPage = counter
           counter += 1
       } else {
           counter = 0
           let index = IndexPath.init(item: counter, section: 0)
           self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
           pageControl.currentPage = counter
           counter = 1
       }
           
       }
   

}


extension MenuPrincipal: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension MenuPrincipal: UICollectionViewDelegateFlowLayout {
    
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
    
    //table view
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemMenu.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "customCell")as! customTableViewCell
       // cell2.cellView.layer.cornerRadius = cell2.cellView.frame.height / 2
        cell2.itemLabel.text = itemLabelMenu[indexPath.row]
        cell2.itemImage.image = UIImage(named: itemMenu[indexPath.row])
         cell2.itemImage.layer.cornerRadius = cell2.itemImage.frame.height / 2
        return cell2
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     //  tableView.deselectRow(at: indexPath, animated: false)
          let cell2 = tableView.dequeueReusableCell(withIdentifier: "customCell")as! customTableViewCell
        
      
        cell2.backgroundColor = UIColor(red: 7, green: 8, blue: 9, alpha: 0)
        cell2.itemLabel.text = "Estoy seleccionando"
        print (indexPath.row)
        self.performSegue(withIdentifier: "bus", sender: Any?.self)
        tableView.deselectRow(at: indexPath, animated: true)

               
            /*   let alertController = UIAlertController(title: "Hola", message: "is in da house!", preferredStyle: .alert)
               let action = UIAlertAction(title: "Ok", style: .default) { _ in }
               alertController.addAction(action)
               self.present(alertController, animated: true, completion: nil)*/
      
    ///    let cellBackground = UIView()
       //              cellBackground.backgroundColor = UIColor(white: 146/255, alpha: 1)
      //  currentCell.selectedBackgroundView = cellBackground
       /* let cell2 = tableView.dequeueReusableCell(withIdentifier: "customCell")as! customTableViewCell
       

        cell?.selectedBackgroundView = cellBackground
        return cell!*/
        
    }

}

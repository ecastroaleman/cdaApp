//
//  cambiosBus.swift
//  cda2
//
//  Created by Emilio Castro on 1/13/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import UIKit

class cambiosBus: UIViewController {

    @IBOutlet weak var item: UILabel!
    var items = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        item.text = items
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

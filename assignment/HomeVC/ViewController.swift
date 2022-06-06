//
//  ViewController.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import UIKit

class ViewController: UIViewController {
    var senderTag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func btnPagesAction(_ sender: UIButton) {
        senderTag = sender.tag
        self.performSegue(withIdentifier: "pages", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailVC {
            if senderTag == 0{
                detailVC.jsonPage = "CONTENTLISTINGPAGE-PAGE1"
            }else if senderTag == 1{
                detailVC.jsonPage = "CONTENTLISTINGPAGE-PAGE2"
            }else if senderTag == 2{
                detailVC.jsonPage = "CONTENTLISTINGPAGE-PAGE3"
            }
        }
    }
}


//
//  ViewController.swift
//  movie_app
//
//  Created by hungnt1 on 07/05/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var callAPIbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPIbtn.addTarget(self, action: #selector(callAPI), for: .touchUpInside)
        
    }
    
    @objc func callAPI() {
        NetworkManager.shared.getMovies { movies in
                debugPrint("Danh sách phim: \(movies)")
        }
    }
    
    
    
}


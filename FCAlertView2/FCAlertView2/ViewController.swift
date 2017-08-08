//
//  ViewController.swift
//  FCAlertView2
//
//  Created by Kris Penney on 2017-08-07.
//  Copyright © 2017 Kris Penney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let button: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Opening AlertView", for: .normal)
    button.addTarget(self, action: #selector(openAlertView), for: .touchUpInside)
    button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    button.center = self.view.center
    view.addSubview(button)
  }

  func openAlertView() {
    let alert = FCAlertView(title: "Testing", body: "This is all you have to do to make things happen!", theme: nil)
    alert.show(animated: true)
  }
}

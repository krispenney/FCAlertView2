//
//  FCModal.swift
//  FCAlertView2
//
//  Created by Kris Penney on 2017-08-07.
//  Copyright © 2017 Kris Penney. All rights reserved.
//

import UIKit

protocol FCModal {
  func show(animated:Bool)
  func dismiss(animated:Bool)
  var backgroundView:UIView {get}
  var dialogView:UIView {get set}
  var theme: FCAlertTheme {get set}
}

extension FCModal where Self:UIView{
  func show(animated:Bool){
    self.backgroundView.alpha = 0
    self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
    UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
    if animated {
      UIView.animate(withDuration: self.theme.animateInDuration, animations: {
        self.backgroundView.alpha = self.theme.backgroundViewAlpha
      })
      UIView.animate(withDuration: self.theme.animateInDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: {
        self.dialogView.center  = self.center
      }, completion: { (completed) in
        if self.theme.autoDismissSeconds > 0 {
          
          DispatchQueue.main.asyncAfter(deadline: .now() + self.theme.autoDismissSeconds, execute: {
            self.dismiss(animated: animated)
          })
        }
      })
    }else{
      self.backgroundView.alpha = self.theme.backgroundViewAlpha
      self.dialogView.center  = self.center
    }
  }
  
  func dismiss(animated:Bool){
    if animated {
      UIView.animate(withDuration: self.theme.animateOutDuration, animations: {
        self.backgroundView.alpha = 0
      }, completion: { (completed) in
        
      })
      UIView.animate(withDuration: self.theme.animateOutDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: {
        self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
      }, completion: { (completed) in
        self.removeFromSuperview()
      })
    }else{
      self.removeFromSuperview()
    }
    
  }
}

//
//  FCAlertView.swift
//  FCAlertView2
//
//  Created by Kris Penney on 2017-08-07.
//  Copyright © 2017 Kris Penney. All rights reserved.
//

import UIKit

class FCAlertView: UIView, FCModal {
  
  var backgroundView: UIView = UIView()
  
  var dialogView: UIView = {
    let dialog = UIView()
    dialog.clipsToBounds = true
    return dialog
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.baselineAdjustment = .alignCenters
    label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
    return label
  }()
  
  let bodyLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  let separatorLineView: UIView = {
    let separator = UIView()
    separator.backgroundColor = .groupTableViewBackground
    return separator
  }()
  
  var theme = FCAlertTheme()
  
  convenience init(title:String, body: String, theme: FCAlertTheme?) {
    self.init(frame: UIScreen.main.bounds)
    
    if let theme = theme {
      self.theme = theme
    }
    
    titleLabel.text = title
    bodyLabel.text = body
    let width = frame.width - self.theme.dialogMargin * 2
    
    let verticalStack = UIStackView()
    verticalStack.alignment = .fill
    verticalStack.axis = .vertical
    verticalStack.spacing = self.theme.dialogItemSpacing
    
    if !title.isEmpty {
      // MARK: Setup Title
      titleLabel.frame.origin = CGPoint(
        x: self.theme.dialogPadding,
        y: self.theme.dialogItemSpacing
      )
      titleLabel.frame.size.width = width - self.theme.dialogPadding*2
      titleLabel.sizeToFit()

      // MARK: Setup separator
      separatorLineView.backgroundColor = self.theme.separatorBackgroundColor
      separatorLineView.alpha = self.theme.separatorBackgroundAlpha
      separatorLineView.frame = CGRect(
        x: 0,
        y: titleLabel.frame.height + self.theme.dialogItemSpacing + titleLabel.frame.origin.y,
        width: width,
        height: 1
      )
      
      titleLabel.center.x = separatorLineView.bounds.midX
      dialogView.addSubview(titleLabel)
      dialogView.addSubview(separatorLineView)
    }
    
    // MARK: Setup Body Label
    if !body.isEmpty {
      let baseY = title.isEmpty ? 0 : (separatorLineView.frame.origin.y + separatorLineView.frame.height)
      bodyLabel.frame.origin = CGPoint(
        x: self.theme.dialogPadding,
        y: baseY + self.theme.dialogItemSpacing
      )
      bodyLabel.frame.size.width = width - self.theme.dialogPadding * 2
      bodyLabel.sizeToFit()
      bodyLabel.center.x = width / 2
      dialogView.addSubview(bodyLabel)
    }

    // MARK: Setup Dialog
    let spacing = self.theme.dialogItemSpacing * CGFloat(dialogView.subviews.count + 1)
    let height = titleLabel.frame.height + separatorLineView.frame.height + bodyLabel.frame.height + spacing
    
    dialogView.backgroundColor = self.theme.dialogBackgroundColor
    dialogView.alpha = self.theme.dialogBackgroundAlpha
    dialogView.layer.cornerRadius = self.theme.dialogCornerRadius
    dialogView.frame = CGRect(
      x: self.theme.dialogMargin,
      y: frame.height,
      width: frame.width - self.theme.dialogMargin * 2,
      height: height
    )
    
// MARK: Setup Background
    backgroundView.frame = frame
    backgroundView.backgroundColor = self.theme.backgroundViewColor
    backgroundView.alpha = self.theme.backgroundViewAlpha
    backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedBackgroundView)))
    
    addSubview(backgroundView)
    addSubview(dialogView)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func tappedBackgroundView() {
    dismiss(animated: true)
  }
}

//
//  CustomMessageView.swift
//  URLSessionMocking
//
//  Created by Harish on 12/07/23.
//

import UIKit

class CustomMessageView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        guard let xibs = Bundle(for: CustomMessageView.self).loadNibNamed("CustomMessageView", owner: self) as? [UIView] else {
            return
        }
        
        guard let view = xibs.first else {
            return
        }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func setMessage(message: String) {
        self.messageLabel.text = message
    }

}

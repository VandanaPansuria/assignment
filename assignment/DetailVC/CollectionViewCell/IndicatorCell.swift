//
//  IndicatorCell.swift
//  assignment
//
//  Created by MacV on 10/06/22.
//

import Foundation
import UIKit
class IndicatorCell: UICollectionViewCell {
    
    var indicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .whiteLarge
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        contentView.addSubview(indicator)
        indicator.frame = contentView.frame
        indicator.startAnimating()
    }
}

//
//  HighlightedButton.swift
//  Tribun
//
//  Created by yoga arie on 17/10/23.
//

import UIKit
		
class SelectedButton: UIButton {
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .gray : .red
        }
    }
}

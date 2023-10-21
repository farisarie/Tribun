//
//  ListViewCell.swift
//  Tribun
//
//  Created by yoga arie on 16/10/23.
//

import UIKit

final class ListViewCell: UITableViewCell {

    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 10
        newsImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

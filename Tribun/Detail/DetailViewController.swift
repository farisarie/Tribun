//
//  DetailViewController.swift
//  Tribun
//
//  Created by yoga arie on 16/10/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var categoryDetail: UILabel!
    @IBOutlet weak var dateDetail: UILabel!
    @IBOutlet weak var descDetail: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var authorDetail: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    var news: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup(){
        
        imageDetail.kf.setImage(with: URL(string: news?.image ?? ""))
        authorDetail.text = news?.link
        titleDetail.text = news?.title
        descDetail.text = news?.contentSnippet
        if let date = news?.isoDate {
            dateDetail.text = DateConverter.convertDate(date)
        }
    }

    @IBAction func detailButtonTapped(_ sender: UIButton) {
        if let url = URL(string: news?.link ?? "") {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
    }
    
}

extension UIViewController {
    func pushDetail(_ news: Datum) {
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        viewController.news = news
        navigationController?.pushViewController(viewController, animated: true)
    }
}

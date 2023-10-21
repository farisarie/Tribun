//
//  HomeViewController.swift
//  Tribun
//
//  Created by yoga arie on 16/10/23.
//

import UIKit
import Kingfisher

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var newsButtonStack: UIStackView!
    
    var currentSelectedButton: SelectedButton?
    var news: [Datum]?
    var categoryNewsMapping: [String: [Datum]] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [String] = [
        "All",
        "Bisnis",
        "Bola % Sports",
        "News",
        "Otomotif"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadData()
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for category in categories {
            if let categoryButtonView = Bundle.main.loadNibNamed("CategoryButton", owner: nil, options: nil)!.first as? CategoryButton,
                let categoryButton = categoryButtonView.categoryButton as? SelectedButton {
                
                categoryButtonView.categoryButton.setTitle(category, for: .normal)
                
                categoryButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
                
                categoryButtonView.translatesAutoresizingMaskIntoConstraints = false
                
                newsButtonStack.addArrangedSubview(categoryButtonView)
            }
        }
    }
    
    
    // Notes -> currentSelectedButton is the previous button get pressed and it needs to back to the default
    
    @objc func categoryButtonTapped(_ sender: SelectedButton) {
        if currentSelectedButton != sender {
            currentSelectedButton?.isSelected = false
            sender.isSelected = true
            currentSelectedButton = sender
        }
        
        let selectedCategory = sender.titleLabel?.text ?? ""
        // Notes -> categoryNewsMapping[All]
        news = categoryNewsMapping[selectedCategory] ?? []
        tableView.reloadData()
    }
    
    func setup() {
        tableView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "list_cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        title = "Tribun News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func chunkedNews(from news: [Datum], chunkSize: Int) -> [[Datum]] {
        // [0, 4, 8, 12, 16]
        /*
         From index 0 to 3 (4 items)
         From index 4 to 7 (4 items)
         From index 8 to 11 (4 items)
         From index 12 to 15 (4 items)
         From index 16 to 19 (4 items)
         */
        return stride(from: 0, to: news.count, by: chunkSize).map { // let squares = stride(from: 0, through: 10, by: 1).map { $0 * $0 }
         //   print(squares)  [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

            
            Array(news[$0..<$0 + chunkSize])
            
        }
        
       
    }
    
    func loadData(){
        NewsProvider.shared.listNews { result in
            switch result {
            case .success(let data):
                self.news = data
                print(data)
                let newsChunks = self.chunkedNews(from: data, chunkSize: 4) // Assuming you want chunks of size 5
                for (index, category) in self.categories.enumerated() {
                    self.categoryNewsMapping[category] = newsChunks[safe: index]
                }
                
                
                self.tableView.reloadData()
            case .failure(let error):
                print("Error fetching news: \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath) as? ListViewCell else { return UITableViewCell() }
        
        let newsData = news?[indexPath.row]
        
        cell.newsTitle.text = newsData?.title
        cell.newsAuthor.text = newsData?.link
        
        if let convertedDate = DateConverter.convertDate(newsData?.isoDate ?? "") {
            cell.newsDate.text = convertedDate
            
        }
        
        cell.newsImage.kf.setImage(with: URL(string: newsData?.image ?? ""))
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let newsData = news?[indexPath.row] {
            pushDetail(newsData)
        }
        
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


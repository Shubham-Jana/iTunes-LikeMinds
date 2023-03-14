//
//  ViewController.swift
//  NewProjectTest
//
//  Created by iOS Wizard on 13/03/23.
//

import UIKit

class ViewController: UIViewController {
  
    // MARK: - PROPERTIES
  
  private let CELL_ID = String(describing: ViewController.self)
  private var vm = ViewModel()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  
    // MARK: - LIFECYCLE
  
  override func loadView() {
    super.loadView()
    view = tableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "iTunes"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    fetchData()
  }
  
    // MARK: - METHODS
 
  private func fetchData() {
    Task {
      await vm.getData()
      
      await MainActor.run {
        self.tableView.reloadData()
      }
    }
  }
  
}

  // MARK: - EXTENSIONS

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vm.model.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
    var configCell = cell.defaultContentConfiguration()
    let section = vm.model[indexPath.row]
    
    configCell.text = ("Artist name: \(section.artistName)")
    configCell.secondaryText = ("Price: $\(section.collectionPrice)")
    
    Task {
      if let url = section.artworkUrl60 {
        vm.imageData = try? await UIImage().imageData(url: url)
      }
    }
    
    configCell.image = UIImage(data: vm.imageData ?? Data())
    configCell.imageProperties.cornerRadius = 6
    cell.contentConfiguration = configCell
    return cell
  }
  
}




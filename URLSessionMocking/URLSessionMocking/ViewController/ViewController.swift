//
//  ViewController.swift
//  URLSessionMocking
//
//  Created by Harish on 04/07/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var bag: Set<AnyCancellable> = []
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var messageView: CustomMessageView!
    var viewModel = ViewModel()

    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        setupBindings()
        viewModel.loadNames()
    }

    func setupViews() {
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "NameCell", bundle: nil), forCellReuseIdentifier: "NameCell")
        loader.hidesWhenStopped = true
        
        // Custom View loaded from storyboard
        self.messageView.setMessage(message: "This view is loaded from storyboard")
        
        // Custom View loaded programatically
        let messageView2 = CustomMessageView(frame: CGRect(x: 0, y: 600, width: 300, height: 80))
        messageView2.setMessage(message: "This view is loaded programatically")
        self.view.addSubview(messageView2)
        
        //Serial Queues
        let serialQueue = DispatchQueue(label: "serial queue")
        let mainQueue = DispatchQueue.main
        // Concurrent Queues
        let concurrentGlobalQueue = DispatchQueue.global(qos: .userInitiated)
        let concurrentQueue = DispatchQueue(label: "concurrent queue", attributes: .concurrent)
        
    }
    
    func setupBindings() {
        viewModel.namesUpdateClosure = { [weak self] names in
            self?.table.reloadData()
        }
        
        viewModel.$dataLoading.receive(on: DispatchQueue.main).sink { [weak self] loading in
            if loading {
                self?.loader.startAnimating()
            } else {
                self?.loader.stopAnimating()
            }
            
        }
        .store(in: &bag)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as? NameCell else {
            return UITableViewCell()
        }
        cell.configureCell(name: viewModel.names[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


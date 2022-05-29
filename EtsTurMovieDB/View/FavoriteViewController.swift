//
//  FavoriteViewController.swift
//  EtsTurMovieDB


import UIKit

class FavoriteViewController: UIViewController {

    
    @IBOutlet var favTableView: UITableView!
    
    let viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Favorites"
        self.navigationController?.navigationBar.backgroundColor = .white
        
        registerTableViewCells()
        updateTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
    }
    
    private func registerTableViewCells() {
          let customCell = UINib(nibName: "MovieItemCell",
                                    bundle: nil)
          self.favTableView.register(customCell,
                                  forCellReuseIdentifier: "MovieItemCell")
      }
    
    private func updateTableView() {
        self.viewModel.fetchData()
        self.favTableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as? MovieItemCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.listArray[indexPath.row]
        cell.movieTitleLabel.text = cellVM.name
        cell.movieRateLabel.text = String(cellVM.vote_average)
        cell.moveImageView.image = urlConvertImage(url: cellVM.backdrop_path!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteData(index: indexPath.row)
            updateTableView()
        }
    }

}

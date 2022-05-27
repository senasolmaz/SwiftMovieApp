//
//  ViewController.swift
//  EtsTurMovieDB
//

import UIKit

class TvShowListController: UIViewController {

    @IBOutlet var showsTableView: UITableView!
    
    var dataViewModel = ShowsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableViewCells()
        initViewModel()
    }
    
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.showsTableView.reloadData()
            }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async {
//                self.view.stopLoading()
//                self.showAlert("Location Api Error")
            }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async {
//                self.view.showLoading()
            }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async {
//                self.view.stopLoading()
            }
        }
        dataViewModel.getTvSeriesData()
    }
    
    private func registerTableViewCells() {
          let customCell = UINib(nibName: "MovieItemCell",
                                    bundle: nil)
          self.showsTableView.register(customCell,
                                  forCellReuseIdentifier: "MovieItemCell")
      }


}

extension TvShowListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataViewModel.tvShowsModel != nil {
            return dataViewModel.tvShowsModel.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as? MovieItemCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = dataViewModel.tvShowsModel[indexPath.row]
        cell.movieTitleLabel.text = cellVM.name
        cell.movieRateLabel.text = String(cellVM.vote_average!)
        
        let url = URL(string: Constants.imagePath + cellVM.poster_path!)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.moveImageView.image = image
        }
        cell.selectionStyle = .none
        return cell
    }
}


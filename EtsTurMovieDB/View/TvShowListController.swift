//
//  ViewController.swift
//  EtsTurMovieDB
//

import UIKit

class TvShowListController: UIViewController {

    @IBOutlet var showsTableView: UITableView!
    
    var dataViewModel = ShowsViewModel()
    var modelDetail: TvShowItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TV Shows"
        self.navigationController?.navigationBar.backgroundColor = .white

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
                self.removeSpinner()
//                self.showAlert("Location Api Error")
            }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async {
                self.showSpinner(onView: self.view)
            }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async {
                self.removeSpinner()
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
        
       
        cell.moveImageView.image = urlConvertImage(url: cellVM.backdrop_path!)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.modelDetail = dataViewModel.tvShowsModel[indexPath.row]
        performSegue(withIdentifier: "detailFromMain", sender: modelDetail)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? TvShowsDetailViewController, let detailToSend = sender as? TvShowItem {
               vc.detailModel = detailToSend
           }

   }
}


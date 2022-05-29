//
//  SearchViewController.swift
//  EtsTurMovieDB
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchCollectionView: UICollectionView!
    @IBOutlet var searchTextfield: UITextField!
    
    let dataViewModel = SearchViewModel()
    var searchQuery: String? = ""
    var modelDetail: TvShowItem?
    
    @IBAction func clickButton(_ sender: Any) {
    
        if searchTextfield.text == "" {
            showAlert(alertText: "Uyarı!", alertMessage: "Lütfen dizi ismi giriniz")
            dataViewModel.tvShowsModel = []
        }else {
            self.searchQuery = searchTextfield.text
            initViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search"
        self.navigationController?.navigationBar.backgroundColor = .white
        registerTableViewCells()
        self.searchTextfield.becomeFirstResponder()

    }

    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async {
                self.removeSpinner()
                self.showAlert(alertText: "Hata", alertMessage: "Servis ile bağlantı kurulamadı!")
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
        dataViewModel.getTvSeriesData(query: searchQuery!)
    }
    
    private func registerTableViewCells() {
        
          let customCell = UINib(nibName: "SearchItemCell",
                                    bundle: nil)
          self.searchCollectionView.register(customCell,
                                             forCellWithReuseIdentifier: "SearchItemCell")
      }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dataViewModel.tvShowsModel != nil {
           return self.dataViewModel.tvShowsModel.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchItemCell", for: indexPath) as? SearchItemCell {
                    
               let data = dataViewModel.tvShowsModel[indexPath.row]
               
               cell.showsTitle.text = data.name
               cell.showsRate.text = String(data.vote_average!)
               
               let url = URL(string: Constants.imagePath + (data.poster_path ?? ""))
               let dataI = try? Data(contentsOf: url!)

               if let imageData = dataI {
                   let image = UIImage(data: imageData)
                   cell.searchImageView.image = image
               }
               return cell
               
           } else {
               return UICollectionViewCell()
           }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.modelDetail = dataViewModel.tvShowsModel[indexPath.row]
        performSegue(withIdentifier: "detailFromSearch", sender: modelDetail)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? TvShowsDetailViewController, let detailToSend = sender as? TvShowItem {
            vc.detailModel = detailToSend
        }
    }
    
    
}

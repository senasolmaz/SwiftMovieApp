//
//  SearchViewController.swift
//  EtsTurMovieDB
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchCollectionView: UICollectionView!
    @IBOutlet var searchTextfield: UITextField!
    
    var dataViewModel = SearchViewModel()
    var searchQuery: String? = ""
    
    
    @IBAction func clickButton(_ sender: Any) {
    
        if searchTextfield.text == "" {
            print("Lütfen bir şey giriniz..")
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
//        self.searchTextfield.delegate = self

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
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
    
    
    
}

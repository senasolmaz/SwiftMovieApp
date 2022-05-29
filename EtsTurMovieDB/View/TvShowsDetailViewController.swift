//
//  TvShowsDetailViewController.swift
//  EtsTurMovieDB
//

import UIKit

class TvShowsDetailViewController: UIViewController {

    @IBOutlet var showDescription: UILabel!
    @IBOutlet var showDate: UILabel!
    @IBOutlet var showLanguage: UILabel!
    @IBOutlet var showName: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    
    var detailModel: TvShowItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showName.text = detailModel?.name
        showDate.text = "Yayınlanma Tarihi: " + (detailModel?.first_air_date)!
        showLanguage.text = "Dil: " + (detailModel?.original_language)!
        showDescription.text = "Açıklama: \n" + (detailModel?.overview)!
        
        iconImageView.image = urlConvertImage(url: (detailModel?.poster_path)!)
        posterImageView.image = urlConvertImage(url: (detailModel?.backdrop_path)!)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemChromeMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.4
        blurView.frame = posterImageView.bounds;
       
        posterImageView.addSubview(blurView)
    }

}

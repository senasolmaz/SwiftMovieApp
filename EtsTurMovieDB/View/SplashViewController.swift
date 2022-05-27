//
//  SplashViewController.swift
//  EtsTurMovieDB
//
//

import UIKit

class SplashViewController: UIViewController {

    var splashTitle: String? = ""
    var window: UIWindow?
    
    @IBOutlet var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        if checkConnection() {
            fetchRemoteConfig()
        }else {
            showAlert()
        }
    }
    
    func fetchRemoteConfig() {
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
            guard error == nil else { return }
            print("Remote Config verisi geldi")
            remoteConfig.activate()
            displayNewValues()
        }}
    
    func displayNewValues() {
        let newLabelText = remoteConfig.configValue(forKey: "splashTitle").stringValue ?? "Mesaj Alınamadı"
        splashTitle = newLabelText
        self.titleLabel.text = splashTitle
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.performSegue(withIdentifier: "openMainPage", sender: self)
        }
    }
    
    func checkConnection() -> Bool
    {
        if Reachability.isConnectedToNetwork(){
           return true
        }else{
           return false
        }
    }
    
    func showAlert() {
        
        self.titleLabel.text = "İnternet bağlantınızı \n kontrol ediniz!"
        
        
//        let alert = UIAlertController(title: "Hata!", message: "İnternet bağlantınızı kontrol ediniz", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { (_) in
//             }))
//        self.present(alert, animated: true, completion: nil)
        
       
    }

}

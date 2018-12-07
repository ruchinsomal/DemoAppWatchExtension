//
//  ViewController.swift
//  NickelFoxDemo
//
//  Created by Ruchin Somal on 07/12/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblArticle: UITableView!
    var articleArr:[RSArticles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblArticle.tableFooterView = UIView(frame: CGRect.zero)
        getdata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Articles"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-----------------------------------------------------------
    // MARK: - UITableViewDelegate & UITableViewDataSource
    //-----------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.selectionStyle = .none
        cell.img.contentMode = .scaleAspectFit
        let image = articleArr[indexPath.row].urlToImage ?? ""
        if image != "" {
            let imageUrl = URL(string: image)
            cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        cell.lblTitle.text = articleArr[indexPath.row].title
        cell.lblSubTitle.text = articleArr[indexPath.row].author
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        openURL(urlString: articleArr[indexPath.row].url ?? "")
    }
    
    func openURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            showAlertView(title: "Erroe", message: "Something went wrong. We are Working on it.", ref: self)
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    //-----------------------------------------------------------
    // MARK: - get data from server
    //-----------------------------------------------------------
    
    func getdata()  {
        //let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
        MyLoader.showLoadingView()
        let params:[String: Any] = ["q":"bitcoin","from":"2018-11-07","sortBy":"publishedAt","apiKey":"42bec2a9d04d49bd90e07385d1e73b7f"]
        getRequest(kNews_url, params: params as [String : AnyObject]?,oauth: true, result: {
            (response: JSON?, error: NSError?, statuscode: Int) in
            MyLoader.hideLoadingView()
            guard error == nil else {
                DispatchQueue.main.async {
                    self.view.makeToast(error!.localizedDescription, duration: 2.0, position: CSToastPositionCenter)
                }
                return
            }
            if response!["status"].stringValue == "fail" {
                showAlertView(title: "Error", message: response!["reason"].stringValue, ref: self)
            } else {
                if statuscode == 200 {
                    guard let responseObj = response else {
                        showAlertView(title: "Error", message: "Something went wrong. We are Working on it.", ref: self)
                        return
                    }
                    let news = RSArticle.init(json: responseObj)
                    guard let articles = news.articles else {
                        showAlertView(title: "Error", message: "Something went wrong. We are Working on it.", ref: self)
                        return
                    }
                    self.articleArr = articles
                    self.tblArticle.reloadData()
                } else {
                    showAlertView(title: "Error", message: "Something went wrong. We are Working on it.", ref: self)
                }
            }
        })
    }
    
}


//
//  HomeViewController.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-06-18.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var pageView : UIPageControl!
      var currentIndex = 0
    @IBOutlet var collectionView : UICollectionView!
    var imageArray = [UIImage(named:"image1"), UIImage(named: "image2"),UIImage(named:"image3"), UIImage(named: "image4"),UIImage(named: "image5")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //for creating right buttons dynamically
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //This need to be replaced with the pod
        let rightBarBtn = BadgedButtonItem(with:  UIImage(named: "shopping-cart"))
        rightBarBtn.badgeTintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        rightBarBtn.tintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        
         let rightBarBtn2 = UIBarButtonItem(image: UIImage(named: "notifications-button"), style: .plain, target: self, action: #selector(HomeViewController.rightBarButtonClicked))
        
         rightBarBtn2.tintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        self.navigationItem.rightBarButtonItems = [rightBarBtn, rightBarBtn2]
        self.navigationItem.setHidesBackButton(true, animated:true);
        //for displaying placeholder tetx color for search bar
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder))
        {
        let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)]
        searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search for items", attributes: attributeDict)
        }
        searchBar.delegate = self
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchproduct")
        tableView.isHidden = true
        configurePageControl()
//        pageView.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
//        scrollView.isPagingEnabled = true
//        setupImages(imageArray as! [UIImage])
//        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 4, height:self.scrollView.frame.height)
//        //for automatic scrolling'
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
    
    @objc func rightBarButtonClicked(){
     
        }
    //it is used to show cancel button when we star text beignediting
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
        searchBar.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageView.currentPage = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchproduct", for: indexPath) as! SearchTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    //page control
    func configurePageControl() {
        self.pageView.numberOfPages = imageArray.count
        self.pageView.currentPage = 0
        self.pageView.tintColor = UIColor.red
        //self.pageView.backgroundColor = UIColor.lightGray
        self.pageView.pageIndicatorTintColor = UIColor.lightGray
        self.pageView.currentPageIndicatorTintColor =  UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        
    }
    @objc func moveToNextPage (){
        
        if currentIndex < imageArray.count{
            collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! PageImageCollectionViewCell
        cell.collectionImageView?.image = imageArray[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 230 )
    }
    
}

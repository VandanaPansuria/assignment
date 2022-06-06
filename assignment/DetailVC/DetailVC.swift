//
//  DetailVC.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    var viewModel = HomeVM()
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    let reuseIdentifier = "cell"
    var jsonPage = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
        self.itemsCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        let cellWidth : CGFloat = self.view.frame.size.width / 3.0
        let cellheight : CGFloat = cellWidth + 10
        let cellSize = CGSize(width: cellWidth, height:cellheight)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        itemsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        let _ = viewModel.readLocalFile(forName: jsonPage)
        setupNavigationItems()
        
    }
    
    //Navigation Item
    private func setupNavigationItems() {
        
        let title = UILabel()
        title.text = viewModel.pageTitle
        
        let spacer = UIView()
        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow
        
        let stack = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis = .horizontal
        
        navigationItem.titleView = stack
    }
    //Search Action
    @IBAction func btnSearch(_ sender: Any) {
        searchBarHeight.constant = searchBarHeight.constant == 0 ? 51 : 0
    }
    //Back Action
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate ,UICollectionViewDataSource
extension DetailVC :  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.filteredList.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        cell.setList(self.viewModel.filteredList.value[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (itemsCollectionView.frame.size.width - space) / 3.0 - 10
        return CGSize(width: size, height: size + 120 )
    }
}
//MARK:- searchbar delegate
extension DetailVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.clearSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchFor(searchText)
        self.itemsCollectionView.reloadData()
    }
}

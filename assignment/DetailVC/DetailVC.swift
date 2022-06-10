//
//  DetailVC.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    var viewModel = ContentListingVM()
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    let reuseIdentifier = "cell"
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
        self.itemsCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.itemsCollectionView.register(IndicatorCell.self, forCellWithReuseIdentifier: "indicator")
        let cellWidth : CGFloat = self.view.frame.size.width / 3.0
        let cellheight : CGFloat = cellWidth + 10
        let cellSize = CGSize(width: cellWidth, height:cellheight)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        itemsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        getNextPage(position: 1)
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
        //Scrolling to first cell
        self.itemsCollectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                          at: .top,
                                    animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    func getNextPage(position: Int){
        viewModel.readLocalFile(forName: "CONTENTLISTINGPAGE-PAGE\(position)", completion: { result in
            self.itemsCollectionView.reloadData()
        })
    }
}

// MARK: - UICollectionViewDelegate ,UICollectionViewDataSource
extension DetailVC :  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return page >= 4 ? self.viewModel.filteredList.value.count : self.viewModel.filteredList.value.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != self.viewModel.filteredList.value.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
            cell.setList(self.viewModel.filteredList.value[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indicator", for: indexPath) as! IndicatorCell
            cell.indicator.startAnimating()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (itemsCollectionView.frame.size.width - space) / 3.0 - 10
        return CGSize(width: size, height: size + 120 )
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.viewModel.filteredList.value.count  - 1){
            page = page + 1
            self.getNextPage(position: page)
        }
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

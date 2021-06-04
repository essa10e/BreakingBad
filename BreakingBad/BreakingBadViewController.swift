//
//  ViewController.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/3/21.
//

import UIKit

class BreakingBadViewController: UIViewController, UISearchResultsUpdating, CharacterDelgate {
    

    let searchDataSource = CharacterSearch()
    
    // Mark:- Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var breakingBadCollectionView: UICollectionView!
    
    // Mark:- ViewModel
    var characterViewModel: CharacterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beginLoading()
        
        breakingBadCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.characterViewModel = CharacterViewModel(delegate: self)
        
        searchDataSource.dataChanged = { [weak self] in
            self?.breakingBadCollectionView.reloadData()
        }
        
        searchDataSource.fetch("https://breakingbadapi.com/api/characters")
        breakingBadCollectionView.dataSource = searchDataSource
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a character"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchDataSource.filterText = searchController.searchBar.text
    }
    
    // Mark:- Delegate
    func reloadData() {
        DispatchQueue.main.async {
            self.breakingBadCollectionView.reloadData()
            self.stopLoading()
        }
    }
    
    // Mark:- Begin/Stop activity Indicator
    private func beginLoading() {
        breakingBadCollectionView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        breakingBadCollectionView.isHidden = false
        activityIndicator.stopAnimating()
    }
}

// Mark:- Flow layout delegate
extension BreakingBadViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

// Mark:- Data Source
extension BreakingBadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterViewModel?.numberOfItemsInSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        let characterItem = (characterViewModel?.getData(row: indexPath.row))!
        cell.setup(with: characterItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CharactersDetailVC") as? CharactersDetailViewController else {
                    fatalError("Unable to instantiate detail view controller.")
                }

        let item = characterViewModel?.characterItem(at: indexPath.row)
        vc.character = item
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

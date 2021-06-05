//
//  ViewController.swift
//  BreakingBad
//

import UIKit

final class BreakingBadViewController: UIViewController, UISearchResultsUpdating, CharacterDelgate {
    
    let searchDataSource = CharacterSearch()
    
    // Mark:- Outlets
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var breakingBadCollectionView: UICollectionView!
    
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
        
        setupSearchBar()
    }
    
    
    /// This function set up the search bar
    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a character"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        search.dismiss(animated: true) {
            self.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        /// This boolean variable to test if the searchBox text is a number in order to convert it to an int.
        var isNumberValue: Bool?
        
        for i in 1...5 {
            if ((searchController.searchBar.text?.contains("\(i)") == true)) {
                isNumberValue = true
                break;
            }
        }
        
        if let _ = isNumberValue {
            searchDataSource.filterAppearance = (searchController.searchBar.text! as NSString).integerValue
        } else {
            searchDataSource.filterText = searchController.searchBar.text
        }
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

        let character = characterViewModel!.characterItem(at: indexPath.row)
 
        guard let characterDetailViewController = storyboard?.instantiateViewController(identifier: "CharactersDetailVC", creator: { coder in
            return CharactersDetailViewController(coder: coder, character: character)
        }) else {
            return
        }
        
        self.navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
}

/**
 option command /  ... to docummenting /// 
 */

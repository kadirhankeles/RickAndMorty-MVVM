//
//  ViewController.swift
//  MVVMDeneme
//
//  Created by Kadirhan Keles on 31.07.2023.
//

import UIKit
import SDWebImage

protocol HomeViewInterface: AnyObject {
    func prepareCollectionView()
    func updateCollectionView()
    func didFetchDatas()

}


class HomeViewController: UIViewController {
    
    
    @IBOutlet private weak var collectionView: UICollectionView!

    private var viewModel: HomeViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.delegate = self
        viewModel.fethAllDatas()
        prepareCollectionView()
    }
    


}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.nameLabel.text = viewModel.characterList[indexPath.item].name
        cell.characterImage.sd_setImage(with: URL(string:viewModel.characterList[indexPath.item].image!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width / 2
        let height: CGFloat = width * 1.3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characterList[indexPath.item]
            
        let detailVC = DetailViewController(character: selectedCharacter)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension HomeViewController: HomeViewInterface {

    
    func didFetchDatas() {
        updateCollectionView()
    }

    func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()

        }
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: Bundle(for: HomeCollectionViewCell.self))
        collectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    
}

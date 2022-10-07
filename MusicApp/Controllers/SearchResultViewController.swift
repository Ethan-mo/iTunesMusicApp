//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by 모상현 on 2022/10/07.
//

import UIKit

class SearchResultViewController: UIViewController {

    // 컬렉션뷰(테이블뷰와 유사)
    @IBOutlet weak var collectionView: UICollectionView!
    
    let flowLayout = UICollectionViewFlowLayout()
    
    let networkManage = NetworkManager.shared
    
    var musicArrays: [Music] = []
    
    var searchTerm: String? {
        didSet{
            데이터설정()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        컬렉션뷰설정()
    }
    
    func 컬렉션뷰설정(){
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        flowLayout.scrollDirection = .vertical
        
        // 아이템의 가로, 세로값을 계산하는 공식
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWidth * (CVCell.cellCoulumns - 1)) / CVCell.cellCoulumns
        
        // 아이템 Size 설정
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWidth
        
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWidth
        
        // 컬렉션뷰의 속성에 할당
        collectionView.collectionViewLayout = flowLayout
    }

    func 데이터설정(){
        guard let term = searchTerm else { return }
        print("네트워킹 시작 단어 \(term)")
        
        self.musicArrays = []
        
        networkManage.fetchMusic(searchTerm: term) { result in
            switch result{
            case .success(let musicDatas):
                self.musicArrays = musicDatas
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! MusicCollectionViewCell
        cell.imageUrl = musicArrays[indexPath.row].imageUrl
        return cell
    }
}

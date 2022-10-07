//
//  ViewController.swift
//  MusicApp
//
//  Created by 모상현 on 2022/10/05.
//

import UIKit

final class ViewController: UIViewController {

    ///MARK: - 검색 후 결과를 보여주는 ViewController의 인스턴스를 만들어 searchController라는 이름의 변수에 저장한다.
    let searchController = UISearchController(searchResultsController: UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    // 네트워크 매니저
    var networkManager = NetworkManager.shared
    
    // 음악 데이터를 다루기위한 배열
    var musicArrays: [Music] = []
    
    @IBOutlet weak var musicTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        서치바셋팅()
        테이블뷰세팅()
        데이터세팅()
    }
    
    func 서치바셋팅(){
        /// 서치바를 생성한다.
        // 서치바의 이름 생성
        self.title = "Music Search"
        // 서치바를 네비게이션 아이템에 속하도록 설정한다. 해당 서치바는, searchController와 연동이 되어있다.
        navigationItem.searchController = searchController
        // searchController의 결과에 대한 업데이트와 관련하여, Delegate를 설정하였는데, 현재 viewController가 해당 작업을 대신 위임하여 수행한다.
        searchController.searchResultsUpdater = self
        // 검색바에서 첫 글자 검색 시, 대문자로 검색되는 기능을 꺼둔다.
        searchController.searchBar.autocapitalizationType = .none
    }
    func 테이블뷰세팅(){
        // musicTableView와 관련된 delegate, dataSource에 대한 위임자를 해당 viewController가 대신 수행한다.
        musicTableView.delegate = self
        musicTableView.dataSource = self
        // musicTableCell에서 Cell은 Nib파일을 사용하기위해 아래와같은 [Nib파일 등록]절차를 거친다.
        musicTableView.register(UINib(nibName:Cell.musicCellIdentifier, bundle: nil),forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
    func 데이터세팅(){
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            print(#function)
            switch result{
            case .success(let musicDatas):
                self.musicArrays = musicDatas
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return musicArrays.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MyMusicCell
        
        
        
        cell.imageUrl = musicArrays[indexPath.row].imageUrl
        
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
        cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
        
        cell.selectionStyle = .none
        return cell
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        let vc = searchController.searchResultsController as! SearchResultViewController
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}


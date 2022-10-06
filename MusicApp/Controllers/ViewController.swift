//
//  ViewController.swift
//  MusicApp
//
//  Created by 모상현 on 2022/10/05.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var musicTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }
    func setting(){
        musicTableView.dataSource = self
        musicTableView.delegate = self
    }


}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MyMusicCell
        
        cell.imageUrl = musicArrays[indexPath.row].imageUrl
    }
}
extension ViewController:UITableViewDelegate{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        <#code#>
    }
}

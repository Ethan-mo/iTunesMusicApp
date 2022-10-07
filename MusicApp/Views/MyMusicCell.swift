//
//  MyMusicCell.swift
//  MusicApp
//
//  Created by 모상현 on 2022/10/05.
//

import UIKit

class MyMusicCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var imageUrl: String?{
        didSet{
            loadImage()
        }
    }
    
    /// 셀을 초기화 해주는 코드이다. 이를 통해서, 기존 다른
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mainImageView.image = nil
    }
    
    
    /// 스토리보드 또는 Nib으로 만들 때, 사용하게 되는 생성자 코드
    override func awakeFromNib() {
        super.awakeFromNib()
        // 컨텐츠모드를 .scaleToFiil,
        mainImageView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func loadImage(){
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            /// Data() 이 메서드는 주어진 URL로부터 데이터를 데이터 객체로 초기화하는 작업을 수행하는 메서드이다.
            // Data(contentsOf:) 메서드는 잘 사용되지 않는다.
            // 그 이유는 동기적으로 작동하기 떄문에 해당 메서드는 오랜 시간이 걸릴수도 있고,
            // 앱을 강제로 종료시킬 수도 있기 때문이다. 그래서 이번에 사용시 .gloval()을 통해 비동기적으로 수행하게끔하였다.
            // 공식 문서에서는 Data(contentsOf:)메서드는 네트워킹 상황에서는 사용하지말고, 네트워킹 상황시에는 dataTask 사용을 추천한다.
            guard let data = try? Data(contentsOf: url) else { return }
            
            /// .absoluteString은 타입이 URL로 변한 String값을 다시 String형태로 바꿔주는 역할을 수행한다.
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    
}

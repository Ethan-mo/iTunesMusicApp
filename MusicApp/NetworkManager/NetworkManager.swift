//
//  NetworkManager.swift
//  MusicApp
//
//  Created by 모상현 on 2022/10/05.
//

import Foundation

/// MARK: - 네트워크에서 발생할 수 있는 에러
enum NetworkError: Error{
    case networkingError
    case dataError
    case parseError
}
/// MARK: - Networking (서버와 통신하는) 클래스 모델
final class NetworkManager{
    
    static let shared = NetworkManager()
    private init() {}
    
    // 클로저로 표현될 부분을 한 눈에 이해할 수 있도록 변경한다.
    typealias NetworkCompletion = (Result<[Music],NetworkError>) -> Void
    
    /// MARK: - 요청할 Url을 만드는 메서드
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion){
        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        print(urlString)
    }
    
    ///MARK: - 실질적으로 서버에 요청하는 메서드
    private func performReques(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            // Networking작업 중 발생하는 대부분의 이유를 알 수 없는 에러발생 시, networkingError를 출력한다.
            if error != nil{
                print(error!)
                completion(.failure(.networkingError))
            }
            // Networking작업 중, Data와 관련하여 발생하는 에러는, dataError를 출력한다.
            guard let safeData = data else{
                completion(.failure(.dataError))
            }
            if let musics = self.parseJSON(safeData){
                print("불러온 Data를 분석하는 메서드를 실행하였습니다.")
                completion(.success(musics))
            }else {
                print("불러온 Data를 분석하는 메서드가 실행에 실패하였습니다.")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    ///MARK: - 불러온 Data를 분석하는 메서드
    private func parseJSON(_ musicData: Data) -> [Music]? {
        do{
            // JSON형식으로, 이미 구현해놓은 MusicData의 포맷에 맞게 변환이 되면, [Music]형태의 Value를 return한다.
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
        }catch{
            // Data를 분석하는 도중에 오류가 발생하면 nil을 출력
            print(error.localizedDescription)
            return nil
        }
    }
    
}


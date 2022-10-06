//
//  Constants.swift
//  MusicApp
//
//  Created by 모상현 on 2022/10/05.
//

import UIKit

public enum MusicApi{
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music"
}

public struct Cell {
    static let musicCellIdentifier = "MyMusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {}
}

public struct CVCell{
    static let spacingWidth: CGFloat = 1
    static let cellCoulumns: CGFloat = 3
    private init() {}
}

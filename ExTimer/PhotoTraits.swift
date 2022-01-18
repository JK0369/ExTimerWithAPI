//
//  PhotoTraits.swift
//  ExTimer
//
//  Created by 김종권 on 2022/01/15.
//

import RxSwift
import RxCocoa

// MARK: Service
protocol PhotoServiceType {
  static func getPhotoEveryFiveSeconds() -> Observable<Photo?>
}

private enum PhotoService: PhotoServiceType {
  private enum Time {
    static let periodSeconds = 5
  }
  
  static func getPhotoEveryFiveSeconds() -> Observable<Photo?> {
    Observable<Int>
      .timer(.seconds(1), period: .seconds(5), scheduler: MainScheduler.asyncInstance)
      .map { _ in self.getPhoto() }
      .distinctUntilChanged()
  }
  private static func getPhoto() -> Photo? {
    let photo1 = Photo(name: "img1")
    let photo2 = Photo(name: "img2")
    let photo3 = Photo(name: "img3")
    let photos = [photo1] + [photo2] + [photo3]
    let randomPhoto = photos.randomElement()
    return randomPhoto
  }
}

// MARK: Traits
protocol PhotoTraits {
  static var photoService: PhotoServiceType.Type { get }
}

extension PhotoTraits {
  static var photoService: PhotoServiceType.Type { PhotoService.self }
}

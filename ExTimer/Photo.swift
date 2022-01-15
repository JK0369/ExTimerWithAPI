//
//  Photo.swift
//  ExTimer
//
//  Created by 김종권 on 2022/01/15.
//

import UIKit

struct Photo {
  var name: String
  var image: UIImage? {
    UIImage(named: self.name)
  }
}

extension Photo: Hashable {
  static func == (lhs: Photo, rhs: Photo) -> Bool {
    lhs.name == rhs.name
  }
}

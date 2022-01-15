//
//  ViewController.swift
//  ExTimer
//
//  Created by 김종권 on 2022/01/15.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class ViewController: UIViewController, PhotoTraits {
  // MARK: UI
  private let photoImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  private let button = UIButton().then {
    $0.setTitle("dispose button", for: .normal)
    $0.setTitleColor(.systemBlue, for: .normal)
    $0.setTitleColor(.blue, for: .highlighted)
  }
  
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(self.photoImageView)
    self.view.addSubview(self.button)
    
    self.photoImageView.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(16)
      $0.top.bottom.equalToSuperview().inset(300)
    }
    self.button.snp.makeConstraints {
      $0.top.equalToSuperview().inset(56)
      $0.centerX.equalToSuperview()
    }
    
    self.button.rx.tap
      .bind { self.disposeBag = DisposeBag() }
      .disposed(by: self.disposeBag)
    
    Self.photoService.getPhotoEveryFiveSeconds()
      .bind { [weak self] in self?.photoImageView.image = $0?.image }
      .disposed(by: self.disposeBag)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.disposeBag = DisposeBag()
  }
}

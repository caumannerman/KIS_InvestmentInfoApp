//
//  SettingsViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

//import UIKit

//class SettingsViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemBackground
//    }
//
//
//}

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private let apitableView = ApiListTableView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        setupNavigationItems()
        setupLayout()
    }
    
    func setupNavigationItems(){
        navigationItem.title = "API Key 관리"
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func didTapRightBarButtonItem(){
        let actionSheet = UIAlertController(title: "정말요?", message: "탈퇴를 실행하시게요?", preferredStyle: .actionSheet)
        [
            UIAlertAction(title: "회원 정보 변경", style: .default),
            UIAlertAction(title: "탈퇴하기", style: .destructive),
            UIAlertAction(title: "닫기", style: .cancel)
        ].forEach{ actionSheet.addAction($0) }
        
        present(actionSheet, animated: true)
    }
    
    func setupLayout(){
        
        [apitableView].forEach {view.addSubview($0)}
        
        let inset: CGFloat = 8.0
        apitableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
       
    }
    
    
    
}


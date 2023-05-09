//
//  SettingsViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private let apitableView = ApiListTableView()
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("SettingsView의 Init 시점 테스트")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ApiListTableViewCell에서 즐찾 변경신호 받는 Observer
        NotificationCenter.default.addObserver(self, selector: #selector(DidChangeUrlStarInSettings(_:)), name: .DidChangeUrlStarInSettings, object: nil)
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        setupNavigationItems()
        setupLayout()
        print("SettingsView의 viewDidLoad 시점 테스트")
    }
    
    @objc func DidChangeUrlStarInSettings(_ notification: Notification){
        print("SettingsViewCon reload됨")
        apitableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Home 화면에서 받아오고,업데이트한 UserDefaults저장정보들을 그대로 가져옴
   
        //여기서 urls 변경정보를 업데이트 해줘야함 ( 다른 화면에서 수정한 정보 반영을 위해 reload )
        print("relaod")
        apitableView.reloadData()
        print("reload success")
        
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

//
//  UrlSearchTextFieldView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/03.
//

import UIKit
import SnapKit

// Url검색을 위해 커스텀 검색창 생성
class UrlSearchTextFieldView: UIView {
    
    private let ucoms: UrlCommonState = UrlCommonState.getInstance()
    let urlSearchTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
        NotificationCenter.default.addObserver(self, selector: #selector(market_url_changed(_:)), name: .market_url_changed, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func market_url_changed(_ notification: Notification){
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_idx = now_dict["marketOrUrl"] as? Int else { return }
       
        //시장정보를 클릭한 경우
        if now_idx == 0 {
            urlSearchTextField.text?.removeAll()
            urlSearchTextField.sendActions(for: .editingChanged)
            urlSearchTextField.endEditing(true)
        }
        
    }
    
    private func attribute(){
        urlSearchTextField.backgroundColor = UIColor(red: 210/255, green: 230/255, blue: 255/255, alpha: 0.4)
        urlSearchTextField.layer.borderColor = UIColor.lightGray.cgColor
        urlSearchTextField.layer.borderWidth = 2.0
        urlSearchTextField.layer.cornerRadius = 10.0
        urlSearchTextField.font = .systemFont(ofSize: 36.0, weight: .regular)
        urlSearchTextField.textColor = .darkGray
        urlSearchTextField.autocapitalizationType = .none
        urlSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
       
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: urlSearchTextField.frame.height))
        urlSearchTextField.leftView = paddingView
        urlSearchTextField.leftViewMode = .always
        
        let clearButton = UIButton()
        clearButton.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
        
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 62, height: urlSearchTextField.frame.height))
        paddingView2.addSubview(clearButton)
        
        clearButton.snp.makeConstraints{
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }

        urlSearchTextField.rightView = paddingView2
        urlSearchTextField.rightViewMode = .whileEditing
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        urlSearchTextField.rightViewMode = .whileEditing
        print(textField.text)
        ucoms.setFirstUrlWhileSearching(searchUrl: textField.text ?? "")
        NotificationCenter.default.post(name:.sendUrlSearchText, object: .none)
        
    }
    
    @objc func didTapClearButton(){
        print("didTapClearButton")
        urlSearchTextField.text?.removeAll()
        urlSearchTextField.sendActions(for: .editingChanged)
        urlSearchTextField.rightViewMode = .never
        urlSearchTextField.endEditing(true)
        
    }
    
    private func layout(){
        [urlSearchTextField].forEach{
            addSubview($0)
        }
        
        urlSearchTextField.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    
}

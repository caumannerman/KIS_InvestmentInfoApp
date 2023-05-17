//
//  ItemSelectionViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/17.
//

import UIKit
import SnapKit

class ItemSelectionViewController: UIViewController {
    
    private let textField: UITextField = UITextField()
    private let tableView: UITableView = UITableView()
   
    private var itemsArr: [String] = ["item", "item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10", "item11", "item12", "item13", "item14", "item15", "item16"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint("ItemSelectionViewController viewDidLoad")
        view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.0)
    }
    
    func attribute(){
        self.view.backgroundColor = .systemBackground
        
        textField.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0).cgColor
        textField.layer.cornerRadius = 12.0
        textField.placeholder = "추가하고싶은 item 혹은 item 설명 키워드"
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        
    }
    
    @objc func backTo(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func layout(){
        
        [textField, tableView].forEach{
            view.addSubview($0)
        }
        
        textField.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
       

    }
}


extension ItemSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("item selected")
    }
}

extension ItemSelectionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    
        cell.textLabel?.text = itemsArr[indexPath.row]
        cell.detailTextLabel?.text = "item 상세"
        return cell
    }
}

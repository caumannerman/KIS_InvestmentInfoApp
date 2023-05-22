//
//  ItemSelectionViewController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/05/17.
//

import UIKit
import SnapKit
import Alamofire

enum ShowMode {
    case all
    case keyword
}


class ItemSelectionViewController: UIViewController {

    private var showMode: ShowMode = .all
    private let textField: UITextField = UITextField()
    private let sectionCV: UICollectionView = ItemSectionCollectionView(frame: .zero, collectionViewLayout: ItemSectionCollectionViewLayout())
    private let subSectionCV = ItemSubSectionCollectionView(frame: .zero, collectionViewLayout: ItemSubSectionCollectionViewLayout())
    private let tableView: UITableView = UITableView()
    
    private let itemsUrl: [String] = [
    "https://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json", "https://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getStockMarketIndex?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json", "https://apis.data.go.kr/1160100/service/GetGeneralProductInfoService/getOilPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json",
    "https://apis.data.go.kr/1160100/service/GetSecuritiesProductInfoService/getETFPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json",
    "https://apis.data.go.kr/1160100/service/GetBondSecuritiesInfoService/getBondPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json",
    "https://apis.data.go.kr/1160100/service/GetDerivativeProductInfoService/getStockFuturesPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json"
    ]
   
    private var itemsArr: [(String, String)] = [("item","detail"),("item1","detail1"), ("item2","detail2"), ("item3","detail3"), ("item4","detail4"), ("item5","detail5"), ("item6","detail6"), ("item7","detail7"), ("item8","detail8"), ("item9","detail9"), ("item10","detail10"), ("item11","detail11"), ("item12","detail12"), ("item13","detail13"), ("item14","detail14"), ("item15", "detail15"), ("item16","detail16")]
    
    private var itemsArrToShow: [(String, String)] = []
    
    
    private lazy var clearButton: UIView = {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
     
        return  button
    }()
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(didTapItemSectionCell(_:)), name: .DidTapItemSectionCell, object: nil)
    }
    
    @objc func didTapItemSectionCell(_ notification: Notification){
        print("Notification DidTapItemSectionCell Received at VC")
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_idx = now_dict["idx"] as? Int else {return}
        
//        self.view.addSubview(subSectionCV)

        subSectionCV.snp.updateConstraints{
            $0.top.equalTo(sectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        requestAPI(url: itemsUrl[now_idx])
       
        print(now_idx)
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
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 62, height: textField.frame.height))
        paddingView2.addSubview(clearButton)
        
        clearButton.snp.makeConstraints{
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }

        textField.rightView = paddingView2
        textField.rightViewMode = .whileEditing
        //첫 글자를 대문자로 하지 않기 위해서
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.rightViewRect(forBounds: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("keyboard end")
        self.view.endEditing(true)
    }
    
    @objc func didTapClearButton(){
        print("didTapClearButton")
        self.textField.text?.removeAll()
        self.textField.rightViewMode = .never
        self.showMode = .all
        tableView.reloadData()
    }
    
    
//    @objc func backTo(){
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
//    }
    @objc func textFieldDidChange(_ textField: UITextField){
        print(textField.text)
        let now_text: String = textField.text ?? ""
        if textField.text == nil || textField.text == "" {
            self.textField.rightViewMode = .never
            self.showMode = .all
        }else {
            self.textField.rightViewMode = .whileEditing
            self.showMode = .keyword
            filterByKeyword(keyword: now_text)
        }
        tableView.reloadData()

    }
    
    // 어떤 String을 매개변수로 전달받았을 때, 해당 String이 item이름 혹은 item 설명에 포함되어있는지 체크하고 해당하는 것들만 추려준다.
    func filterByKeyword(keyword: String){
        itemsArrToShow = itemsArr.filter{
            if $0.0.contains(keyword) || $0.1.contains(keyword) {
               return true
            }
            return false
        }
    }
    
    func layout(){
        
        [textField, sectionCV, subSectionCV, tableView].forEach{
            view.addSubview($0)
        }
        
        textField.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        sectionCV.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        subSectionCV.snp.makeConstraints{
            $0.top.equalTo(sectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(subSectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension ItemSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.showMode {
        case .all:
            print( itemsArr[indexPath.row] )
            NotificationCenter.default.post(name:.AddNewItemOnMarketCV, object: .none, userInfo: ["item": itemsArr[indexPath.row].0])
            self.dismiss(animated: true)
        case .keyword:
            print(itemsArrToShow[indexPath.row])
            NotificationCenter.default.post(name:.AddNewItemOnMarketCV, object: .none, userInfo: ["item": itemsArrToShow[indexPath.row].0])
            self.dismiss(animated: true)
        }
    }
}

extension ItemSelectionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.showMode {
        case .all:
            return itemsArr.count
        case .keyword:
            return itemsArrToShow.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        switch self.showMode {
            
        case .all:
            cell.textLabel?.text = itemsArr[indexPath.row].0
            cell.detailTextLabel?.text = itemsArr[indexPath.row].1
        case .keyword:
            cell.textLabel?.text = itemsArrToShow[indexPath.row].0
            cell.detailTextLabel?.text = itemsArrToShow[indexPath.row].1
        }
        cell.selectionStyle = .none
        return cell
    }
}


extension ItemSelectionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = "추가하고싶은 item 혹은 item 설명 키워드"
    }

}


extension ItemSelectionViewController{
    private func requestAPI(url: String){
        
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: IS_StockPriceInfo.self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                print("실패 아니면 여기 나와야함!!!")
                
                let now_arr = data.response.body.items.item
                //데이터 받아옴
                self.itemsArr = now_arr.map{ now_item -> (String, String) in
                    let temp = ( now_item.basDt ?? "내용없음", now_item.itmsNm ?? "내용없음")
                    return temp
                }
                //테이블 뷰 다시 그려줌
                self.showMode = .all
                self.tableView.reloadData()
            }
            .resume()
    }
}


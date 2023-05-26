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
    
    private var selected_section_idx: Int = -1
    private var selected_subSection_idx: Int = -1

    private var showMode: ShowMode = .all
   
    private let sectionCV: UICollectionView = ItemSectionCollectionView(frame: .zero, collectionViewLayout: ItemSectionCollectionViewLayout())
    private let subSectionCV = ItemSubSectionCollectionView(frame: .zero, collectionViewLayout: ItemSubSectionCollectionViewLayout())
    private let textField: UITextField = UITextField()
    private let tableView: UITableView = UITableView()
    
    private let itemsUrl: [String] = [
    "https://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json", "https://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getStockMarketIndex?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json", "https://apis.data.go.kr/1160100/service/GetGeneralProductInfoService/getOilPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json",
    "https://apis.data.go.kr/1160100/service/GetSecuritiesProductInfoService/getETFPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json",
    "https://apis.data.go.kr/1160100/service/GetBondSecuritiesInfoService/getBondPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json",
    "https://apis.data.go.kr/1160100/service/GetDerivativeProductInfoService/getStockFuturesPriceInfo?serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D&resultType=json"
    ]
   
    private var itemsArr: [(String, String)] = [("섹션을 선택해주세요","섹션 선택 후 검색이 가능합니다")]
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(didTapItemSubSectionCell(_:)), name: .DidTapItemSubSectionCell, object: nil)
        
    }
    
    //section을 선택했을 경우
    @objc func didTapItemSectionCell(_ notification: Notification){
        print("Notification DidTapItemSectionCell Received at VC")
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_idx = now_dict["idx"] as? Int else {return}
        print(now_idx, "now_idx임")

        //이를 저장해두는 이유는, subSection까지 선택했을 때 두 정보를 이용하여 url을 특정하고,
        // 그 응답으로 받은 내용들을 tableView에 뿌려야하기 때문.
        self.selected_section_idx = now_idx
        self.selected_subSection_idx = 0
        
        // 선택된 섹션에 맞는 subSection 목록으로 바꾸는 과정
        subSectionCV.setup(idx: now_idx)
        subSectionCV.reloadData()
        
        itemsArr.removeAll()
        tableView.reloadData()
        textField.isHidden = true
        textField.snp.updateConstraints{
            $0.top.equalTo(subSectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        subSectionCV.snp.updateConstraints{
            $0.top.equalTo(sectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
    
    //subSection을 선택했을 경우
    @objc func didTapItemSubSectionCell(_ notification: Notification){
        print("Notification didTapItem'Sub'SectionCell Received at VC")
        guard let now_dict = notification.userInfo as? Dictionary<String, Any> else { return }
        guard let now_idx = now_dict["idx"] as? Int else {return}

        //이를 저장해두는 이유는, subSection까지 선택했을 때 두 정보를 이용하여 url을 특정하고,
        // 그 응답으로 받은 내용들을 tableView에 뿌려야하기 때문.
        self.selected_subSection_idx = now_idx

        print(selected_section_idx, selected_subSection_idx)
        //여기서 위의 두 idx를 이용하여 알맞은 url을 호출하고, 받은 응답을 tableVIew에 업데이트해주어야함
        let now_url: String = MarketInfoData.getMarketSubSectionsUrl(row: selected_section_idx, col: selected_subSection_idx)
        
        requestAPI(url: now_url)
        textField.isHidden = false
        textField.snp.updateConstraints{
            $0.top.equalTo(subSectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    
    
    func attribute(){
        self.view.backgroundColor = .systemBackground
        
        textField.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1.0)
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
        textField.layer.cornerRadius = 2.0
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
        subSectionCV.snp.updateConstraints{
            $0.top.equalTo(sectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
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
        
        [ sectionCV, subSectionCV, textField, tableView].forEach{
            view.addSubview($0)
        }
        
        sectionCV.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        subSectionCV.snp.makeConstraints{
            $0.top.equalTo(sectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        textField.snp.makeConstraints{
            $0.top.equalTo(subSectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
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
        switch self.showMode {
        case .all:
            print( itemsArr[indexPath.row] )
            HomeContentsData.addNewItem(item: (itemsArr[indexPath.row].0, itemsArr[indexPath.row].1))
            NotificationCenter.default.post(name:.AddNewItemOnMarketCV, object: .none)
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
        subSectionCV.snp.updateConstraints{
            $0.top.equalTo(sectionCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
    }

}


extension ItemSelectionViewController{
    private func requestAPI(url: String){ //
        
//        let url = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo" + "?numOfRows=30&resultType=json&serviceKey=qN5jfsV7vfaF2TeYh%2FOLDD09pgcK88uLTsJ3puwH509%2F4MATwRtVgcW6NkKfgfSyWoFvKmlywh8e8vVssBcfKA%3D%3D" + "&basDt=20230525"
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"])))
        print("encode된 url string : ", encoded)
        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
        AF.request(encoded ?? "")
            .responseDecodable(of: IS_StockPriceInfo.self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                guard
                    let self = self,
                    case .success(let data) = response.result else {
                    print("실패ㅜㅜ")
                    return }
                print("실패 아니면 여기 나와야함!!!")
                
                let now_arr = data.response.body.items.item
                //데이터 받아옴
                self.itemsArr = now_arr.map{ now_item -> (String, String) in
                    //여기서 각 변수들이 nil, 혹은 nil이 아닌 값일 수 있는데,
                    // nil이 아닌 것들만 가지고 title을 정하고 , 나머지를 이어붙여 subtitle을 만든다
                    let title: String = ((now_item.oilCtg != nil ? now_item.oilCtg : now_item.idxNm) != nil ? now_item.idxNm : now_item.itmsNm) ?? "제목없음"
                    
                    
                    var subtitle: String = ""
                    [(now_item.idxCsf, ""), (now_item.prdCtg, "상품분류 : "), (now_item.mrktCtg, ""), (now_item.epyItmsCnt, "채용종목수 : "), (now_item.ytm, "만기수익률 : "), (now_item.cnvt, "채권지수 볼록성 : "), (now_item.trqu, "체결수량 총합 : "), (now_item.trPrc, "거래대금 총합 : "), (now_item.bssIdxIdxNm, "기초지수 명칭 : "), (now_item.udasAstNm, "기초자산 명칭 : "),  (now_item.strnCd, "코드 : "), (now_item.isinCd, "국제 식별번호 : ")].forEach {
                        if $0.0 != nil {
                            subtitle += $0.1 + $0.0! + " / "
                        }
                    }
                    subtitle.removeLast()
                    subtitle.removeLast()
                    subtitle.removeLast()
                    
                    return ( title, subtitle )
                }
                //테이블 뷰 다시 그려줌
                self.showMode = .all
                self.tableView.reloadData()
            }
            .resume()
    }
}


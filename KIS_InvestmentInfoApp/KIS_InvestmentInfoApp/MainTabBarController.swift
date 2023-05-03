//
//  MainTabBarController.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/02.
//

import Foundation
import UIKit


class MainTabBarController: UITabBarController{

    //TabBar 가운데 동그란 버튼
    let centerButton = UIButton()
    
    private lazy var firstViewController: UIViewController = {
//        let vc = UrlSearchViewController()
//        let vc = UIHostingController(rootView: MarketInfoView())
        let vc = HomeViewController()
        let tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var secondViewController: UIViewController = {
        let vc = ChartViewController()
        let tabBarItem = UITabBarItem(title: "charts", image: UIImage(systemName: "chart.bar.xaxis"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var blankViewController: UIViewController = {
        let vc = UIViewController()
        return vc
    }()
    
    private lazy var thirdViewController: UIViewController = {
        let vc = MyFilesViewController()
        let tabBarItem = UITabBarItem(title: "내파일", image: UIImage(systemName: "folder.fill"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    private lazy var fourthViewController: UIViewController = {
        let vc = SettingsViewController()
        let tabBarItem = UITabBarItem(title: "settings", image: UIImage(systemName: "gearshape.fill"), tag: 0)
        
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMiddleButton()
        self.tabBar.tintColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0)
        
        let nav0 = UINavigationController(rootViewController: firstViewController)
        let nav1 = UINavigationController(rootViewController: secondViewController)
        let nav3 = UINavigationController(rootViewController: thirdViewController)
        let nav4 = UINavigationController(rootViewController: fourthViewController)
        
        setViewControllers([nav0, nav1, blankViewController, nav3, nav4], animated: true)
        //가운데는 클릭 안되게
        self.tabBar.items?[2].isEnabled = false
    }
    
    func setupMiddleButton(){
        
        centerButton.layer.cornerRadius = 35.0
        centerButton.clipsToBounds = true
        centerButton.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        centerButton.tintColor = .orange
        centerButton.setImage(UIImage(systemName: "plus"), for: UIControl.State.normal)
        centerButton.contentMode = .scaleAspectFill
//        centerButton.addTarget(self, action: #selector(MainTabBarController.menuButtonAction(sender:)), for: UIControl.Event.touchUpInside)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(centerButton)
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            centerButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
            centerButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            centerButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
            centerButton.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
            
        }
        else {
//            NSLayoutConstraint(item: centerButton.heightAnchor.constraint(equalToConstant: 56.5).isActive = true, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, multiplier: : 1.0, constant: 0).isActive = true
//
//            NSLayoutConstraint(item: centerButton.heightAnchor.constraint(equalToConstant: 56.5).isActive = true, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: : 1.0, constant: 0).isActive = true
        }
        self.view.layoutIfNeeded()
    }
//    @objc func menuButtonAction(sender: UIButton) {
//        //self.selectedIndex = 2
//        //sender.isHidden = true
//        print("center Button clicked")
//        let vc = NewPost2ViewController(pcData: nil)
//        vc.postEditMode = .new
//        print("llll")
//        if let now_navi = self.navigationController {
//            print("llll")
//            now_navi.present(vc, animated: true, completion: {print("새글!")})
//        }
//        else {
//            print("null이다")
//
//        }
//       // self.navigationController?.pushViewController(vc, animated: true)
//    }
}

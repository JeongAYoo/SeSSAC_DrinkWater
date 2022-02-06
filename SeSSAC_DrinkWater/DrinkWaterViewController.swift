//
//  DrinkWaterViewController.swift
//  SeSSAC_DrinkWater
//
//  Created by Jade Yoo on 2021/10/09.
//

import UIKit

class DrinkWaterViewController: UIViewController {
    @IBOutlet var totalWaterLbl: UILabel!   //총 마신양 레이블
    @IBOutlet var goalLbl: UILabel!         //목표 레이블
    @IBOutlet var cactusImgView: UIImageView! //선인장 이미지뷰
    @IBOutlet var intakeText: UITextField!  //섭취량 텍스트
    @IBOutlet var recommendedAmountLbl: UILabel!    //권장량 레이블
    @IBOutlet var drinkWaterBtn: UIButton!  //물마시기 버튼
    
    var cactusImage = UIImage(named: "1-1.png")
    var totalWater: Int = 0 {
        didSet {
            goal = calculateGoal()
            UserDefaults.standard.set(totalWater, forKey: "totalWater")
        }
    }
    var recommendedAmount: Double = 0
    var goal: Int = 0 {
        didSet {
            goalLbl.text = "목표의 \(goal)%"
            UserDefaults.standard.set(goal, forKey: "goal")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n\(UserDefaults.standard.bool(forKey: "isRegistered"))")
        
        if !UserDefaults.standard.bool(forKey: "isRegistered") {
            //미등록유저 ProfileVC 전환
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        setUser()
        setupView()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUser()
    }
    
    func setupView() {
        navigationItem.title = "물 마시기"
        view.backgroundColor = UIColor(named: "mainColor")
        navigationController?.navigationBar.tintColor = .white
        
        //총 마신양 레이블
        totalWaterLbl.numberOfLines = 3
        totalWaterLbl.font = UIFont.boldSystemFont(ofSize: 30)
        totalWaterLbl.adjustsFontSizeToFitWidth = true
        totalWaterLbl.text = "물 마시기 시작!\n오늘 마신 양은\n\(totalWater)ml"
        totalWaterLbl.textColor = .white
        
        //목표 퍼센트 레이블
        goal = calculateGoal()
        goalLbl.text = "목표의 \(goal)%"
        goalLbl.font = UIFont.systemFont(ofSize: 15)
        goalLbl.textColor = .white
        goalLbl.adjustsFontSizeToFitWidth = true
    
        //선인장 이미지
        cactusImgView.image = cactusImage
        
        //섭취량TF
        intakeText.keyboardType = .numberPad
        intakeText.placeholder = "섭취량"
        intakeText.font = UIFont.systemFont(ofSize: 25)
        intakeText.adjustsFontSizeToFitWidth = true
        intakeText.textAlignment = .right
        intakeText.textColor = .white
        intakeText.backgroundColor = .clear
        intakeText.borderStyle = .none
        
        //권장량
        recommendedAmountLbl.textColor = .white
        recommendedAmountLbl.font = UIFont.systemFont(ofSize: 15)
        recommendedAmountLbl.textAlignment = .center
        
        //물마시기 버튼
        drinkWaterBtn.backgroundColor = .white
        drinkWaterBtn.setTitle("물 마시기", for: .normal)
        drinkWaterBtn.setTitleColor(.black, for: .normal)
    }
    
    func setUser() {
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        let height = UserDefaults.standard.integer(forKey: "height")
        let weight = UserDefaults.standard.integer(forKey: "weight")
        
        recommendedAmount = calculateRecommendedAmount(height: Double(height), weight: Double(weight))
        recommendedAmountLbl.text = "\(nickname ?? "")님의 하루 물 권장 섭취량은 \(recommendedAmount)L 입니다."
        
        totalWater = UserDefaults.standard.integer(forKey: "totalWater")
        goal = UserDefaults.standard.integer(forKey: "goal")
    }

    func calculateRecommendedAmount (height: Double, weight: Double) -> Double {
        return (height + weight) / 100
    }
    
    func calculateGoal() -> Int {
        if totalWater == 0 {
            return 0
        } else {
            return Int((Double(totalWater) / (recommendedAmount * 1000) * 100))
        }
    }
    
    func updateView() {
        //이미지변경
        if goal <= 10 {
            cactusImgView.image = UIImage(named: "1-1.png")
        } else if goal <= 20 {
            cactusImgView.image = UIImage(named: "1-2.png")
        } else if goal <= 30 {
            cactusImgView.image = UIImage(named: "1-3.png")
        } else if goal <= 40 {
            cactusImgView.image = UIImage(named: "1-4.png")
        } else if goal <= 50 {
            cactusImgView.image = UIImage(named: "1-5.png")
        } else if goal <= 60 {
            cactusImgView.image = UIImage(named: "1-6.png")
        } else if goal <= 70 {
            cactusImgView.image = UIImage(named: "1-7.png")
        } else if goal <= 80 {
            cactusImgView.image = UIImage(named: "1-8.png")
        } else {
            cactusImgView.image = UIImage(named: "1-9.png")
        }
        
        //레이블 변경
        if goal < 100 {
            totalWaterLbl.text = "잘하셨어요!\n오늘 마신 양은\n\(totalWater)ml"
        } else {
            totalWaterLbl.text = "목표를 달성했어요!🥳\n오늘 마신 양은\n\(totalWater)ml"
            totalWaterLbl.textColor = .yellow
        }
    }
    
    @IBAction func resetTotal(_ sender: UIBarButtonItem) {
        totalWater = 0
        
        setupView()
    }
    
    @IBAction func drinkWaterBtn(_ sender: UIButton) {
        totalWater = totalWater + (Int(intakeText.text!) ?? 0)
                
        updateView()
    }
    

}

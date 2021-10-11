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
    @IBOutlet var cactusImgView: UIImageView! //선인장 이미지
    @IBOutlet var intakeText: UITextField!  //섭취량 텍스트
    @IBOutlet var recommendedAmountLbl: UILabel!    //권장량 레이블
    @IBOutlet var drinkWaterBtn: UIButton!  //물마시기 버튼
    
    
    var cactusImage = UIImage(named: "1-1.png")
    var nickname: String? = "안녕하세요"
    var height: Double? = 160
    var weight: Double? = 50
    var totalWater: Int = 0
    var recommendedAmount: Double?
    var goal: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //내비게이션 바 타이틀
        navigationItem.title = "물 마시기"
        //뷰 배경색 변경
        view.backgroundColor = UIColor(red: 0, green: 150/255, blue: 111/255, alpha: 1)
        //바 버튼 색상 변경
        navigationController?.navigationBar.tintColor = .white
        //총 마신양, 권장량, 목표량 나타내는 레이블
        recommendedAmount = calculateRecommendedAmount(height: height!, weight: weight!)
        
        totalWaterLbl.numberOfLines = 3
        totalWaterLbl.font = UIFont.boldSystemFont(ofSize: 30)
        totalWaterLbl.adjustsFontSizeToFitWidth = true
        totalWaterLbl.text = "잘하셨어요!\n오늘 마신 양은\n\(totalWater)ml"
        totalWaterLbl.textColor = .white
        
        goal = calculateGoal()
        goalLbl.text = "목표의 \(goal!)%"
        goalLbl.font = UIFont.systemFont(ofSize: 15)
        goalLbl.textColor = .white
        goalLbl.adjustsFontSizeToFitWidth = true
    
        //선인장 이미지 할당
        cactusImgView.image = cactusImage
        
        //섭취량 텍스트필드 키보드 설정
        intakeText.keyboardType = .numberPad
        intakeText.placeholder = "물 섭취량"
        intakeText.font = UIFont.systemFont(ofSize: 20)
        intakeText.textAlignment = .center
        intakeText.textColor = .white
        intakeText.backgroundColor = .clear
        
        //권장량 레이블
        recommendedAmountLbl.text = "\(nickname!)님의 하루 물 권장 섭취량은 \(recommendedAmount!)L 입니다."
        recommendedAmountLbl.textColor = .white
        recommendedAmountLbl.font = UIFont.systemFont(ofSize: 15)
        
        
        //물마시기 버튼
        drinkWaterBtn.backgroundColor = .white
        drinkWaterBtn.setTitle("물 마시기", for: .normal)
        drinkWaterBtn.setTitleColor(.black, for: .normal)
    }
    
    func calculateRecommendedAmount (height: Double, weight: Double) -> Double {
        return (height + weight) / 100
    }
    
    func calculateGoal() -> Int {
        return Int((Double(totalWater) / (recommendedAmount! * 1000) * 100))
    }
    
    @IBAction func resetTotal(_ sender: UIBarButtonItem) {
        totalWater = 0
        totalWaterLbl.text = "잘하셨어요!\n오늘 마신 양은\n\(totalWater)ml"
    }
    
    @IBAction func drinkWaterBtn(_ sender: UIButton) {
        totalWater = totalWater +  (Int(intakeText.text!) ?? 0)
        totalWaterLbl.text = "잘하셨어요!\n오늘 마신 양은\n\(totalWater)ml"
        goal = calculateGoal()
        goalLbl.text = "목표의 \(goal!)%"
    }
    

}

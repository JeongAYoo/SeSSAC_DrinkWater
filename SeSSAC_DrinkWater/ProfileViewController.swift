//
//  ProfileViewController.swift
//  SeSSAC_DrinkWater
//
//  Created by Jade Yoo on 2021/10/09.
//

import UIKit
import TextFieldEffects
import Toast

class ProfileViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var saveBarBtn: UIBarButtonItem!
    @IBOutlet weak var cactusImgView: UIImageView!
    @IBOutlet weak var nicknameTF: HoshiTextField!
    @IBOutlet weak var heightTF: HoshiTextField!
    @IBOutlet weak var weightTF: HoshiTextField!
    
    var cactusImage = UIImage(named: "1-1.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if UserDefaults.standard.bool(forKey: "isRegistered") {
            nicknameTF.text = UserDefaults.standard.string(forKey: "nickname")
            heightTF.text = UserDefaults.standard.string(forKey: "height")
            weightTF.text = UserDefaults.standard.string(forKey: "weight")
            
            updateImage()
        } else {
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor(named: "profileColor")
        saveBarBtn.title = "저장"
        cactusImgView.image = cactusImage
        
        [nicknameTF, heightTF, weightTF].forEach {
            $0?.borderStyle = .none
            $0?.placeholderColor = .white
            $0?.textColor = .white
            $0?.text = ""
            $0?.font = .systemFont(ofSize: 17)
            
            $0?.borderActiveColor = .white
            $0?.borderInactiveColor = .white
        }
        
        nicknameTF.placeholder = "닉네임을 설정해주세요."
        heightTF.placeholder = "키(cm)를 설정해주세요."
        weightTF.placeholder = "몸무게(kg)를 설정해주세요."
    }
    
    func updateImage() {
        let goal = UserDefaults.standard.integer(forKey: "goal")
        
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
    }
    func nicknameTFCheck(_ tf: UITextField) -> Bool {
        
        if !textFieldNullCheck(tf) {
            let testString: String = tf.text!
            let pattern: String = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]*$"
            
            guard let _ = testString.range(of: pattern, options: .regularExpression) else {
                print("문자 외 포함됨")
                self.view.makeToast("닉네임은 5자 이하 한글/영어만 입력해주세요.", duration: 2.0, position: .center)
                tf.text = ""
                return false
            }
            
            if testString.count > 5 {
                print("닉네임 5자 초과")
                self.view.makeToast("닉네임은 5자 이하 한글/영어만 입력해주세요.", duration: 2.0, position: .center)
                tf.text = ""
                return false
            }
            
            return true
        } else { return false }
    }
    
    func numberTFCheck(_ tf: UITextField) -> Bool {
        
        if !textFieldNullCheck(tf) {
            let testString: String = tf.text!
            let pattern: String = "^[0-9]*$"

            guard let _ = testString.range(of: pattern, options: .regularExpression) else {
                print("숫자 외 포함됨")
                self.view.makeToast("키와 몸무게는 숫자만 입력해주세요.", duration: 2.0, position: .center)
                tf.text = ""
                return false
            }
            
            if testString.count > 3 || Int(testString)! <= 0 {
                print("키, 몸무게 3자리 초과")
                self.view.makeToast("키와 몸무게를 올바르게 입력해주세요.", duration: 2.0, position: .center)
                tf.text = ""
                return false
            }
            return true
        } else { return false }
    }
    
    func textFieldNullCheck(_ tf: UITextField) -> Bool {
        if tf.text == "" {
            self.view.makeToast("빈칸 없이 입력해주세요.", duration: 2.0, position: .center)
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func saveBarButtonClicked(_ sender: UIBarButtonItem) {
        
        if nicknameTFCheck(nicknameTF) && numberTFCheck(heightTF) && numberTFCheck(weightTF) {
            UserDefaults.standard.set(nicknameTF.text, forKey: "nickname")
            UserDefaults.standard.set(Int(heightTF.text!), forKey: "height")
            UserDefaults.standard.set(Int(weightTF.text!), forKey: "weight")

            print("저장완료")
            UserDefaults.standard.set(true, forKey: "isRegistered")
            navigationController?.popViewController(animated: true)
        }

    }
    
}

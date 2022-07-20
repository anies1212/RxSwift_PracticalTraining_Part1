//
//  ViewController.swift
//  Rx_Training_day1
//
//  Created by anies1212 on 2022/07/19.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var label: UILabel!
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Tap!!"
        addRxObserver()
    }
    
    private func addRxObserver(){
        button.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.label.text = "Did Tapped!"
            })
            .disposed(by: bag)
        button2.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.label.text = "Button2 did Tapped"
            })
            .disposed(by: bag)
        button3.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.label.text = "Button3 did Tapped"
            })
            .disposed(by: bag)
        nextButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "textFieldVC") as? TextFieldViewController else { return }
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: bag)
    }
    
    


}


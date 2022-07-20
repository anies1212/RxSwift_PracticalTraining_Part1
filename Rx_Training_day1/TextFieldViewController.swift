//
//  TextFieldViewController.swift
//  Rx_Training_day1
//
//  Created by anies1212 on 2022/07/19.
//

import UIKit
import RxCocoa
import RxSwift

class TextFieldViewController: UIViewController {
    
    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var label2: UILabel!
    private let maxNameFieldSize = 10
    private let maxAddressFieldSize = 50
    @IBOutlet var button: UIButton!
    let limitText: (Int) -> String = {
        return "あと\($0)文字"
    }
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRxObserver()
    }
    
    private func addTarget(){
        textField1.addTarget(self, action: #selector(field1EditingChanged(sender:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(field2EditingChanged(sender:)), for: .editingChanged)
    }
    
    @objc func field1EditingChanged(sender: UITextField){
        guard let text = sender.text else { return }
        let limitCount = maxNameFieldSize - text.count
        label.text = limitText(limitCount)
    }
    
    @objc func field2EditingChanged(sender: UITextField){
        guard let text = sender.text else { return }
        let limitCount = maxAddressFieldSize - text.count
        label2.text = limitText(limitCount)
    }
    
    private func addRxObserver(){
        textField1.rx.text
            .map({[weak self] text -> String? in
                guard let text = text else { return nil }
                guard let maxNameFieldSize = self?.maxNameFieldSize else { return nil }
                let limitCount = maxNameFieldSize - text.count
                return self?.limitText(limitCount)
            })
            .bind(to: label.rx.text)
            .disposed(by: bag)
        
        textField2.rx.text
            .map({[weak self] text -> String? in
                guard let text = text else { return nil }
                guard let maxAddressFieldSize = self?.maxAddressFieldSize else { return nil }
                let limitCount = maxAddressFieldSize - text.count
                return self?.limitText(limitCount)
            })
            .bind(to: label2.rx.text)
            .disposed(by: bag)
        button.rx.tap
            .subscribe(onNext: {[weak self] _ in
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "practiceVC") as? PracticeViewController else { return }
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: bag)
    }
    

    

}

//
//  PracticeViewController.swift
//  Rx_Training_day1
//
//  Created by anies1212 on 2022/07/20.
//

import UIKit
import RxCocoa
import RxSwift

class PracticeViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var label: UILabel!
    private let bag = DisposeBag()
    let viewModel = CounterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addRxObserver()
    }
    

    private func addRxObserver(){
        let input = CounterViewModelInput(
            countUpButton: button1.rx.tap.asObservable(),
            countDownButton: button2.rx.tap.asObservable(),
            countResetButton: button3.rx.tap.asObservable()
        )
        viewModel.setup(input: input)
        viewModel.outputs?.counterText
            .drive(label.rx.text)
            .disposed(by: bag)
    }

}

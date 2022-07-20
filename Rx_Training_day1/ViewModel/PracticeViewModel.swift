//
//  PracticeViewModel.swift
//  Rx_Training_day1
//
//  Created by anies1212 on 2022/07/20.
//

import Foundation
import RxSwift
import RxCocoa

struct CounterViewModelInput {
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
}

protocol CounterViewModelOutput {
    var counterText: Driver<String?> { get }
}

protocol CounterViewModelType {
    var outputs: CounterViewModelOutput? { get }
    func setup(input: CounterViewModelInput)
}

class CounterViewModel: CounterViewModelType, CounterViewModelOutput {
    
    var outputs: CounterViewModelOutput?
    private let countRelay = BehaviorRelay<Int>(value: 0)
    private let initialCount = 0
    private let bag = DisposeBag()
    
    init() {
        self.outputs = self
        resetCounts()
    }
    
    func setup(input: CounterViewModelInput) {
        input.countUpButton
            .subscribe(onNext: {[weak self] in
                self?.incrementCount()
            })
            .disposed(by: bag)
        input.countDownButton
            .subscribe(onNext: {[weak self] in
                self?.decrementCount()
            })
            .disposed(by: bag)
        input.countResetButton
            .subscribe(onNext: {[weak self] in
                self?.resetCounts()
            })
            .disposed(by: bag)
    }
    
    private func resetCounts(){
        countRelay.accept(initialCount)
    }
    
    private func incrementCount(){
        let count = countRelay.value + 1
        countRelay.accept(count)
    }
    
    private func decrementCount(){
        let count = countRelay.value - 1
        countRelay.accept(count)
    }
}

extension CounterViewModel {
    var counterText: Driver<String?> {
        return countRelay
            .map({"Rxパターン:\($0)"})
            .asDriver(onErrorJustReturn: nil)
    }
}

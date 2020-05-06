//
//  WatchNowViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

struct WatchNowViewModel {
    let navigator: WatchNowNavigatorType
    let useCase: WatchNowUseCaseType
}

extension WatchNowViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}

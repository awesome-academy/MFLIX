//
//  SeeAllViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

struct SeeAllViewModel {
    let navigator: SeeAllNavigatorType
    let useCase: SeeAllUseCaseType
    let type: CategoryType
}

extension SeeAllViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let title: Driver<String>
    }
    
    func transform(_ input: Input) -> Output {
        
        let title = input.loadTrigger
            .map { _ in self.type.title }
            .asDriver()
        
        return Output(
            title: title
        )
    }
}

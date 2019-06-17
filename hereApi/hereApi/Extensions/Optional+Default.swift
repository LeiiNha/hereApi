//
//  Optional+Default.swift
//  hereApi
//
//  Created by Erica Geralde on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

extension Optional {
    func orDefault(_ defaultExpression: @autoclosure () -> Wrapped) -> Wrapped {
        guard let value = self else {
            return defaultExpression()
        }
        return value
    }
}

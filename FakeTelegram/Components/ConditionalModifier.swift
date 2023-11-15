//
//  ConditionalModifier.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import Foundation
import SwiftUI


extension View {
    @ViewBuilder func `if`<T>(_ condition: Bool, transform: (Self) -> T) -> some View where T : View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

//
//  File.swift
//  
//
//  Created by Raul Batista on 02.12.2023.
//

import Foundation

public protocol ViewModelContaining {
    associatedtype ViewModel

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: ViewModel! { get set }
}

public extension Bundle {
    var appIdentifierPrefix: String? {
        infoDictionary?["AppIdentifierPrefix"] as? String
    }
}

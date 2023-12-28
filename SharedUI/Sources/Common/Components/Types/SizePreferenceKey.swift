//
//  SizePreferenceKey.swift
//
//
//  Created by Raul Batista on 28.12.2023.
//

import Foundation
import SwiftUI

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

//
//  File.swift
//  
//
//  Created by Raul Batista on 25.12.2023.
//

import Foundation
import SwiftUI

extension View {
    func frame(size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
}

//
//  FontLoader.swift
//
//
//  Created by Raul Batista on 25.11.2023.
//

import SwiftUI

/// This FontLoader is needed to allow us to load the fonts in our app from the SPM package
/// https://stackoverflow.com/questions/62681206/xcode-12b1-swift-packages-custom-fonts
public enum FontLoader {
    public static func setup() {
        _ = R.font.map { font in
            loadFont(name: font.name)
        }
    }

    private static func loadFont(name: String, extension fontExt: String = "ttf") {
        guard
            let fontUrl = bundle.url(forResource: name, withExtension: fontExt),
            let dataProvider = CGDataProvider(url: fontUrl as CFURL),
            let newFont = CGFont(dataProvider)
        else {
            assertionFailure("can't load fonts")
            return
        }

        var error: Unmanaged<CFError>?
        _ = CTFontManagerRegisterGraphicsFont(newFont, &error)
    }
}

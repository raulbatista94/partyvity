//
//  File.swift
//  
//
//  Created by Raul Batista on 02.12.2023.
//

import SwiftUI

/// - Tag: HostingController
public final class HostingController<Content: View>: UIHostingController<Content> {
    public var navigationBarBackgroundColor: UIColor = .backgroundPrimary

    public init(rootView: Content, title: String? = nil) {
        super.init(rootView: rootView)
        self.title = title
    }

    @available(*, unavailable)
    dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
    }

    // https://stackoverflow.com/a/69359296/14044847
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setNeedsUpdateConstraints()
    }
}

struct WithBackgroundImage: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            content
        }
    }
}

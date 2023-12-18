//
//  File.swift
//  
//
//  Created by Raul Batista on 17.12.2023.
//

import Foundation

@MainActor
public class MainMenuViewModel: ObservableObject {
    @Published private(set) var gameInProgressAvailable: Bool = false
    private weak var eventHandler: MainMenuEventHandling?

    public nonisolated init(eventHandler: MainMenuEventHandling) {
        self.eventHandler = eventHandler
    }

    func handleEvent(_ event: MainMenuEvent) {
        eventHandler?.handle(event: event)
    }
}

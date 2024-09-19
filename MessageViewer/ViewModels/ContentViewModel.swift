//
//  ContentViewModel.swift
//  MessageViewer
//
//  Created by Volodymyr Matiukh on 19.09.2024.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published
    var messages: [Message] = []
    
    private lazy var messageLoader = {
        let loader = MessageLoader()
        loader.delegate = self
        return loader
    }()
    
    @Published
    var newMessage: String?
    
    func startMessageUpdates() {
        messageLoader.startMessageGeneration()
    }
    
    func sendMessage() {
        guard let newMessage else { return }
        
        messages.append(.init(id: UUID(), text: newMessage, date: Date()))
        self.newMessage = nil
    }
}

extension ContentViewModel: MessageLoaderDelegate {
    func didReceiveMessage(_ message: Message) {
        messages.append(message)
    }
}

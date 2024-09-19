//
//  MessageLoader.swift
//  MessageViewer
//
//  Created by Volodymyr Matiukh on 19.09.2024.
//

import Foundation

protocol MessageLoaderDelegate {
    func didReceiveMessage(_ message: Message)
}

class MessageLoader {
    
    lazy var timer: Timer = Timer(timeInterval: 1, target: self, selector: #selector(generateMessage), userInfo: nil, repeats: true)
    var delegate: MessageLoaderDelegate?
    
    private let messageContent = ["apple", "banana", "cat", "dog", "elephant", "frog", "giraffe", "hat", "ice", "jungle", "kite", "lemon", "monkey", "notebook", "orange", "pencil", "queen", "robot", "star", "tiger"]
    
    func startMessageGeneration() {
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc
    private func generateMessage() {
        let message = Message(id: UUID(), text: generateRandomText(), date: Date())
        delegate?.didReceiveMessage(message)
    }
    
    private func generateRandomText() -> String {
        let length = Int.random(in: 1...15)
        var words: [String] = []
        for _ in 0..<length {
            words.append(messageContent[Int.random(in: 0..<messageContent.count)])
        }
        return words.joined(separator: " ")
    }
}

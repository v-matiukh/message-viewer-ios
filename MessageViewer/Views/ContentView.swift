//
//  ContentView.swift
//  MessageViewer
//
//  Created by Volodymyr Matiukh on 19.09.2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject
    var viewModel = ContentViewModel()
    
    @FocusState
    var isFocusedInput: Bool
    
    @State
    var isAutoScroll: Bool = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollViewReader { proxy in
                    List($viewModel.messages, id: \.id) { message in
                        let isLast = viewModel.messages.last?.id == message.id
                        let wrappedMessage = message.wrappedValue
                        let width = geometry.size.width * 0.7
                        MessageListItem(message: wrappedMessage.text, date: wrappedMessage.date, width: width)
                            .listRowSeparator(.hidden)
                            .frame(minWidth: .zero, maxWidth: width, alignment: .leading)
                            .onAppear {
                                isAutoScroll = isLast
                            }
                    }
                    .listStyle(.plain)
                    .onChange(of: viewModel.messages.count, perform: { _ in if isAutoScroll, let last = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id)  // <-- here
                        }
                    }
                    })
                }
                
                HStack(alignment: .center) {
                    TextField("Enter your message", text: .init(get: {
                        viewModel.newMessage ?? ""
                    }, set: { newValue in
                        viewModel.newMessage = newValue
                    }))
                    .focused($isFocusedInput)
                    .textFieldStyle(.roundedBorder)
                    Button("Send") {
                        viewModel.sendMessage()
                        isFocusedInput = false
                    }
                    
                }
                .padding(.bottom, 20)
                .padding(.top, 10)
                .padding(.horizontal, 6)
                .background(Color(uiColor: UIColor(white: 0.4, alpha: 0.5)))
            }
            .onTapGesture {
                isFocusedInput = false
            }
            .onAppear {
                viewModel.startMessageUpdates()
            }
        }
    }
}

#Preview {
    ContentView()
}

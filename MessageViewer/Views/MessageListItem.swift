//
//  MessageListItem.swift
//  MessageViewer
//
//  Created by Volodymyr Matiukh on 19.09.2024.
//

import SwiftUI

public struct MessageListItem: View {
    
    let message: String
    let date: Date
    let width: CGFloat
    
    public var body: some View {
        let horizontalPadding: CGFloat = 16
        let textWidth = textWidth(width - horizontalPadding)
        let isLastLineHasSpace = lastLineHasSpace(width - horizontalPadding)
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                // Message text
                Text(message)
                    .font(.system(size: 15))
                Spacer(minLength: 5)
                if isLastLineHasSpace {
                    Text(date.formatted(date: .omitted, time: .standard))
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                        .padding(.leading, 2)
                }
            }
            if !isLastLineHasSpace {
                HStack(alignment: .bottom) {
                    Spacer()
                    Text(date.formatted(date: .omitted, time: .standard))
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: textWidth + horizontalPadding)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background(Color(UIColor.lightGray.withAlphaComponent(0.3)))
        .clipShape(.rect(cornerRadius: 12))
    }
    
    func lastLineHasSpace(_ width: CGFloat) -> Bool {
        let originalTextSize = message.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)])
        let textSize = message.boundingRect(with: .init(width: width, height: .infinity), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 15)], context: nil).size
        let screenWidth = width
        let textWidth = originalTextSize.width.truncatingRemainder(dividingBy: screenWidth)
        return originalTextSize.width > screenWidth && textSize.width - textWidth > 60
    }
    
    func textWidth(_ width: CGFloat) -> CGFloat {
        let textSize = message.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)])
        let screenWidth = width
        let dateText = date.formatted(date: .omitted, time: .standard)
        let dateSize = dateText.size(withAttributes: [.font: UIFont.systemFont(ofSize: 13)])
        return textSize.width > screenWidth ? screenWidth : max(textSize.width, dateSize.width)
    }
}

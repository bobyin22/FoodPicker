//
//  Extensions.swift
//  FoodPicker
//
//  Created by Yin Bob on 2025/2/6.
//

import SwiftUI

extension View {
    func mainButtonStyle() -> some View {
        buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
    
    func roundedRectBackground(radius: CGFloat = 8,
                               fill: some ShapeStyle = Color.bg) -> some View {
        background(RoundedRectangle(cornerRadius: radius).foregroundStyle(fill))
    }
}

extension Animation {
   static let mySprint = spring(dampingFraction: 0.55)
    static let myEase = easeInOut(duration: 0.6)
}

extension Color {
    static let bg = Color(.systemBackground)
    static let bg2 = Color(.secondarySystemBackground)
}

extension AnyTransition {
    static let moveUpWithOpacity = Self.move(edge: .top).combined(with: .opacity)
    
    static let delayInsertionOpcaity = Self.asymmetric(
        insertion: .opacity
            .animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity
            .animation(.easeInOut(duration: 0.4)))
}

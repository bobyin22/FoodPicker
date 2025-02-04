//
//  ContentView.swift
//  FoodPicker
//
//  Created by Yin Bob on 2025/2/4.
//

import SwiftUI



struct ContentView: View {
    let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]
    @State private var selectedFood: String?
    
    var body: some View {
        VStack(spacing:30) {
            Image("dinner")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("今天吃什麼？")
                .bold()
            
            if selectedFood != .none {
                Text(selectedFood ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.green)
            }
            
            Button {
                selectedFood = food.shuffled().filter{ $0 != selectedFood }.first
            } label: {
                Text(selectedFood == .none ? "告訴我!" : "換一個").frame(width: 200)
            }
            .padding(.bottom, -15)
            
            Button {
                selectedFood = .none
            } label: {
                Text("重置").frame(width: 200, alignment: .center)
            }
            .buttonStyle(.bordered)

        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .font(.title)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .animation(.easeInOut(duration: 1), value: selectedFood)
    }
}

#Preview {
    ContentView()
}

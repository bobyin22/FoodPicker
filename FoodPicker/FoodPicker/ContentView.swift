//
//  ContentView.swift
//  FoodPicker
//
//  Created by Yin Bob on 2025/2/4.
//

import SwiftUI


struct ContentView: View {
    let food = Food.examples
    @State private var selectedFood: Food?
    
    var body: some View {
        VStack(spacing:30) {
            Group {
                if selectedFood != .none {
                    Text("\(selectedFood!.image)")
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                } else {
                    Image("dinner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.frame(height: 250)
            
            
            Text("今天吃什麼？")
                .bold()
            
            if selectedFood != .none {
                Text(selectedFood!.name ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.green)
                    .id(selectedFood!.name)
                    .transition(.asymmetric(
                        insertion: .opacity
                            .animation(.easeInOut(duration: 0.5).delay(0.2)),
                        removal: .opacity
                            .animation(.easeInOut(duration: 0.4))))
            } else { EmptyView() }
            
            Spacer()
            
            Button {
                selectedFood = food.shuffled().first { $0 != selectedFood }
            } label: {
                Text(selectedFood == .none ? "告訴我" : "換一個").frame(width: 200)
                    .animation(.none, value: selectedFood)
                    .transformEffect(.identity)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .font(.title)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .animation(.easeInOut(duration: 0.6), value: selectedFood)
    }
}

#Preview {
    ContentView()
}

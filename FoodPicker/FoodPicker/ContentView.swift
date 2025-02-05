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
        ScrollView {
            VStack(spacing: 30) {
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
                    HStack {
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
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    
                    
                    Text("熱量\(selectedFood!.calorie.formatted())")
                        .font(.title2)
                    
                    HStack {
                        VStack(spacing: 12) {
                            Text("蛋白質")
                            Text(selectedFood!.protein.formatted() + " g")
                        }
                        
                        Divider().padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            Text("脂肪")
                            Text(selectedFood!.calorie.formatted() + " g")
                        }
                        
                        Divider().frame(width: 1).padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            Text("碳水")
                            Text(selectedFood!.carb.formatted() + " g")
                        }
                    }
                    .font(.title3)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemBackground)))
                }
                
                
                Spacer().layoutPriority(1)
                
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
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .animation(.easeInOut(duration: 0.6), value: selectedFood)
        }.background(Color(.secondarySystemBackground))
    }
}

extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

#Preview {
    ContentView(selectedFood: .examples.first!)
    //ContentView(selectedFood: .examples.first!).previewDevice(.iPad)
}

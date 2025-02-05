//
//  ContentView.swift
//  FoodPicker
//
//  Created by Yin Bob on 2025/2/4.
//

import SwiftUI

extension View {
    func mainButtonStyle() -> some View {
        buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
}


struct ContentView: View {
    @State private var selectedFood: Food?
    @State private var shouldShowInfo: Bool = false
    
    let food = Food.examples
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                foodImage
                
                Text("今天吃什麼？").bold()
                
                selectedFoodInfoView
                
                Spacer().layoutPriority(1)
                
                selectFoodButton
                
                cancelButton
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .mainButtonStyle()
            .animation(.spring(dampingFraction: 0.55), value: shouldShowInfo)
            .animation(.easeInOut(duration: 0.6), value: selectedFood)
        }.background(Color(.secondarySystemBackground))
    }
}
    
// MARK: - Subviews
private extension ContentView {

    var foodImage: some View {
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
    }
    
    var foodNameView: some View {
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
            Button {
                shouldShowInfo.toggle()
            } label: {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.secondary)
            }.buttonStyle(.plain)
        }
    }
    
    var foodDetailView: some View {
        VStack {
            if shouldShowInfo {
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    GridRow {
                        Text("蛋白質")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 40)
                    
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)
                    
                    GridRow {
                        Text(selectedFood!.protein.formatted() + " g")
                        Text(selectedFood!.calorie.formatted() + " g")
                        Text(selectedFood!.carb.formatted() + " g")
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemBackground)))
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
    
    @ViewBuilder var selectedFoodInfoView: some View {
        if selectedFood != .none {
            foodNameView
            
            Text("熱量\(selectedFood!.calorie.formatted())")
                .font(.title2)
            
            foodDetailView
        }
    }
    
    var selectFoodButton: some View {
        Button {
            selectedFood = food.shuffled().first { $0 != selectedFood }
        } label: {
            Text(selectedFood == .none ? "告訴我" : "換一個").frame(width: 200)
                .animation(.none, value: selectedFood)
                .transformEffect(.identity)
        }
        .padding(.bottom, -15)
    }
    
    var cancelButton: some View {
        Button {
            selectedFood = .none
            shouldShowInfo = false
        } label: {
            Text("重置").frame(width: 200, alignment: .center)
        }
        .buttonStyle(.bordered)
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

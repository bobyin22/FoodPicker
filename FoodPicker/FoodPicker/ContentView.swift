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
    @State private var showInfo: Bool = false
    
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
                        Button {
                            showInfo.toggle()
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.secondary)
                        }.buttonStyle(.plain)
                    }
                    
                    
                    Text("熱量\(selectedFood!.calorie.formatted())")
                        .font(.title2)
                      
                    
                VStack {
                    if showInfo {
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
                    showInfo = false
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
            .animation(.spring(dampingFraction: 0.55), value: showInfo)
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

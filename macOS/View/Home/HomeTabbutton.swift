//
//  Tabbutton.swift
//  InTechs (macOS)
//
//  Created by GoEun Jeong on 2021/08/22.
//

import SwiftUI

struct HomeTabButton: View {
    var tab: HomeTab
    var number: String?
    @Binding var selectedTab: HomeTab
    @State private var hover = false
    
    var body: some View {
        ZStack {
            Button(action: {
                if number != nil { // 단축키의 유무
                    withAnimation {
                        selectedTab = tab
                    }
                }
            }, label: {
                VStack(spacing: 7) {
                    Image(systemName: tab.getImage())
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(selectedTab == tab ? .white : .gray)
                }
                .padding(.vertical, 8)
                .frame(width: 50)
                .contentShape(Rectangle())
                .background(Color.primary.opacity(selectedTab == tab ? 0.15 : 0))
                .cornerRadius(10)
            })
            .buttonStyle(PlainButtonStyle())
            .onHover(perform: { hovering in
                self.hover = hovering
            })
            
            if hover {
                HStack {
                    Text(tab.rawValue)
                        .fontWeight(.semibold)
                        .font(.system(size: 11))
                        .fixedSize(horizontal: true, vertical: false)
                    
                    HStack(spacing: 5) {
                        if number == "?" {
                            Image(system: .command)
                            Image(system: .questionSquare)
                        } else if number != nil {
                            Image(system: .command)
                            Image(systemName: "\(number!).square")
                        }
                    }
                    
                }
                .padding(.horizontal, 5)
                .frame(height: 30)
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .background(Color.black)
                .offset(x: 70)
               
            }
        }
        
    }
}
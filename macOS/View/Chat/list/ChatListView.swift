//
//  AllChatView.swift
//  InTechs (macOS)
//
//  Created by GoEun Jeong on 2021/08/22.
//

import SwiftUI
import Kingfisher

struct ChatListView: View {
    @StateObject var viewModel = ChatListViewModel()
    
    @Namespace private var animation
    
    @State private var mentionsPop = false
    @State private var editPop = false
    
    var body: some View {
        ZStack {
            VStack {
                // Title
                HStack(spacing: 15) {
                    Text("채팅")
                        .font(.title)
                    
                    Spacer()
                    
                    Button(action: {
                        self.editPop.toggle()
                    }, label: {
                        Image(system: .edit)
                            .foregroundColor(.white)
                    }).frame(width: 25, height: 25)
                        .popover(isPresented: $editPop) {
                            EditPopView()
                                .frame(width: 200)
                        }
                }.padding()
                
                // Tab
                VStack(spacing: 5) {
                    HStack(spacing: 0) {
                        ChatTabButton(animation: animation, tab: .home, selectedTab: $viewModel.selectedTab)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedTab = .home
                                }
                            }
                        
                        ChatTabButton(animation: animation, tab: .channels, selectedTab: $viewModel.selectedTab)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedTab = .channels
                                }
                            }
                        
                        ChatTabButton(animation: animation, tab: .DMs, selectedTab: $viewModel.selectedTab)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedTab = .DMs
                                }
                            }
                        
                        Spacer()
                    }
                    Divider()
                }
                
                ZStack {
                    switch viewModel.selectedTab {
                    case .home:
                        List(selection: $viewModel.selectedHome) {
                            ForEach(0..<viewModel.homes.count) { index in
                                NavigationLink(destination: ChatDetailView(channel: $viewModel.homes[index]).environmentObject(viewModel)) {
                                    ChatRow(channel: viewModel.homes[index])
                                }
                            }
                        }
                    case .channels:
                        List(selection: $viewModel.selectedChannel) {
                            ForEach(0..<viewModel.channels.count) { index in
                                NavigationLink(destination: ChatDetailView(channel: $viewModel.channels[index]).environmentObject(viewModel)) {
                                    ChatRow(channel: viewModel.channels[index])
                                }
                            }
                        }
                    case .DMs:
                        List(selection: $viewModel.selectedDM) {
                            ForEach(0..<viewModel.DMs.count) { index in
                                NavigationLink(destination: ChatDetailView(channel: $viewModel.DMs[index]).environmentObject(viewModel)) {
                                    ChatRow(channel: viewModel.DMs[index])
                                }
                            }
                        }
                    }
                }
            }
            
            HStack {
                Color.black.frame(width: 1)
                Spacer()
            }
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct ChatRow: View {
    var channel: Channel
    
    var body: some View {
        HStack {
            if channel.imageUrl == "placeholder" {
                ZStack {
                    Image(channel.imageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text("#")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            } else {
                KFImage(URL(string: channel.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            
            
            VStack(spacing: 4) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(channel.name)
                            .fontWeight(.bold)
                        
                        Text(channel.lastMsg)
                            .font(.caption)
                    }
                    
                    Spacer(minLength: 10)
                    
                    VStack(alignment: .trailing) {
                        Text(channel.lastMsgTime)
                            .font(.caption)
                        
                        if channel.pendingMsgs != "0" {
                            Text(channel.pendingMsgs)
                                .font(.caption2)
                                .padding(5)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct AllChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
            .environmentObject(HomeViewModel())
        EditPopView()
            .frame(width: 200)
    }
}

struct EditPopView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Read")
                        .foregroundColor(.gray)
                    
                    Button(action: {}, label: {
                        HStack {
                            Image(system: .checklist)
                            Text("전부 읽음처리")
                        }
                    }).buttonStyle(PlainButtonStyle())
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Browse")
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                    
                    Button(action: {}, label: {
                        HStack {
                            Image(system: .person)
                            Text("DM 시작하기")
                        }
                    }).buttonStyle(PlainButtonStyle())
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Create")
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                    
                    Button(action: {}, label: {
                        HStack {
                            Text("#")
                            Text("새 채널")
                        }
                    }).buttonStyle(PlainButtonStyle())
                }
            }.padding([.top, .bottom], 10)
                .padding(.bottom, 10)
            
            Spacer(minLength: 0)
        }.padding(.leading)
    }
}

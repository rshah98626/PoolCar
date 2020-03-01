//
//  PopupBanner.swift
//  PoolCar
//
//  Created by Bhavish Bhattar on 2/21/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI

struct BannerData {
    let title: String
    let subtitle: String? = nil
    var actionTitle: String? = nil
    var level: Level = .info
    let style: Style
    enum Style {
        case fullWidth
        case popUp
        case action
    }
    enum Level {
        case warning
        case info
        case error
        case success
        var tintColor: Color {
            switch self {
            case .error: return .red
            case .info: return .white
            case .success: return .green
            case .warning: return .yellow
            }
        }
    }
}
extension BannerData {
    func makeBanner(action: (() -> Void)? = nil) -> some View {
            return AnyView(BannerWithButton(data: self, action: action))
    }
}

struct PopupBanner: ViewModifier {
    @Binding var isPresented: Bool
    let data: BannerData
    let action: (() -> Void)?
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            if isPresented {
                data.makeBanner(action: action)
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onTapGesture {
                        self.isPresented = false
                    }
            }
            content
        }
    }
}

extension View {
    func banner(isPresented: Binding<Bool>, data: BannerData, action: (() -> Void)? = nil) -> some View {
        self.modifier(PopupBanner(isPresented: isPresented, data: data, action: action))
    }
}

struct BannerWithButton: View {
    let data: BannerData
    var action: (() -> Void)?
    var body: some View {
        HStack {
            Text(data.title)
            Spacer()
            Button(action: {
                self.action?()
            }) {
                Text(data.actionTitle ?? "Action")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                    .background(Rectangle().foregroundColor(Color.black.opacity(0.3)))
            }
        }
        .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
        .background(LinearGradient(gradient: Gradient(colors: [.white, data.level.tintColor]), startPoint: .top, endPoint: .bottom))
    }

}



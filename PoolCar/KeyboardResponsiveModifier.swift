//
//  KeyboardResponsiveModifier.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/12/20.
//  Copyright © 2020 RSInc. All rights reserved.
//
//  swiftlint:disable:next line_length
//  adapted from https://stackoverflow.com/questions/56491881/move-textfield-up-when-thekeyboard-has-appeared-by-using-swiftui-ios user jberlana

import SwiftUI

struct KeyboardResponsiveModifier: ViewModifier {
    @State private var offset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                    object: nil, queue: .main) { notif in
                        let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                        let height = value!.height
                        let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                        self.offset = height - (bottomInset ?? 0)
                }

                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                    object: nil, queue: .main) { _ in
                        self.offset = 0
                }
            }
            .animation(.spring())
    }
}

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
        return modifier(KeyboardResponsiveModifier())
    }
}

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
            // register observers to move screen up or down
            .onAppear {
                // swiftlint:disable:next discarded_notification_center_observer
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                    object: nil, queue: .main) { notif in
                        self.onKeyboardShow(notification: notif)
                }

                // swiftlint:disable:next discarded_notification_center_observer
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                    object: nil, queue: .main) { _ in
                        self.onKeyboardHide()
                }
            }
            .animation(.spring())
    }

    // move window up length of keyboard
    func onKeyboardShow(notification: Notification) {
        let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let height = value!.height
        let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
        self.offset = height - (bottomInset ?? 0)
    }

    // slide down keyboard
    func onKeyboardHide() {
        self.offset = 0
    }
}

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
        return modifier(KeyboardResponsiveModifier())
    }
}

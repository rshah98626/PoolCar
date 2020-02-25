//
//  NavigationDrawer.swfit.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct NavigationDrawer: View {
    private let width = UIScreen.main.bounds.width - 100
    @Binding var isOpen: Bool
    @Binding var shouldLogOut: Bool

    var body: some View {
        ZStack {
            // adds opaque view on top of background
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn)
            .onTapGesture {
                self.isOpen.toggle()
            }
            // menu content
            HStack {
                DrawerContent(shouldLogOut: self.$shouldLogOut)
                    .frame(width: self.width)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.easeIn)
                Spacer()
            }
        }
    }
}

struct NavigationDrawer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDrawer(isOpen: .constant(true), shouldLogOut: .constant(true))
    }
}

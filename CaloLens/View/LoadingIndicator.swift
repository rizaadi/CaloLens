//
//  LoadingIndicator.swift
//  CaloLens
//
//  Created by Riza Adi Kurniawan on 03/03/24.
//

import SwiftUI

struct LoadingIndicator: View {
    @State private var isLoading: Bool = false
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.7)
            .stroke(.green, lineWidth: 3)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: false ), value: isLoading)
            .frame(width: 20,height: 20)
            .onAppear{
                isLoading = true
            }
    }
}

#Preview {
    LoadingIndicator()
}

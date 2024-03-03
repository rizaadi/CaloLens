//
//  ScanView.swift
//  CaloLens
//
//  Created by Riza Adi Kurniawan on 01/03/24.
//

import SwiftUI

struct ScanView: View {
    @StateObject var scanVM = ScanVM()
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        
        
        VStack {
            Group {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                    
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .frame(width: 200, height: 300)
                    
                }
                if selectedImage != nil && scanVM.calorie != nil {
                    Text(scanVM.calorie?.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding([.bottom,.top], 10)
                    
                    VStack(alignment: .leading) {
                        Text("Benefit")
                            .fontWeight(.medium)
                        Text(scanVM.calorie?.benefit ?? "")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .foregroundColor(.gray)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.1))
                    }
                    .padding(.bottom, 8)
                    
                    
                    HStack(alignment:.top) {
                        VStack(alignment:.leading){
                            Text("Calorie")
                                .font(.headline)
                                .foregroundStyle(.green)
                            
                            Text(scanVM.calorie?.calorie ?? "")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                            Text("kcal")
                                .font(.caption)
                                .foregroundStyle(.green)
                            
                        }
                        .padding()
                        .background(.green.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        Spacer()
                        
                        VStack(alignment:.leading){
                            Text("Protein")
                                .font(.headline)
                                .foregroundStyle(.orange)
                            
                            Text(scanVM.calorie?.protein ?? "")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(.orange)
                            Text("gram")
                                .font(.caption)
                                .foregroundStyle(.orange)
                            
                        }
                        .padding()
                        .background(.orange.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        Spacer()
                        VStack(alignment:.leading){
                            Text("Carbon")
                                .font(.headline)
                                .foregroundStyle(.blue)
                            
                            Text(scanVM.calorie?.carbon ?? "")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundStyle(.blue)
                            Text("gram")
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                        .padding()
                        .background(.blue.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }
                    .padding(10)
                    
                    .overlay {
                        RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.1))
                    }
                    
                }
            }
            
            
            Spacer()
            Button {
                showCamera.toggle()
                
            } label: {
                if scanVM.isLoading {
                    LoadingIndicator()
                } else {
                    Text("Scan Food")
                }
            }
            .frame(width: 300, height: 30)
            .foregroundColor(.green)
            .font(.system(size: 22, weight: .semibold))
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(20)
        }
        .fullScreenCover(isPresented: $showCamera, onDismiss: {
            Task {
                if let selectedImage {
                    await scanVM.getCalorie(image: selectedImage)
                }
            }
        }) {
            AccessCameraView(selectedImage: $selectedImage)
        }
        
        .padding()
        
    }
}

#Preview {
    ScanView()
}

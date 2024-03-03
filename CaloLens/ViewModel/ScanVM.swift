//
//  ScanVM.swift
//  CaloLens
//
//  Created by Riza Adi Kurniawan on 02/03/24.
//

import Foundation
import GoogleGenerativeAI
import UIKit

@MainActor
class ScanVM: ObservableObject {
    private var geminiModel: GenerativeModel
    @Published var calorie: Calorie?
    @Published var isLoading: Bool = false
    
    
    init() {
        let geminiKey = ProcessInfo.processInfo.environment["GEMINI_KEY"] ?? ""
        self.geminiModel = GenerativeModel(name: "gemini-pro-vision", apiKey: geminiKey)
    }
    
    func getCalorie(image: UIImage) async {
        isLoading = true
        
        do {
            let response = try await geminiModel.generateContent(Constant.prompt, image)
            
            guard let text = response.text, let data = text.data(using: .utf8) else {
                print("Unable to extract data")
                return
            }
            
            let calorie = try JSONDecoder().decode(Calorie.self, from: data)
            self.calorie = calorie
            isLoading = false
        } catch {
            print("ERROR fetching calorie \(error.localizedDescription)")
            isLoading = false
        }
    }
}

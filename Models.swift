//
//  Quiz.swift
//  Quiz
//
//  Created by Robert Paul Mitrulescu on 17.08.2025.
//


import Foundation

// Modelul care reflectă schema JSON-ului tău.
// Cheile corespund exact cu cele din fișier: chapter, questions, etc.
struct Quiz: Decodable, Identifiable {
    let id = UUID()
    let chapter: String
    let questions: [Question]
}

struct Question: Decodable, Identifiable {
    let id: Int
    let type: String
    let prompt: String
    let options: [String]
    let correctIndex: Int
    // "correctLetter" e opțional și nefolosit în rulare, dar îl acceptăm dacă există
    let correctLetter: String?

    // Facem cheia opțională
    private enum CodingKeys: String, CodingKey {
        case id, type, prompt, options, correctIndex, correctLetter
    }
}

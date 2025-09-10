//
//  QuizSession.swift
//  Quiz
//
//  Created by Robert Paul Mitrulescu on 17.08.2025.
//


import Foundation

/// Gestionează starea unui test pentru UN singur capitol (Quiz).
final class QuizSession: ObservableObject {
    let quiz: Quiz

    @Published private(set) var currentIndex: Int = 0
    @Published private(set) var score: Int = 0
    @Published var hasAnswered: Bool = false
    @Published var selectedIndex: Int? = nil
    @Published var isFinished: Bool = false

    var currentQuestion: Question { quiz.questions[currentIndex] }
    var progressText: String { "Întrebarea \(currentIndex + 1) / \(quiz.questions.count)" }

    init(quiz: Quiz) {
        self.quiz = quiz
    }

    /// Apelează când utilizatorul selectează un răspuns.
    func selectAnswer(_ index: Int) {
        guard !hasAnswered else { return }
        selectedIndex = index
        hasAnswered = true
        if index == currentQuestion.correctIndex {
            score += 1
        }
    }

    /// Treci la următoarea întrebare sau finalizezi testul.
    func goNext() {
        guard hasAnswered else { return }
        if currentIndex + 1 < quiz.questions.count {
            currentIndex += 1
            hasAnswered = false
            selectedIndex = nil
        } else {
            isFinished = true
        }
    }

    func restart() {
        currentIndex = 0
        score = 0
        hasAnswered = false
        selectedIndex = nil
        isFinished = false
    }
}

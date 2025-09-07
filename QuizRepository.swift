import Foundation

/// Încărcătorul tuturor fișierelor quiz_*.json din bundle.
/// -> Modular: dacă pui un fișier nou în proiect (ex: quiz_cap3.json), se încarcă automat.
final class QuizRepository {
    static let shared = QuizRepository()

    private init() {}

    /// Încarcă TOATE fișierele JSON care încep cu "quiz_" din bundle.
    func loadAllQuizzes() -> [Quiz] {
        // 1) Găsim toate fișierele .json din bundle
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil) else {
            print("Nu am găsit fișiere JSON în bundle.")
            return []
        }

        // 2) Păstrăm doar cele cu prefix "quiz_"
        let quizURLs = urls.filter { $0.lastPathComponent.lowercased().hasPrefix("quiz_") }

        // 3) Le decodăm pe rând
        var quizzes: [Quiz] = []
        let decoder = JSONDecoder()

        for url in quizURLs {
            do {
                let data = try Data(contentsOf: url)
                let quiz = try decoder.decode(Quiz.self, from: data)
                quizzes.append(quiz)
            } catch {
                print("Eroare la decodarea \(url.lastPathComponent): \(error)")
            }
        }

        // Sort opțional: după nume capitol (ca să apară ordonat)
        return quizzes.sorted(by: { $0.chapter.localizedCaseInsensitiveCompare($1.chapter) == .orderedAscending })
    }
}

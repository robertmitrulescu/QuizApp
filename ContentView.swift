import SwiftUI

struct ContentView: View {
    @State private var quizzes: [Quiz] = []

    var body: some View {
        NavigationStack {
            List {
                Section {
                    if quizzes.isEmpty {
                        // Mesaj util când nu există JSON-uri
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nu am găsit niciun fișier de quiz.")
                                .font(.headline)
                            Text("Adaugă fișiere în proiect cu nume de forma ")
                            + Text("quiz_*.json").bold()
                            + Text(" (ex: ")
                            + Text("quiz_cap1.json").italic()
                            + Text(").")
                        }
                        .padding(.vertical, 12)
                    } else {
                        ForEach(quizzes) { quiz in
                            NavigationLink(quiz.chapter) {
                                QuizView(session: QuizSession(quiz: quiz))
                            }
                        }
                    }
                } header: {
                    Text("Capitole disponibile")
                }

                Section("Cum adaugi un JSON nou") {
                    Text("1) Pune un fișier nou în proiect cu prefixul ")
                        + Text("quiz_").bold()
                        + Text(" (ex: quiz_cap2.json)\n2) Bifează „Target Membership” pentru aplicație.\n3) Rulează – se încarcă automat.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Quiz – Capitole")
            .onAppear {
                // Încărcăm din bundle la fiecare apariție (simplu pentru demo)
                quizzes = QuizRepository.shared.loadAllQuizzes()
            }
        }
    }
}

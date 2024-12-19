//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by wahid tariq on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US"
    ].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    
    @State private var score: Int = 0
    @State private var questionAnswered: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            content
        }
    }
    
    private var content: some View {
        VStack {
            Spacer()
            Text("Guess the Flag")
                .font(.title.weight(.bold))
                .foregroundStyle(.white)
            Spacer()
            Spacer()
            Text("Score: \(score)")
                .foregroundStyle(.white)
                .font(.title.bold())
            Spacer()

            VStack(spacing: 15) {
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.secondary)

                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding()
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        guard questionAnswered < 8 else {
            scoreTitle = "Game Over! Your final score is: \(score)"
            score = 0
            showingScore = true
            return
        }
        questionAnswered += 1
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct! your score is: \(score)"
        } else {
            score -= 1
            scoreTitle = "Wrong! your score is: \(score)"
            alertMessage = "That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
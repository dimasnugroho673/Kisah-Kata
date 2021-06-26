//
//  QuestionBank.swift
//  MC2-KisahKata
//
//  Created by Mulazi Azi on 26/06/21.
//

import Foundation
class QuestionBank {
    var list = [Question] ()
    
    init() {
        list.append(Question(image: "tomat.jpg", questionText: "Benda apakah ini", choiceA: "Apel", choiceB: "Tomat", choiceC: "Pisang", choiceD: "Mangga", answer: 4, jawaban: "Mangga"))
        list.append(Question(image: "kangkung.jpg", questionText: "Benda apakah ini", choiceA: "Kangkung", choiceB: "Tomat", choiceC: "Pisang", choiceD: "Mangga", answer: 1, jawaban: "Mangga"))
        list.append(Question(image: "rumput.jpg", questionText: "Benda apakah ini", choiceA: "Apel", choiceB: "Tomat", choiceC: "Rumput", choiceD: "Mangga", answer: 3, jawaban: "Mangga"))
        list.append(Question(image: "brokoli.jpg", questionText: "Benda apakah ini", choiceA: "Apel", choiceB: "Tomat", choiceC: "Pisang", choiceD: "Brokoli", answer: 4, jawaban: "Mangga"))
        list.append(Question(image: "wortel.jpg", questionText: "Benda apakah ini", choiceA: "Wortel", choiceB: "Tomat", choiceC: "Pisang", choiceD: "Mangga", answer: 1, jawaban: "Mangga"))
    }
}

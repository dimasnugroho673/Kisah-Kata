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
            list.append(Question(image: "sibi_yatim.mp4", questionText: "Apa kata dari video isyarat diatas ?", choiceA: "Tampan", choiceB: "Berjalan", choiceC: "Membaca", choiceD: "Yatim", answer: 4, jawaban: "Yatim"))
            list.append(Question(image: "sibi_tampan.mp4", questionText: "Apa kata dari video isyarat diatas ?", choiceA: "Tampan", choiceB: "Yatim", choiceC: "Bertani", choiceD: "Kering", answer: 1, jawaban: "Tampan"))
            list.append(Question(image: "sibi_kering.mp4", questionText: "Apa kata dari video isyarat diatas ?", choiceA: "Berjalan", choiceB: "Membaca", choiceC: "Kering", choiceD: "Yatim", answer: 3, jawaban: "Kering"))
            list.append(Question(image: "sibi_bertani.mp4", questionText: "Apa kata dari video isyarat diatas ?", choiceA: "Yatim", choiceB: "Tampan", choiceC: "Berjalan", choiceD: "Bertani", answer: 4, jawaban: "Bertani"))
            list.append(Question(image: "sibi_memancing.mp4", questionText: "Apa kata dari video isyarat diatas ?", choiceA: "Memancing", choiceB: "Membaca", choiceC: "Yatim", choiceD: "Berjalan", answer: 1, jawaban: "Memancing"))
        }
}

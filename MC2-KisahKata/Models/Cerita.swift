//
//  Cerita.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 20/07/21.
//

import Foundation

struct Cerita {
    var objectArray = [
        TemaModel(
            Urutan: "Tema 1",
            Tema: "Perkenalan Diri",
            ImageTema: "M-Eggy-Hello",
            ListJudul: [
                JudulModel(Judul: "Perkenalan", Score: "⭐️⭐️⭐️⭐️"),
                JudulModel(Judul: "Hobi", Score: "⭐️⭐️"),
                JudulModel(Judul: "Cita-Cita", Score: "🔒")
            ]
        ),
        TemaModel(
            Urutan: "Tema 2",
            Tema: "Keluarga",
            ImageTema: "M-Eggy-Hello",
            ListJudul: [
                JudulModel(Judul: "Kakak", Score: "⭐️⭐️⭐️⭐️⭐️"),
                JudulModel(Judul: "Adik", Score: "⭐️⭐️⭐️"),
                JudulModel(Judul: "Orang Tua", Score: "🔒")
            ]
        )
    
    ]
}

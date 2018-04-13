//
//  ViewController.swift
//  AglyEwok
//
//  Created by YevhenHerasymenko on 4/13/18.
//  Copyright © 2018 AglyEwok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sendMessage(_ sender: Any) {
        guard let text = textView.text, !text.isEmpty else {
            return
        }
        let request = API.sendDiscord(with: text)
        APIManager().objectRequest(request) { (result) in
            print(result)
        }
    }

    @IBAction func sendMessageTelegram(_ sender: Any) {
        guard let text = textView.text, !text.isEmpty else {
            return
        }
        let request = API.sendTelegramm(with: text)
        APIManager().objectRequest(request) { (result) in
            print(result)
        }
    }

    @IBAction func rancor(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let date = formatter.string(from: Date())
        textView.text = """
        🔔 РАСПИСАНИЕ РЕЙДОВ 🔔

        🔵 ЯМА

        🔹Сегодня  \(date) запущен ранк 🐽
        🔹Первые сутки 0 урона
        Минимальный урон wanderer
        🔹12.04начинаем бить в 19:30.
        ❗️Выход с уроном не раньше 19:35
        ‼️Солисты выходят не раньше 19:45
"""
    }
}


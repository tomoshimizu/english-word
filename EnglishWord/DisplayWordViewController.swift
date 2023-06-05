//
//  DisplayWordViewController.swift
//  EnglishWord
//
//  Created by Tomo Shimizu on 2022/12/30.
//

import UIKit

struct Word {
    var english: String
    var japanese: String?
}

class DisplayWordViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var englishWordLabel: UILabel!
    @IBOutlet weak var japaneseWordLabel: UILabel!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var notRememberBtn: UIButton!
    
    var words: [Word] = []
    var rememberedWords: [Word] = []
    var notRememberedWords: [Word] = []
    
    var currentIndex = 0
    var wordLevel = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "英単語学習"
        
        setupLayout()
        start()
    }
    
    @IBAction func onTapRememberBtn(_ sender: Any) {
        rememberedWords.append(words[currentIndex])
        showNext()
    }
    
    @IBAction func onTapNotRemeberBtn(_ sender: Any) {
        notRememberedWords.append(words[currentIndex])
        showNext()
    }
    
    @objc func dispJapaneseWord(sender: UITapGestureRecognizer) {
        japaneseWordLabel.isHidden = false
        
        if let japaneseWord = words[currentIndex].japanese {
            japaneseWordLabel.text = japaneseWord
        } else {
            japaneseWordLabel.text = "不明"
        }
    }
    
    func dispEnglishWord() {
        englishWordLabel.text = words[currentIndex].english
        japaneseWordLabel.isHidden = true
        progressView.setProgress(progressView.progress + 0.2, animated: true)
    }
    
    func showNext() {
        if currentIndex >= words.count - 1 {
            showResult()
        } else {
            currentIndex += 1
            dispEnglishWord()
        }
    }
    
    func showResult() {
        let alertController: UIAlertController = UIAlertController(title: "結果",
                                                                   message: "\(words.count)問中\(rememberedWords.count)問覚えた！",
                                                                   preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "覚えていない単語だけ復習する", style: .default) { _ in
            let newWords = self.notRememberedWords
            self.reset()
            self.start(words: newWords)
        }
        let action2 = UIAlertAction(title: "はじめからやり直す", style: .default) { _ in
            self.reset()
            self.start()
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        present(alertController, animated: true)
    }
    
    func start(words: [Word]? = nil) {
        if let words = words {
            self.words = words
        } else {
            setupWords()
        }
        
        dispEnglishWord()
    }
    
    func reset() {
        rememberedWords.removeAll()
        notRememberedWords.removeAll()
        currentIndex = 0
        progressView.setProgress(0, animated: true)
    }
    
    func setupWords() {
        switch wordLevel {
        case 1:
            words = [
                Word(english: "write", japanese: "書く"),
                Word(english: "go", japanese: nil),
                Word(english: "price", japanese: "価格"),
                Word(english: "cheap", japanese: nil),
                Word(english: "shop", japanese: "店"),
            ]
        case 2:
            words = [
                Word(english: "actually", japanese: "実際に"),
                Word(english: "again", japanese: "また"),
                Word(english: "already", japanese: nil),
                Word(english: "also", japanese: "また"),
                Word(english: "always", japanese: "いつも"),
            ]
        case 3:
            words = [
                Word(english: "custom", japanese: "慣習"),
                Word(english: "dirty", japanese: nil),
                Word(english: "disturb", japanese: "邪魔する"),
                Word(english: "electric", japanese: "電気"),
                Word(english: "empty", japanese: "空っぽな"),
            ]
        default:
            words = [
                Word(english: "write", japanese: "書く"),
                Word(english: "go", japanese: nil),
                Word(english: "price", japanese: "価格"),
                Word(english: "cheap", japanese: nil),
                Word(english: "shop", japanese: "店"),
            ]
        }
    }
    
    func setupLayout() {
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.cornerRadius = 10
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(dispJapaneseWord(sender:))))
        
        rememberBtn.layer.cornerRadius = 50
        notRememberBtn.layer.cornerRadius = 50
    }
}


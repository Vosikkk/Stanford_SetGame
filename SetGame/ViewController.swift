//
//  ViewController.swift
//  SetGame
//
//  Created by Саша Восколович on 06.08.2023.
//

import UIKit

class ViewController: UIViewController {

    private var game = SetGame()
    
    @IBOutlet var cardsButton: [SetCardButton]! {
        didSet {
               for button in cardsButton {
                button.strokeWidths = strokeWidths
                button.colors = colors
                button.alphas = alphas
            }
        }
    }
       
    // Outlets for various UI elements
    @IBOutlet weak var dealButton: BorderButton!
    
    @IBOutlet weak var newGameButton: BorderButton!
    
    @IBOutlet weak var hintButton: BorderButton!
    
    @IBOutlet weak var deckLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
   
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Variables for button configurations
    private var colors = [#colorLiteral(red: 1, green: 0.4163245823, blue: 0, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)]
    private var strokeWidths: [CGFloat] = [ -10, 10, -10]
    private var alphas: [CGFloat] = [1.0, 0.60, 0.15]
    private weak var timer: Timer?
    private var lastHint = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

    // Function to update card buttons appearance based on the game model
    private func updateButtonsFromModel() {
         infoLabel.text = ""
        
         for index in cardsButton.indices {
             let button = cardsButton[index]
             if index < game.cardsOnTheTable.count {
                
                 let card = game.cardsOnTheTable[index]
                 button.setCard = card
                 //Selected
                 button.setBorderColor(color:
                     game.selectedCards.contains(card) ? BorderColorsFor.selected : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
                 //TryMatched
                 if let isItSet = game.isSet {
                     if game.tryMatchedCards.contains(card) {
                         button.setBorderColor(color:
                             isItSet ? BorderColorsFor.matched : BorderColorsFor.missMatched)
                     }
                    infoLabel.text = isItSet ? "Set" : "Not Set"
                 }
                
             } else {
                 button.setCard = nil
             }
         }
     }
    
    // Function to update the entire view based on the game model
    private func updateViewFromModel() {
        updateButtonsFromModel()
        updateHintButton()
        deckLabel.text = "Deck: \(game.deckCount)"
        scoreLabel.text = "Score: \(game.score)"
        
        //We can't add cards on the table when all screen filled by cards or deck is empty, so button doesn't work)
        dealButton.disable = (game.cardsOnTheTable.count) >= cardsButton.count || game.deckCount == 0
        
        // We don't have any tips between cards on the table
        hintButton.disable = game.hints.count == 0

    }
    
    // Function to update the hint button based on available hints
    private func updateHintButton() {
        hintButton.setTitle("\(game.hints.count) sets", for: .normal)
        lastHint = 0
    }
    
    // Action for dealing 3 more cards
    @IBAction func deal3() {
        // Because we can't add three cards, screen is full)
        if game.cardsOnTheTable.count + 3 <= cardsButton.count {
            game.deal3()
            updateViewFromModel()
        }
    }
    
    // Action when a card button is touched
    @IBAction func touchCard(_ sender: SetCardButton) {
        if let cardNumber = cardsButton.firstIndex(of: sender) {
            // Check cards, received apperiance from model, maybe it's set or something else
            game.chooseCard(at: cardNumber)
            
            // Show new screen
            updateViewFromModel()
        } else {
            print("chosen card wad not in cardButtons")
        }
    }
    
    
    // Action for requesting a hint
    @IBAction func hint() {
        timer?.invalidate()
        if game.hints.count > 0 {
            game.hints[lastHint].forEach{ (index) in
                // Find buttons which are set
                let button = self.cardsButton[index]
                // Change bordercolor
                button.setBorderColor(color: BorderColorsFor.hint)
            }
            // Wait a little bit
            infoLabel.text = "Set \(lastHint + 1) Wait.."
            
            timer = Timer.scheduledTimer(withTimeInterval: Constant.flashTime, repeats: false) { [weak self] time in
                
                // For each index in the hint, remove the border color from the corresponding card button
                self?.game.hints[(self?.lastHint)!].forEach{ index in
                    let button = self?.cardsButton[index]
                    button!.setBorderColor(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
                }
                // Move to the next hint (in a circular manner)
                self?.lastHint = (self?.lastHint)!.incrementCicle(in:(self?.game.hints.count)!)
                self?.infoLabel.text = ""
               
                // Update the card button appearance based on the model
                self?.updateButtonsFromModel()
            }
            
        }
    }
    
    // Action for starting a new game
    @IBAction func newGame() {
        game = SetGame()
        cardsButton.forEach{ $0.setCard = nil }
        updateViewFromModel()
    }
    
    // Struct for holding constants
    private struct Constant {
        static let flashTime = 1.5
    }
    
    // Struct for defining border colors based on different situations
    private struct BorderColorsFor {
           static let hint = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
           static let selected = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
           static let matched = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
           static var missMatched = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       }
       
    
}


//
//  SetCardButton.swift
//  SetGame
//
//  Created by Саша Восколович on 06.08.2023.
//

import Foundation
import UIKit

class SetCardButton: BorderButton {
   
    var colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    var alphas: [CGFloat] = [1.0, 0.40, 0.15]
    var strokeWidths: [CGFloat] = [ -8, 8, -8]
    var symbols = ["●", "▲", "■"]
    
    // Represents a SetCard instance associated with the button
    var setCard: SetCard? = SetCard(number: SetCard.Variant.v3,
                                    color: SetCard.Variant.v3,
                                    shape: SetCard.Variant.v3,
                                    fill: SetCard.Variant.v3) {
            didSet {
                updateButton()
            }
    }
    
    // Computed property to get vertical size class of the UI
    private var verticalSizeClass: UIUserInterfaceSizeClass {
        return UIScreen.main.traitCollection.verticalSizeClass
    }
    
    // MARK: Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    
    // Updates button appearance when the UI size class changes
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateButton()
    }


    // Creates an attributed string for a given SetCard
    private func setAttributedString(card: SetCard) -> NSAttributedString { 
        //-------- symbols: number & shape -------
        let symbol = symbols[card.shape.index]
        let separator = verticalSizeClass == .regular ? "\n" : " "
        let symbolsString = symbol.join(n: card.number.rawValue, with: separator)
        //------ attributes: color & fill-------
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: colors[card.color.index],
            .strokeWidth: strokeWidths[card.fill.index],
            .foregroundColor: colors[card.color.index].withAlphaComponent(alphas[card.fill.index])
        ]
        return NSAttributedString(string: symbolsString, attributes: attributes)
    }
    
    
    // Updates the appearance of the button based on the setCard property
    private func updateButton () {
        if let card = setCard {
            // Update button title with attributed string
            let attributedString = setAttributedString(card: card)
            
            // Configure other button properties
            setAttributedTitle(attributedString, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            isEnabled = true
        } else {
            // Reset button properties when no setCard
            setAttributedTitle(nil, for: .normal)
            setTitle("", for: .normal)
            
            // Configure other button properties
            backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            isEnabled = false
            
        }
    }
    
    // Sets the border color of the button
    func setBorderColor(color: UIColor) {
        borderColor = color
        borderWidth = Constants.borderWidth
    }
    
    // Initial configuration of the button's appearance
    private func configure () {
        titleLabel?.numberOfLines = 0
        cornerRadius = Constants.cornerRadius
        borderColor = Constants.borderColor
        borderWidth = -Constants.borderWidth
    }
    
    // Constants for configuring appearance
    private struct Constants {
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 5.0
        static let borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
}


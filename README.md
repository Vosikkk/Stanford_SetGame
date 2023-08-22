# Stanford_SetGame
## Solo Set Game

### Description

This iOS application is a solo version of the Set card game, designed for one player. The game adheres to the specified requirements and offers an enjoyable and challenging experience. Here are the key features and design considerations:

### Features

1. **Solo Set Game**: This application allows a single player to enjoy a game of Set, a card matching game.

2. **Card Capacity**: The game can display at least 24 Set cards on the screen simultaneously.

3. **Initial Deal**: When the game starts, it deals 12 cards to the player. These cards are randomly placed on the screen without overlapping.

4. **Deal 3 More Cards**: A "Deal 3 More Cards" button is provided, allowing the player to add three more cards to the game. This follows the rules of Set.

5. **Card Selection**: Players can select cards by tapping on them. The UI provides visual feedback to indicate card selection.

6. **Deselection**: The game supports card deselection. If one or two cards are selected, tapping a third card will deselect the previous selections.

7. **Matching Evaluation**: After selecting three cards, the game evaluates whether they form a valid Set. This evaluation is visually indicated, making it clear to the player whether the selected cards match or not.

8. **Card Management**: If three matching cards are selected, they are replaced with new cards from the deck of 81 Set cards. If the deck is empty, matched cards are hidden in the UI. If one of the selected cards was part of the match, no card is selected to ensure gameplay consistency.

9. **Dynamic Button State**: The "Deal 3 More Cards" button is disabled when there are no more cards in the Set deck or when there isn't enough space on the screen for three additional cards.

10. **Card Rendering**: Instead of traditional card graphics, the game uses NSAttributedString to display Set cards using the characters ▲ ● ■. Attributes are used to represent colors and shading.

11. **Closures**: A closure is used as a meaningful part of the solution to handle card selection and matching evaluation.

12. **Enums**: Enums are used to represent different aspects of the game logic.

13. **Extensions**: Sensible extensions to data structures are used as part of the solution to enhance code modularity and readability.

14. **Autolayout and Stack Views**: The UI is well laid out and adapts to different iPhone 7 or later devices, including portrait and landscape orientations. Stack views are employed for efficient layout management.

15. **Scoring System**: The game includes a scoring system where players earn points for matches, lose points for mismatches, and possibly receive fewer points as more cards are added to the game.

16. **New Game Button**: A "New Game" button is provided to start a fresh game, and the player's score is displayed in the UI.

Enjoy playing Solo Set and challenge your matching skills!

### Getting Started

[Provide instructions on how to clone the repository and run the game on a local development environment.]

### Technologies Used

- Swift
- UIKit
- Autolayout
- NSAttributedString
- Closures
- Enums
- Extensions
- Git

### Acknowledgments

This project was created in fulfillment of Assignment II and follows the specified requirements.



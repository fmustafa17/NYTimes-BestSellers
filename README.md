# NYTimes-BestSellers

Displays the NYTimes Best Sellers books in a iOS application made with UIKit. 

- Uses UITableView and UICollectionViewCell for scrolling through books horizontally
- Demonstrates grabbing API's response through Combine and Async Await

# How to add your developer keys
In order to not expose our sensitive data, I've created a file called Config.swift that holds my API key. This config file is then added to the .gitignore file. If you do accidently commit and push sensitive data to your repo, consider it compromised and generate a new API key.

How to replicate the config file:

```swift
import Foundation

enum Config: String {
    case apiKey = "Your API Key here"
}
```

# Screenshots
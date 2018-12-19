# iMarvel

This is a project to create a simple app to search Marvel characters

## 🚨 Important note 🚨

This project is using cocoapods. Please be sure to run the **pod install** command before running the project.

If you have any doubt about cocoapods you can check the reference [here](https://cocoapods.org).

## Project Architecture 
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/projectArchitecture.jpeg?raw=true)

References:
* [Viper architecture](https://www.objc.io/issues/13-architecture/viper/)
* [Viper for iOS](https://medium.com/@smalam119/viper-design-pattern-for-ios-application-development-7a9703902af6)

## How did I implement VIPER?

Basically I have a protocol file for each scene in the app. This file defines the interaction between each layer as following:

* View - Presenter: protocols to notify changes and to inject information to the UI.
* Presenter - Interactor: protocols to request / receive information to / from the interator.
* Presenter - Router: protocol to define the transitions between scenes (I skiped this protocols for the demo because I have only a scene there).

Whith this protocols file is really easy to know how each layer notify / request / information to the other ones so we don't have any other way to communicate all the layers.

Another important point is because I'm using protocols it's really easy to define mocks views / presenters / interactors / routers for testing.

```swift
// View / Presenter
protocol CharactersListViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func loadCharacters(_ viewModels: [CharactersListViewModel], totalResults: Int, copyright: String?, fromBeginning: Bool, allCharactersLoaded: Bool)
    func loadSuggestions(_ suggestions: [SuggestionViewModel])
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol CharactersListPresenterDelegate : class {
    func viewDidLoad()
    func searchCharacter(_ character: String)
    func loadNextPage()
    func getSuggestions()
    func suggestionSelectedAt(index: Int)
    func showCharacterDetailAt(index: Int)
    func refreshResults()
}

// Presenter / Interactor
typealias CharactersListGetCharactersCompletionBlock = (_ viewModel: [CharactersListViewModel]?, _ total: Int, _ copyright: String?, _ success: Bool, _ error: ResultError?, _ allCharactersSync: Bool) -> Void
typealias CharactersListGetSuggestionsCompletionBlock = ([SuggestionViewModel]) -> Void

protocol CharactersListInteractorDelegate : class {
    func shouldGetCharacters() -> Bool
    func clearSearch()
    func getCharactersWith(character: String?, completion: @escaping CharactersListGetCharactersCompletionBlock)
    func saveSearch(_ search: String)
    func getAllSuggestions(completion: @escaping CharactersListGetSuggestionsCompletionBlock)
    func getSuggestionAt(index: Int) -> SuggestionViewModel?
    func getCurrentSearchCharacter() -> String?
    func updateSearchCharacter(_ searchCharacter: String)
    func getCharacterAt(index: Int) -> CharactersListViewModel?
}

// Presenter / Router
protocol CharactersListRouterDelegate : class {
    func showDetail(_ character: CharactersListViewModel)
}
```

## First at all. Where is the data came from?

## Data models

### Network data models

These includes the following models:


I'm using a Swift Standard Library decodable functionality in order to manage a type that can decode itself from an external representation (I really ❤ this from Swift).

**Why some properties are optionals?**

**Are more properties there??**

Reference: [Apple documentation](https://developer.apple.com/documentation/swift/swift_standard_library/encoding_decoding_and_serialization)


### Suggestions data model

This model is used for the characters suggestions (last 10​ ​successful​ ​queries​ - exclude​ ​suggestions​ ​that​ ​return​ ​errors)

```swift
class IMSearchSuggestion: Object {
    @objc dynamic var suggestionId: String?
    @objc dynamic var suggestion: String = ""
    @objc dynamic var timestamp: TimeInterval = NSDate().timeIntervalSince1970
    
    override class func primaryKey() -> String? {
        return "suggestionId"
    }
}
```

As I'm using Realm for this it's important to define a class to manage each model in the database. In this case we only have one model (SearchSuggestion)

Reference: [Realm](https://realm.io/docs/swift/latest)

### Managers

## How it looks like?

### Character list results
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/01.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/07.png?raw=true)

### Character detail
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/02.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/03.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/08.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/05.png?raw=true)

### Handling errors and states
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/10.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/09.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/04.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMarvel/blob/master/Images/06.png?raw=true)

## What's left in the demo?

* Realm migration process: It would be nice to add a process to migrate the realm database to a new model (just in case you need to add a new field into the database)
* Localizable files: This demo doesn't include the localizable files to translate the app to different languages.


## Programming languages && Development tools

* Swift 4.2
* Xcode 10.1
* [Cocoapods](https://cocoapods.org) 1.5.3
* Minimun iOS version: 12.1

## Third-Party Libraries

* [Haneke](https://github.com/Haneke/Haneke) (1.0): A lightweight zero-config image cache for iOS
* [RealmSwift](https://github.com/realm/realm-cocoa) (3.7.6): A mobile database that runs directly inside phones, tablets or wearables
* [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) (2.2.5): A clean and lightweight progress HUD for your iOS and tvOS app.

## Support && contact

### Email

You can contact me using my email: ricardo.casanova@outlook.com

### Twitter

Follow me [@rcasanovan](http://twitter.com/rcasanovan) on twitter.
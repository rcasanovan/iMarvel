# iMarvel

This is a project to create a simple app to search Marvel characters

## 🚨 Important note 🚨

This project is using cocoapods. Please be sure to run the **pod install** command before running the project.

If you have any doubt about cocoapods you can check the reference [here](https://cocoapods.org).

To run the project you just need to add your API & private keys in EndPoint swift file

```swift
static let apiKey: String = "ADD YOUR API KEY HERE"
    static let privateKey: String = "ADD YOUR PRIVATE KEY HERE"
```

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

I'm using the api from **Marvel** (you can check the api documentation [here](https://developer.marvel.com/)).

You just need to create an account to have access to the api. Once you do it you'll able to get information for characters in a JSON format.

## Data models

### Network data models

#### Character list data models

```swift
public struct CharactersResponse: Decodable {
    
    let copyright: String
    let attributionText: String
    let data: DataResponse
    
}

public struct DataResponse: Decodable {
    
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterResponse]
    
}

public struct CharacterResponse: Decodable {
    
    let id: Int32
    let name: String
    let description: String
    let modified: String
    let thumbnail: ThumbnailResponse
    let comics: ParticipationResponse
    let series: ParticipationResponse
    let stories: ParticipationResponse
    let events: ParticipationResponse
    
}

public struct ThumbnailResponse: Decodable {
    
    let path: String
    let ext: String

    //__ This is little trick.
    //__ The "thumbnail" field has another field inside called "extension"
    //__ The problem is we can't process this field using Swift
    //__ so we need to create an enum like a "bridge" to process the fields
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
    
}

public struct ParticipationResponse: Decodable {
    
    let available: Int
    
}
```

#### Character detail data models

```swift
public struct ComicsResponse: Decodable {
    
    let copyright: String
    let attributionText: String
    let data: ComicDataResponse
    
}

public struct ComicDataResponse: Decodable {
    
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [ComicResponse]
    
}

public struct ComicResponse: Decodable {
    
    let id: Int32
    let title: String
    let description: String?
    let thumbnail: ThumbnailResponse?
    let urls: [UrlResponse]?
    
}

public struct UrlResponse: Decodable {
    
    let type: String
    let url: String
    
}
```


I'm using a Swift Standard Library decodable functionality in order to manage a type that can decode itself from an external representation (I really ❤ this from Swift).

**Are more properties there??**

Obviously the response has more properties for each character. I decided to use only these ones.

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

## Managers

I think using managers is a good idea but be careful!. Please don't create managers as if the world were going to end tomorrow.

I'm using only 3 here:

### ImageManager

Used to manage the images (create the urls to retrieve the images)

### ReachabilityManager

Used to manage the reachability. In this case I would like to notify a little issue related with the simulator. *It seems Xcode has an issue with the simulator because if you try to turn off the wifi and turning on again, the observer for the state change is not triggering. It's working 100% fine in a real device*

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
* Limit the number of retries for the api calls: This demo doesn't include a limitation for the number of retries while the app is doing the api calls.

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
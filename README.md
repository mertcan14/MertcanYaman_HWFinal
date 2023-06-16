
# Song Box
This application is an application that uses iTunesAPI to take control of music. Music search, show the meaningful details searched and can play music. You can add it to your favorites and access it quickly later.

### Functional Features

✔️ Internet check with Alamofire when opening app and making request to API

✔️ If you do not type for half a second, automatic search is made

✔️ If the search process returns from the api successfully, it goes to the Detail Page, if not, it gives an Alert.

✔️ You can create your own PlayLists

✔️ You can listen to the music sequentially.

✔️ You don't need to be on the detail page to listen, keep listening anywhere

✔️ You can easily switch to the previous song or the next song


### This App Consists

✔️ VIPER Design Pattern

✔️ Auto Layout 

✔️ Core Data

✔️ AVFoundation

✔️ Package Dependencies: Alamofire(5.7.1)

✔️ Written Modules: MusicAPI, MyCoreData

✔️ Unit Test

✔️ UI Test
## API Usage

#### Get Data From Dictionary Api

```http
  GET https://itunes.apple.com/search?term={term}&country={country}&entity={entity} 
```

| Parametre | Tip     | Açıklama                |
| :-------- | :------- | :------------------------- |
| `term` | `string` | **required** Searched Term |
| `country` | `string` | Searched Term In Country |
| `entity` | `string` | Song, Movie, Podcast etc. |
  

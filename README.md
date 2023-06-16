
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

✔️ Package Dependencies: Alamofire, SDWebImage

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

## Video

https://github.com/mertcan14/MertcanYaman_HWFinal/assets/61551987/9ecbb33d-1f24-4e68-9c34-761a96aea021

**Youtube: ** https://youtu.be/xhpuQOrgXAs

## Screenshot
  
![1](https://github.com/mertcan14/MertcanYaman_HWFinal/assets/61551987/2cc68823-04d3-4b93-b458-b8315cb2c863)
![2](https://github.com/mertcan14/MertcanYaman_HWFinal/assets/61551987/d8cfe75e-5391-4cc2-a8ea-6def2549a5ce)
![3](https://github.com/mertcan14/MertcanYaman_HWFinal/assets/61551987/8aacc2be-72cc-4292-8189-38488ad7b850)


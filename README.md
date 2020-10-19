# AirQuality_RxSwift

- 顯示各地區目前空氣品質  
- 點擊顯示該地區其他監測資訊  
- 可切換至天氣預報  
***
#### 空氣品質來源：http://opendata2.epa.gov.tw/AQI.json  
#### 天氣預報來源：https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314  
***  
#### 程式架構  
- 使用 **MVVM** 架構搭配 **RxSwift**, **RxCocoa**, **RxDataSources**  
- 資料由 URLSession request 方式取得 Open data 資料，將取得到的 json format data 轉換成 Dictionary 後，由中間 ViewModel 轉成物件傳回 UI 使用  
- 利用 **Coordinator** 在各 ViewModel 間傳遞必要資料  
- 使用 **SwiftLint** 檢查 coding style 是否符合規範，並有簡易 unit test 檢查功能正確性  
<img src="https://drive.google.com/uc?export=view&id=1CyLMfpq5rwpZ7mdDGZp6-MsW0nNu7C05" width="800" alt="程式架構"></img>  
***  
#### 使用說明  
- App 開啟時預設顯示全台各地空氣品質資訊，點選該地區會跳出詳細內容  
- 點選下方 Location 按鈕可篩選顯示區域  
- 畫面右上方按鈕可切換至顯示天氣預報頁面，若剛才有篩選區域，在天氣預報頁面也會同時篩選  
- 在天氣預報頁面點選該地區會展開未來 18 小時天氣預報資訊  
  
#### UI 畫面  
<img src="https://drive.google.com/uc?export=view&id=1EQ2z0JkKNeuIrsr82My1x9lveBAOit8w" height="600" alt="空氣品質頁面"></img> <img src="https://drive.google.com/uc?export=view&id=19r5TlHePLMdGUoZfEunnDCGBNaYHMtwh" height="600" alt="詳細空氣品質資訊"></img>  
<img src="https://drive.google.com/uc?export=view&id=1Pzby3ihZej9Zxfgx5_MKwoOztGcGO9XP" height="600" alt="天氣預報頁面"></img> <img src="https://drive.google.com/uc?export=view&id=1Yz3VOzTFcmDXbedBpSQmmF_Kbh6NM0qx" height="600" alt="詳細天氣預報資訊"></img>  
<img src="https://drive.google.com/uc?export=view&id=1_bqInkX6BJyBacL6UfCHLQdzqMtTZ095" height="600" alt="選擇區域"></img>  

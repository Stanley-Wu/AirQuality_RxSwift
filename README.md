# AirQuality_RxSwift

．顯示各地區目前空氣品質  
．點擊顯示該地區其他監測資訊  
．可切換至天氣預報  
***
#### 空氣品質來源：http://opendata2.epa.gov.tw/AQI.json  
#### 天氣預報來源：https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314  
使用 MVVM 架構搭配 RxSwift  
資料由 URLSession request 方式取得 Open data 資料，將取得到的 json format data 轉換成 Dictionary 後，由中間 ViewModel 轉成物件傳回 UI 使用  
  
#### 程式架構  
<img src="https://drive.google.com/uc?export=view&id=1CyLMfpq5rwpZ7mdDGZp6-MsW0nNu7C05">
  
#### UI 畫面  
<img src="https://drive.google.com/uc?export=view&id=1EQ2z0JkKNeuIrsr82My1x9lveBAOit8w">  
<img src="https://drive.google.com/uc?export=view&id=19r5TlHePLMdGUoZfEunnDCGBNaYHMtwh">  
<img src="https://drive.google.com/uc?export=view&id=1Pzby3ihZej9Zxfgx5_MKwoOztGcGO9XP">  
<img src="https://drive.google.com/uc?export=view&id=1Yz3VOzTFcmDXbedBpSQmmF_Kbh6NM0qx">  
<img src="https://drive.google.com/uc?export=view&id=1_bqInkX6BJyBacL6UfCHLQdzqMtTZ095">  

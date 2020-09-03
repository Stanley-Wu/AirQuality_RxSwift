# AirQuality_RxSwift

．顯示各地區目前空氣品質  
．點擊顯示該地區其他監測資訊  
．可切換至天氣預報  
***
#### 空氣品質來源：http://opendata2.epa.gov.tw/AQI.json  
#### 天氣預報來源：https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314  
使用 URL request 方式取得 Open data 資料，將取得到的 json format data 轉換成 Dictionary 後，由中間 DataManager 轉成物件傳回 UI 使用  

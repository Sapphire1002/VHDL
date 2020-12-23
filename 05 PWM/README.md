## 專案進度報告
#### 本周進度
> 負責人: 何佳曄 \
> 目前成員: 何佳曄 \
> 報告日期: 2020.12.11 \
> 開始日期: 2020.12.04 \
> 結束日期: 

> 進度:  
> * 設計 PWM  
> 使用指撥開關設定邊界，並且用有限狀態機來控制兩個計數器的計數。
> 在第一個計數器數的時候 PWM 值為 1，另一個計數器數時值為 0 。
> 最後將結果接上七段顯示器呈現。 

> 實作部分:  
> * PWM 設計流程圖  
> ![PWM 設計流程圖](https://github.com/Sapphire1002/VHDL/blob/main/05%20PWM/PWM_Design_pic.jpg)  
> 流程圖說明  
> 方框: FPGA 電路  
> 箭頭: 輸出訊號  
> 菱形: 實際電路  

> * 接上共陽極七段顯示器及 LED 來觀測結果  
> [PWM 接上實際電路觀測結果](https://drive.google.com/file/d/10p-wDH7d7CSU7vLBOSTrHcUxHDYnIQqi/view?usp=sharing)  
> 影片說明:  
> LED 代表 PWM 的輸出，紅燈代表上數，黃燈代表下數。
> 另外使用 FPGA 板子上的指撥開關來控制邊界。  
> `影片一開始設定 0110，最後設定 0010 `

> 程式檔案名稱:  
> PWM.vhd  
> PWM.xdc

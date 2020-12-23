## 專案進度報告
#### 本周進度
> 負責人: 何佳曄 \
> 目前成員: 何佳曄 \
> 報告日期: 2020.12.18 \
> 開始日期: 2020.12.11 \
> 結束日期: 

> 進度:  
> * 設計 LED 乒乓球遊戲  
> 使用 LED 當成球在移位，以及兩個按鈕當成 PL1 & PL2，只要達到
> 一邊任意端點就必須在 1個 CLK 內按下該側按鈕。
> 若提早按或者太晚按都算失分，得分時發球權不變，反之換發。
> 最後比分結果由七段顯示器顯示。  

> 實作部分:  
> * 設計 LED 乒乓球遊戲流程圖  
> ![LED 乒乓球遊戲流程圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_programming_pic.jpg)  
> * LED 乒乓球遊戲 VHDL 狀態圖    
> ![LED 乒乓球遊戲狀態圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_led_pic.jpg)   
> 狀態圖說明:    
> 000: PL1 發球前的狀態  
> 001: PL2 發球前的狀態  
> 010: LED 右移  
> 011: LED 左移  
> 100: PL1 接到球  
> 101: PL2 接到球  
> 110: PL1 當前分數  
> 111: PL2 當前分數  
> btn1, btn2: 代表 PL1, PL2  `電路為正邏輯`  
> pos: 球的當前位置  

> * 接上實際電路觀測結果  
> [實際電路觀測結果](https://drive.google.com/file/d/17KoJ02tQW8P4xKnkNdryfAqvog-4ffQe/view?usp=sharing)   
> 影片說明:  
> 左邊的按鈕為 PL1， 右邊的按鈕為 PL2，左邊的七段為 PL1 分數，右邊的七段為 PL2 分數。  

> 問題討論:    
> 目前 LED 的部分不會移動，但是計分判斷和按鈕控制流程是正常功能  

> 程式檔案名稱:  
> pingpong_LED.vhd  
> pingpong_LED.xdc

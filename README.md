## 實驗室
#### **每周進度**
<details>
  <summary> Week 1 環境建置 </summary>
  日期: 2020.10.27 - 2020.10.30  
  
  專案資料夾: [00 pre_test](https://github.com/Sapphire1002/VHDL/tree/main/00%20pre_test "專案連結")  
  進度:  
  建置 Vivado 環境  
  查詢 VHDL 語法及資料  
  
</details>

<details>
  <summary> Week 2 VGA 螢幕掃描 </summary>
  日期: 2020.10.30 - 2020.11.06  
  
  專案資料夾: [01 video_out_screen_scan](https://github.com/Sapphire1002/VHDL/tree/main/01%20video_out_screen_scan "專案連結")  
  進度:  
  查詢 VHDL 語法及資料  
  了解螢幕掃描時間及程式設計流程  
  了解螢幕輸出RGB時的原理  
  完成螢幕掃描  
  
<details>
  <summary> 實作部分 </summary>
  
  * 了解螢幕掃描時間及程式設計流程  
  ![螢幕掃描流程圖](https://github.com/Sapphire1002/VHDL/blob/main/01%20video_out_screen_scan/%E8%9E%A2%E5%B9%95%E6%8E%83%E6%8F%8F%E6%B5%81%E7%A8%8B%E5%9C%96.PNG)  
  * 原本螢幕畫面  
  ![原本螢幕畫面](https://github.com/Sapphire1002/VHDL/blob/main/01%20video_out_screen_scan/1106_ori.jpg)  
  * 掃描後的螢幕畫面  
  ![掃描後的螢幕畫面](https://github.com/Sapphire1002/VHDL/blob/main/01%20video_out_screen_scan/1106_result.jpg)  
</details>  

<details>
  <summary> 問題討論 </summary>
  
  ![Q](https://github.com/Sapphire1002/VHDL/blob/main/01%20video_out_screen_scan/1106_q1.PNG)  
  - [x] 已解決  
        解決方式: 在 \*.xdc 檔案時脈的程式碼要加上 IOSTANDARD 並給電壓 LVCMOS33  
  - [ ] 未解決
</details> 
</details>

<details>
  <summary> Week 3 期中考 </summary>
  期中考週
</details>

<details>
  <summary> Week 4 VGA 螢幕上顯示圖形 </summary>
  日期: 2020.11.13 - 2020.11.20 
  
  專案資料夾: [02 video_out_graphics_move](https://github.com/Sapphire1002/VHDL/tree/main/02%20video_out_graphics_move "專案連結")  
  進度:  
  在 VGA 螢幕上顯示正方形、圓形、三角形  
  使螢幕上的圖形移動  
  
<details>
  <summary> 實作部分 </summary>
  
  * 顯示圖形  
  ![顯示圖形](https://github.com/Sapphire1002/VHDL/blob/main/02%20video_out_graphics_move/1120_Video_out_%E5%9C%96%E5%BD%A2.jpg)  
  [圖形移動影片](https://drive.google.com/file/d/1x19yr52etBxJ1drvSTe1m-OdFJPInAqK/view?usp=sharing)  
</details>

<details>
  <summary> 問題討論 </summary>  
  
  ![Q](https://github.com/Sapphire1002/VHDL/blob/main/02%20video_out_graphics_move/1120_video_out_que01.png)  
  - [x] 已解決  
        解決方式: 重新建立一個專案    
  - [ ] 未解決  
  * 三角形在一開始的地方會有問題  
  - [x] 已解決  
        解決方式: 利用數學的線性規劃來判斷點位於直線方程式哪邊      
  - [ ] 未解決   
  * 兩個 process() 傳值的方法  
  - [x] 已解決  
        解決方式:  
            1\. 宣告一個 signal, 類型為 std_logic_vector  
            2\. 在第二個 process 寫一個區域變數(variable)來接收傳入的值  
            3\. 在第二個 process 賦值給 第一步驟宣告的 signal  
            4\. 在第一個 process 接收值, 若要轉成十進制則使用(conv_integer(variable, bits))  
            `conv_integer() 需要有 ieee.std_logic_arith.all 檔案`  
  - [ ] 未解決  
</details>  
</details>

<details>
  <summary> Week 5 VGA 螢幕玩乒乓球遊戲 </summary>
  日期: 2020.11.20 - 2020.11.27  
  
  專案資料夾: [03 video_out_pingpong_vga](https://github.com/Sapphire1002/VHDL/tree/main/03%20video_out_pingpong_vga "專案連結")  
  進度:  
  使用 VGA 螢幕顯示且玩乒乓球遊戲  
  依據打擊的位置球往不同的方向飛   
  
<details>
  <summary> 實作部分 </summary>
  
  [乒乓球實作影片1](https://drive.google.com/file/d/1cx5e87o8t2VbzjyqEA-TgOCNKX9wB-Pk/view?usp=sharing)    
  [乒乓球實作影片2](https://drive.google.com/file/d/1H7-WLFPHP_LOq9tE38c5P5waZKvh8pJ7/view?usp=sharing)  
</details>

<details>
  <summary> 問題討論 </summary> 
  
  * 兩邊的檔板若超出邊界會直接消失並從另一端出現 
  - [ ] 已解決        
  - [x] 未解決  
</details>
</details>

<details>
  <summary> Week 6 LED/七段計數器 </summary>
  日期: 2020.11.27 - 2020.12.04  
  
  專案資料夾: [04 counter](https://github.com/Sapphire1002/VHDL/tree/main/04%20counter "專案連結")  
  進度:  
  計數器 0 ~ 9， 9 ~ 0  
  讓兩個計數器可自由設定上下限  
  計數的結果顯示在 LED 及 七段顯示器上  
  
<details>
  <summary> 實作部分 </summary>
  
  * 上數波形模擬    
  ![上數波形模擬](https://github.com/Sapphire1002/VHDL/blob/main/04%20counter/%E4%B8%8A%E6%95%B8%E8%A8%88%E6%95%B8%E5%99%A8(0_9%E6%B3%A2%E5%BD%A2).PNG)  
  * 下數波形模擬  
  ![下數波形模擬](https://github.com/Sapphire1002/VHDL/blob/main/04%20counter/%E4%B8%8B%E6%95%B8%E8%A8%88%E6%95%B8%E5%99%A8(9_0%20%E6%B3%A2%E5%BD%A2).PNG)  
  * 自定義計數器波形模擬  
  ![自定義計數器波形](https://github.com/Sapphire1002/VHDL/blob/main/04%20counter/%E8%87%AA%E5%AE%9A%E7%BE%A9%E8%A8%88%E6%95%B8%E5%99%A8(%E6%B3%A2%E5%BD%A2).PNG)  

  [LED 上數影片](https://drive.google.com/file/d/1h8_54hwukTBwddUCOMGQsIpPvyr5TOIP/view?usp=sharing)  
  [LED 下數影片](https://drive.google.com/file/d/1HvNs_3RmeN6pVpBwUH8IC6rxIaLaB1HN/view?usp=sharing)  
  影片說明:  
  影片中的 LED 最左邊為 8，最右邊為 1。 數字 9 則顯示 8 和 1，也就是會同時亮最左邊和最右邊
</details>

<details>
  <summary> 問題討論 </summary> 
  
  * 七段顯示器尚未研究怎麼使用
  - [x] 已解決  
        解決方式: FPGA 板子上的七段顯示器無法使用, 使用外接七段顯示器來處理        
  - [ ] 未解決 
</details>
</details>
  
<details> 
  <summary> Week 7 Pulse-width modulation(PWM) </summary>
  日期: 2020.12.04 - 2020.12.11   
  
  專案資料夾: [05 PWM](https://github.com/Sapphire1002/VHDL/tree/main/05%20PWM "專案連結")   
  進度:  
  設計 PWM  
  使用指撥開關設定邊界，並且用有限狀態機來控制兩個計數器的計數。 
  在第一個計數器數的時候 PWM 值為 1，另一個計數器數時值為 0 。  
  最後將結果接上七段顯示器呈現。 
  
<details>
  <summary> 實作部分 </summary>
  
  * PWM 設計流程圖  
  ![PWM 設計流程圖](https://github.com/Sapphire1002/VHDL/blob/main/05%20PWM/PWM_Design_pic.jpg)  
  流程圖說明  
  方框: FPGA 電路  
  箭頭: 輸出訊號  
  菱形: 實際電路  

  * 接上共陽極七段顯示器及 LED 來觀測結果  
  [PWM 接上實際電路觀測結果](https://drive.google.com/file/d/10p-wDH7d7CSU7vLBOSTrHcUxHDYnIQqi/view?usp=sharing)  
  影片說明:  
  LED 代表 PWM 的輸出，紅燈代表上數，黃燈代表下數。
  另外使用 FPGA 板子上的指撥開關來控制邊界。  
  `影片一開始設定 0110，最後設定 0010 `
</details> 
</details>
  
<details>
  <summary> Week 8 LED 乒乓球遊戲 </summary>
  日期: 2020.12.11 - 2020.12.18  
  
  專案資料夾: [06 pingpong_led](https://github.com/Sapphire1002/VHDL/tree/main/06%20pingpong_led "專案連結")  
  進度:  
  設計 LED 乒乓球遊戲    
  使用 LED 當成球在移位，以及兩個按鈕當成 PL1 & PL2，只要達到  
  一邊任意端點就必須在 1個 CLK 內按下該側按鈕。  
  若提早按或者太晚按都算失分，得分時發球權不變，反之換發。  
  最後比分結果由七段顯示器顯示。 
  
<details>
  <summary> 實作部分 </summary>
  
  * 設計 LED 乒乓球遊戲流程圖  
  ![LED 乒乓球遊戲流程圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_programming_pic.jpg)  
  * LED 乒乓球遊戲 VHDL 狀態圖    
  ![LED 乒乓球遊戲狀態圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_led_pic.jpg)   
  狀態圖說明:    
  000: PL1 發球前的狀態  
  001: PL2 發球前的狀態  
  010: LED 右移  
  011: LED 左移  
  100: PL1 接到球  
  101: PL2 接到球  
  110: PL1 當前分數  
  111: PL2 當前分數  
  btn1, btn2: 代表 PL1, PL2  `電路為正邏輯`  
  pos: 球的當前位置  

  * 接上實際電路觀測結果  
  [實際電路觀測結果](https://drive.google.com/file/d/17KoJ02tQW8P4xKnkNdryfAqvog-4ffQe/view?usp=sharing)   
  影片說明:  
  左邊的按鈕為 PL1， 右邊的按鈕為 PL2，左邊的七段為 PL1 分數，右邊的七段為 PL2 分數。
</details>

<details>
  <summary> 問題討論 </summary>  
  
  * 目前 LED 的部分不會移動，但是計分判斷和按鈕控制流程是正常功能  
  - [ ] 已解決        
  - [x] 未解決   
</details>
</details> 

<details>
  <summary> Week 9 專案管理 </summary>
  日期: 2020.12.18 - 2020.12.25  
  
  處理 GitHub 專案管理  
  [操作連結](https://drive.google.com/file/d/1kbkaADANnAS-PVTFHqxI0UQdvAd30b4R/view?usp=sharing "PPT連結")  
  
</details>

<details>
  <summary> Week 10 LED 乒乓球遊戲 </summary>
  日期: 2020.12.25 - 2021.01.01  
  
  專案資料夾: [06 pingpong_led](https://github.com/Sapphire1002/VHDL/tree/main/06%20pingpong_led "專案連結")  
  進度:  
  修正 LED 不會移動的問題  
  重新設計流程圖和狀態圖  
  完成 LED 乒乓球遊戲  
  
<details>
  <summary> 實作部分 </summary>
  
  * 設計 LED 乒乓球遊戲流程圖  
  ![LED 乒乓球遊戲流程圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_programming_pic_v2.jpg)  
  * LED 乒乓球遊戲 Mealy 狀態圖 & FPGA 電路圖      
  ![LED 乒乓球遊戲狀態圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_led_pic_v2.jpg)       
  電路&參數說明:  
  btn1: 玩家1  
  btn2: 玩家2  
  MealyFSM: 米利型有限狀態機  
  PL1_score: 玩家1 分數  
  PL2_score: 玩家2 分數  
  cnt: LED 移動的當前位置  
  freq_div: 除頻  
  serve: 控制發球權  
  狀態說明:  
  s0: 玩家發球前  
  s1: LED右移&PL2是否接到球  
  s2: LED左移&PL1是否接到球  

  * LED 乒乓球遊戲實際遊玩影片   
  [實際遊玩影片](https://drive.google.com/file/d/1XFI0Tmmhyu-u4TRTxHXLS94yamRKo8X2/view?usp=sharing)   
  影片說明:  
  左邊的按鈕為 PL1，右邊的按鈕為 PL2，上面的七段為 PL1 分數，下面的七段為 PL2 分數。
</details>  

<details>
  <summary> 問題討論 </summary>   
  
  * 之前問題  
  * 目前 LED 的部分不會移動，但是計分判斷和按鈕控制流程是正常功能  
  - [x] 已解決  
        解決方式: 重新設計狀態圖和流程圖來處理本項問題  
  - [ ] 未解決   
  * Vivado 會無法偵測到 FPGA 板子的問題  
  - [x] 已解決  
        解決方式: 到對應版本的vivado資料夾目錄下找到 install_digilent.exe 並執行  
        `例如: D:\Vivado\2019.2\data\xicom\cable_drivers\nt64\digilent\install_digilent.exe`
  - [ ] 未解決 
</details>
</details>

<details>
  <summary> Week 11 LED 乒乓球遊戲(unfinish) </summary>
  日期: 2021.01.01 - 2021.01.08  
  
  專案資料夾: [06 pingpong_led](https://github.com/Sapphire1002/VHDL/tree/main/06%20pingpong_led "專案連結")  
  進度:  
  了解 LFSR  
  LED 乒乓球可以有速度的變化  
  
<details>
  <summary> 實作部分 </summary>
  
  * LFSR 原理  
  線性反饋移位暫存器(Linear Feedback Shift Register)  
  給予一個初始值，接著取 n 個位元做 XOR 並將產生的值做為輸入到 MSB 或 LSB，讓暫存器產生移位的效果。  
  作法:  
  ![LFSR 電路圖]()
  
  * LFSR 實作和測試  

  * LED 乒乓球遊戲實際遊玩影片   
  [實際遊玩影片](https://drive.google.com/file/d/13V1_zYj_vKg3D8IJxIxA7z4eNMOWi35x/view?usp=sharing)   
  影片說明:  
  
</details>  

</details>


<details>
  <summary> Week 12 期末考 </summary>
  期末考週
</details>

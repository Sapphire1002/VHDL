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
  <summary> Week 11 LED 乒乓球遊戲 </summary>
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
  ![LFSR 電路圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/lfsr_pingpong_use.jpg)  
  說明:  
  採取 X2 XOR X1 輸入到第一級的 D型正反器。  
  
  * LFSR 實作和測試  
  測試圖:  
  ![LFSR 模擬](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/LFSR_test_result.PNG)  
  說明:  
  程式裡有用一個 temp 來儲存 X2 XOR X1 的值，然而初始值設定為 001、temp 為 0。  
  因此下一次的輸出會受到上一個的temp影響。  
  例如:  
  (X2X1X0, temp): (001, 0) -> (010, 0) -> (100, 1) -> (001, 1) -> (011, 0) -> (110, 1) -> (101, 0)...
  
  * LED 乒乓球遊戲實際遊玩影片   
  [實際遊玩影片](https://drive.google.com/file/d/13V1_zYj_vKg3D8IJxIxA7z4eNMOWi35x/view?usp=sharing)   
  影片說明:  
  有來回打的流程在 4s ~ 11s  
  
</details>  

</details>


<details>
  <summary> Week 12 期末考 </summary>
  期末考週
</details>

<details>
  <summary> Week 13 LED 乒乓球遊戲 </summary>
    日期: 2021.01.15 - 2021.01.22  
  
  專案資料夾: [06 pingpong_led](https://github.com/Sapphire1002/VHDL/tree/main/06%20pingpong_led "專案連結")  
  進度:    
  LED 乒乓球可以有速度的變化  
  
<details>
  <summary> 實作部分 </summary>
  
  * 設計構想流程  
  ![設計構想流程](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/20210119_%E4%B9%92%E4%B9%93%E7%90%83%E8%A8%AD%E8%A8%88%E6%A7%8B%E6%83%B3%E6%B5%81%E7%A8%8B.PNG)    
  
  * 設計構想圖  
  ![設計構想圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/20210119_%E4%B9%92%E4%B9%93%E7%90%83%E8%A8%AD%E8%A8%88%E6%A7%8B%E6%83%B3%E5%9C%96.PNG)  
  ![ctrl_ball_clk](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/20210119_ctrl_ball_clk%E5%9C%96.PNG)  
  
  說明:  
  clk: 為 FPGA 100MHz 最大速度  
  LFSR_random: 產生 3bits 亂數值，賦值給 Qt  
  freq: 將隨機數的值賦給球速的時間  
  random_value: 依時間把值給 times  
  times: 取 Qt 的最後兩個位元
  clk_div: 球速的最大值  
  ctrl_ball_clk: 依照 times 狀態給予不同的速度值  
  MealyFSM: 01.01的乒乓球進度  

  * LED 乒乓球遊戲實際遊玩影片   
  [實際遊玩影片](https://drive.google.com/file/d/1SCx2BbKd_0MiofaLddfYK3ylky8m_mH7/view?usp=sharing)   
 
  
</details> 
</details>

<details>
  <summary> Week 14 VGA 圖案顯示 </summary>
  日期: 2021.01.21 - 2021.01.27  
  
  專案資料夾: [07 video_out_display_graphics](https://github.com/Sapphire1002/VHDL/tree/main/07%20video_out_display_graphics "專案連結")  
  進度:  
  VGA 顯示 Google 圖案  
  VGA 乒乓球  

<details>
  <summary> 實作部分 </summary>
    <details>
      <summary> IP Catalog 操作 </summary>
      
  * IP Catalog    
  ` 版本: Vivado 2019.2 `  
  RAM & ROM 創建流程    
  ![步驟1](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F1.PNG)  
  ![步驟2](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F2.PNG)  
  ![步驟3](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F2_2.PNG)  
  ![步驟4](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F2_3.PNG)  
  ![步驟5](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F2_4.PNG)  

  * 操作結果  
  ![結果1](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F3.PNG)
  ![結果2](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F3_2.PNG)
  ![結果3](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_IP%E6%AD%A5%E9%A9%9F3_3.PNG)  
        
  </details>
  
   <details>  
     <summary> VGA Display </summary>
      
   * 設計流程
   ![流程圖](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_VGA_display_1.PNG)  
   
   * 實作結果  
   ![Google圖片](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/google_pic_128.png)  
   `size: 128 * 128 `  
   ![顯示](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_VGA_display_2.PNG)
   ![程式](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_VGA_display_2_2.PNG)  
   說明:  
   h_count: 水平當前掃描位置  
   v_count: 垂直當前掃描位置  
   addra: ROM 的地址  
   douta: ROM 在該地址的輸出資料  
   r, g, b: 分別為紅綠藍顏色  

  * VGA PingPong  
  * 設計流程  
  ![流程圖](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_VGA_display_3.PNG)  
  
  * 電路圖  
  ![電路圖](https://github.com/Sapphire1002/VHDL/blob/main/07%20video_out_display_graphics/20210125_VGA_display_4.PNG)  
  說明:  
  紅色箭頭為 外部輸入訊號  
  藍色箭頭為 傳遞參數  
  黃色箭頭為 輸出給外部訊號  
  電路圖說明:  
  clk_divider: 除頻電路  
  clk_div: 除2  
  clk_ball: 除2^21  
  scanner: 處理螢幕掃描及顯示圖形  
  addra: 記憶體位址  
  uut: ROM: 傳遞ROM參數  
  douta: 根據輸出當前addra的資料  
  FSM: 控制遊戲演算及球的移動  
  image_left_x: 圖案左上角座標  
  image_right_y: 圖案右上角座標  
  board_ctrl: 控制板子移動  
  board_left_y: 左側板子的右上角座標  
  board_right_y: 右側板子的左上角座標  

  * 當前實作結果  
  [遊玩影片](https://drive.google.com/file/d/1taIrTT6sPIOCHrO5W4BsGg9jWH7jlPXq/view?usp=sharing)  
  說明:  
  步驟二 圖案移動的地方有狀況，沒辦法顯示完整圖案  
  
   </details>
</details>

<details>
  <summary> 問題討論 </summary>
  
  * Google 圖案移動時會失真  
  - [ ] 已解決   
  - [x] 未解決  
    問題:  
    (目前可能狀況，時序問題)  
    螢幕掃描為 50MHz => 0.02us  
    圖片大小為 128 * 128  
    圖片完全讀取完的時間 327.68us ≒ 0.33ms  

    球移動速度為 0.02us * 2^20 ≒ 20.97ms  
    此時圖片讀取次數 63.55 次  
    球移動時圖片並沒有完整讀取完  

</details>
</details>

<details>
  <summary> Week 15 板子互連乒乓 </summary>
  
  日期: 2021.02.19 - 2021.02.26  
  
  專案資料夾: [08 fpga_connection]("專案連結")  
  進度:  
  兩塊 FPGA 板子互連乒乓  
  
  <details>
  <summary> 實作部分 </summary>
  
  * 設計流程  
  ![流程圖](https://github.com/Sapphire1002/VHDL/blob/main/08%20fpga_connection/20210226_%E8%A8%AD%E8%A8%88%E6%B5%81%E7%A8%8B.PNG)  
  
  * 設計架構圖  
  ![架構圖](https://github.com/Sapphire1002/VHDL/blob/main/08%20fpga_connection/20210226_fpga_connection_%E6%9E%B6%E6%A7%8B%E5%9C%96.PNG)  
  說明:  
  clk: FPGA 100MHz 時脈  
  data: 為 inout 傳輸  
  count: 計算球的位置  
  FSM: 控制球移動的狀態機  
  freq_div: 除頻  
  freq_clk: 除 2^22  
  `目前只有 LED 左移的功能`  
  
  * 當前實作結果  
  [影片連結](https://drive.google.com/file/d/1FJ7SEmzQc0w0w_e17ej9KPOKpSAv0b5X/view?usp=sharing)  
  說明:  
  根據當前的 count 值判斷要傳輸 data資料還是接收資料  
  
  </details>
  
  <details>
  <summary> 問題討論 </summary>
  
   * inout 操作  
   * 一開始使用 reset 另一塊板子的 LED 也會同時移動  
  - [x] 已解決   
        解決方式: 後來採用兩塊板子都有自己的 reset   
  - [ ] 未解決 
  
  </details>

</details>

<details>
  <summary> Week 16 板子互連乒乓 </summary>
  
  日期: 2021.02.26 - 2021.03.04  
  
  專案資料夾: [08 fpga_connection]("專案連結")  
  進度:  
  兩塊 FPGA 板子互連乒乓  

  <details>
  <summary> 實作部分 </summary>
  
  * 設計流程  
  ![流程圖](https://github.com/Sapphire1002/VHDL/blob/main/08%20fpga_connection/20210304_%E8%A8%AD%E8%A8%88%E6%B5%81%E7%A8%8B.PNG)
  
  * 設計架構圖(player_main上, player_other下)    
  ![main架構圖](https://github.com/Sapphire1002/VHDL/blob/main/08%20fpga_connection/20210304_fpga_connect_main_%E6%9E%B6%E6%A7%8B.PNG)  
  說明:  
  ctrl_start: 控制程式開始  
  freq_div: 除頻  
  FSM: 狀態機(目前只有左移)  
  ctrl_stop: 控制停止  
  bit_counter: 計算當前傳送的資料位元  
  data_rw: 控制資料讀寫(目前只有寫) 
  reset_out: 輸出 reset 狀態  
  scl_out: 輸出時序  
  sda: 為 inout 類別負責傳輸資料  
  
  ![other架構圖](https://github.com/Sapphire1002/VHDL/blob/main/08%20fpga_connection/20210304_fpga_connect_other_%E6%9E%B6%E6%A7%8B.PNG)    
  說明:  
  ctrl_start: 控制程式開始  
  freq_div: 除頻  
  FSM: 狀態機(目前只負責更新接收資料)  
  ctrl_stop: 控制停止  
  bit_counter: 計算當前傳送的資料位元  
  data_rw: 控制資料讀寫(目前只有讀)  
  reset_out: 輸出 reset 狀態  
  scl_out: 輸出時序  
  sda: 為 inout 類別負責接收資料  
  receive_reg: 儲存 8bits 的位置  
  
  * 當前實作結果  
  [影片連結](https://drive.google.com/file/d/14m7mvG4YvzyZUhQctgQD8ZyMFNBLdaRd/view?usp=sharing)  
  說明: 
  不確定 8 bits 在接收時的狀態  

  </details>
  
  <details>
  <summary> 問題討論 </summary>
  
   * inout 操作  
   * 8bits資料 在傳送端和接收端沒辦法同步    
  - [x] 已解決   
        解決方式: 後來採用 1 bit 資料傳輸並使用 enable 來控制當前讀寫狀態    
  - [ ] 未解決 
  </details>

</details>

<details>
  <summary> Week 17 板子互連乒乓 </summary>
  
  日期: 2021.03.05 - 2021.03.11  
  
  專案資料夾: [08 fpga_connection]("專案連結")  
  進度:  
  兩塊 FPGA 板子互連乒乓  
  
  <details>
  <summary> 實作部分 </summary>
  
  * 設計流程  
  ![流程圖](https://github.com/Sapphire1002/VHDL/blob/main/08%20fpga_connection/20210311_%E8%A8%AD%E8%A8%88%E6%B5%81%E7%A8%8B.PNG)  
  
  * 設計架構圖  
  ![架構圖](https://github.com/Sapphire1002/VHDL/blob/main/08%20fpga_connection/20210311_%E8%A8%AD%E8%A8%88%E6%9E%B6%E6%A7%8B%E5%9C%96.PNG)  
  說明:  
  freq_div: 除頻  
  freq_clk: 除 2^23 訊號  
  in_out_data: 控制當前要輸出或接收資料  
  data:  為 inout 輸出輸入  
  count: 計算當前球的位置  
  serve: 控制發球  
  ena: 控制當前讀寫  
  
  * 當前實作結果  
  [影片連結](https://drive.google.com/file/d/164o2yVWDuCR0Ng5jTcPbP7ncfTkR8vN6/view?usp=sharing)  
  說明:  
  左邊的板子發球過去可以到對面  
  
  </details>
  
  <details>
  <summary> 問題討論 </summary>
  
   * inout 時序  
   * 傳送和接收訊號時會延遲 1 個 clk  
  - [ ] 已解決      
  - [x] 未解決  
  
  </details>

</details>

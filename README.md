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
  </details>  
  
  問題討論:  
  ![Q](https://github.com/Sapphire1002/VHDL/blob/main/01%20video_out_screen_scan/1106_q1.PNG)
  - [x] 已解決  
        解決方式: 在 \*.xdc 檔案時脈的程式碼要加上 IOSTANDARD 並給電壓 LVCMOS33
  - [ ] 未解決
  
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
  問題討論:  
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

<details>
  <summary> Week 5 VGA 螢幕玩乒乓球遊戲 </summary>
  日期: 2020.11.20 - 2020.11.27  
  
  專案資料夾: [03 video_out_pingpong_vga](https://github.com/Sapphire1002/VHDL/tree/main/03%20video_out_pingpong_vga "專案連結")  
  進度:  
  使用 VGA 螢幕顯示且玩乒乓球遊戲  
  依據打擊的位置球往不同的方向飛   
  問題討論:  
  * 兩邊的檔板若超出邊界會直接消失並從另一端出現 
  - [ ] 已解決        
  - [x] 未解決  
  
</details>

<details>
  <summary> Week 6 LED/七段計數器 </summary>
  日期: 2020.11.27 - 2020.12.04  
  
  專案資料夾: [04 counter](https://github.com/Sapphire1002/VHDL/tree/main/04%20counter "專案連結")  
  進度:  
  計數器 0 ~ 9， 9 ~ 0  
  讓兩個計數器可自由設定上下限  
  計數的結果顯示在 LED 及 七段顯示器上   
  問題討論:  
  * 七段顯示器尚未研究怎麼使用
  - [x] 已解決  
        解決方式: FPGA 板子上的七段顯示器無法使用, 使用外接七段顯示器來處理        
  - [ ] 未解決 
  
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
  問題討論:  
  * 目前 LED 的部分不會移動，但是計分判斷和按鈕控制流程是正常功能  
  - [ ] 已解決        
  - [x] 未解決   
</details> 

<details>
  <summary> Week 9 專案管理 </summary>
  日期: 2020.12.18 - 2020.12.25  
  
  處理 GitHub 專案管理
  
</details>

  

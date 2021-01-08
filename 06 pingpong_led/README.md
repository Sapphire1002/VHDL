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
> * 目前 LED 的部分不會移動，但是計分判斷和按鈕控制流程是正常功能  

> 程式檔案名稱:  
> pingpong_LED.vhd  
> pingpong_LED.xdc


#### 本周進度
> 負責人: 何佳曄 \
> 目前成員: 何佳曄 \
> 報告日期: 2021.01.01 \
> 開始日期: 2020.12.25 \
> 結束日期: 

> 進度:  
> * 修正 LED 不會移動的問題   
> * 重新設計流程圖和狀態圖  
> * 完成 LED 乒乓球遊戲   

> 實作部分:  
> * 設計 LED 乒乓球遊戲流程圖  
> ![LED 乒乓球遊戲流程圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_programming_pic_v2.jpg)  
> * LED 乒乓球遊戲 Mealy 狀態圖 & FPGA 電路圖      
> ![LED 乒乓球遊戲狀態圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/pingpong_led_pic_v2.jpg)   
> 電路&參數說明:  
> btn1: 玩家1  
> btn2: 玩家2  
> MealyFSM: 米利型有限狀態機  
> PL1_score: 玩家1 分數  
> PL2_score: 玩家2 分數  
> cnt: LED 移動的當前位置  
> freq_div: 除頻  
> serve: 控制發球權  
> 狀態說明:  
> s0: 玩家發球前  
> s1: LED右移&PL2是否接到球  
> s2: LED左移&PL1是否接到球 

> * LED 乒乓球遊戲實際遊玩影片  
> [實際遊玩影片](https://drive.google.com/file/d/1XFI0Tmmhyu-u4TRTxHXLS94yamRKo8X2/view?usp=sharing)   
> 影片說明:  
> 左邊的按鈕為 PL1，右邊的按鈕為 PL2，上面的七段為 PL1 分數，下面的七段為 PL2 分數。  

> 問題討論:    
> * 目前 LED 的部分不會移動，但是計分判斷和按鈕控制流程是正常功能  
> * Vivado 會無法偵測到 FPGA 板子的問題

> 解決方式:  
> Sol1\. 重新設計狀態圖和流程圖來處理本項問題  
> Sol2\. 到對應版本的vivado資料夾目錄下找到 install_digilent.exe 並執行  
> `例如: D:\Vivado\2019.2\data\xicom\cable_drivers\nt64\digilent\install_digilent.exe`

> 程式檔案名稱:  
> pingpong_LED_v2.vhd  
> pingpong_LED.xdc


#### 本周進度  
> 負責人: 何佳曄 \
> 目前成員: 何佳曄 \
> 報告日期: 2021.01.08 \
> 開始日期: 2021.01.01 \
> 結束日期: 

> 進度:  
> * 了解 LFSR  
> * LED 乒乓球可以有速度的變化     

> 實作部分:  
> * LFSR 原理  
> 線性反饋移位暫存器(Linear Feedback Shift Register)    
> 給予一個初始值，接著取 n 個位元做 XOR 並將產生的值做為輸入到 MSB 或 LSB，讓暫存器產生移位的效果。  
> 作法:  
> ![LFSR 電路圖](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/lfsr_pingpong_use.jpg)  
> 說明:  
> 採取 X2 XOR X1 輸入到第一級的 D型正反器。  

> * LFSR 實作和測試  
> 測試圖:  
> ![LFSR 模擬](https://github.com/Sapphire1002/VHDL/blob/main/06%20pingpong_led/LFSR_test_result.PNG)  
> 說明:  
> 程式裡有用一個 temp 來儲存 X2 XOR X1 的值，然而初始值設定為 001、temp 為 0。  
> 因此下一次的輸出會受到上一個的temp影響。  
> 例如:  
> (X2X1X0, temp): (001, 0) -> (010, 0) -> (100, 1) -> (001, 1) -> (011, 0) -> (110, 1) -> (101, 0)...

> * LED 乒乓球遊戲實際遊玩影片  
> [實際遊玩影片](https://drive.google.com/file/d/13V1_zYj_vKg3D8IJxIxA7z4eNMOWi35x/view?usp=sharing)   
> 影片說明:  
> 有來回打的流程在 4s ~ 11s

> 程式檔案名稱:  
> LFSR_practice.vhd  
> LFSR_testbench.vhd  
> pingpong_LED_speed.vhd  
> pingpong_LED.xdc

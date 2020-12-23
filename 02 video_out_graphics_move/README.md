## 專案進度報告
#### 本周進度
> 負責人: 何佳曄 \
> 目前成員: 何佳曄 \
> 報告日期: 2020.11.20 \
> 開始日期: 2020.11.13 \
> 結束日期: 

> 進度:  
> * 在 VGA 螢幕上顯示正方形、圓形、三角形    
> * 使螢幕上的圖形移動  

> 實作部分:  
> * 顯示圖形  
> ![顯示圖形](https://github.com/Sapphire1002/VHDL/blob/main/02%20video_out_graphics_move/1120_Video_out_%E5%9C%96%E5%BD%A2.jpg)  
> [圖形移動影片](https://drive.google.com/file/d/1x19yr52etBxJ1drvSTe1m-OdFJPInAqK/view?usp=sharing)  

> 問題討論:  
> ![Q1](https://github.com/Sapphire1002/VHDL/blob/main/02%20video_out_graphics_move/1120_video_out_que01.png)  
> * 三角形在一開始的地方會有問題
> * 兩個 process() 傳值的方法  

> 解決方式:  
> Sol1\. 重新建立一個專案   
> Sol2\. 利用數學的線性規劃來判斷點位於直線方程式哪邊  
> Sol3\.  
> 1\. 宣告一個 signal, 類型為 std_logic_vector  
> 2\. 在第二個 process 寫一個區域變數(variable)來接收傳入的值  
> 3\. 在第二個 process 賦值給 第一步驟宣告的 signal  
> 4\. 在第一個 process 接收值, 若要轉成十進制則使用(conv_integer(variable, bits)) `conv_integer() 需要有 ieee.std_logic_arith.all 檔案`  

> 程式檔案名稱:  
> video_out_screen_scan.vhd  

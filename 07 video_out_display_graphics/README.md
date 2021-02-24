
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


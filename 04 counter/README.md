## 專案進度報告
#### 本周進度
> 負責人: 何佳曄 \
> 目前成員: 何佳曄 \
> 報告日期: 2020.12.04 \
> 開始日期: 2020.11.27 \
> 結束日期: 

> 進度:  
> * 計數器 0 ~ 9， 9 ~ 0  
> * 讓兩個計數器可自由設定上下限  
> * 計數的結果顯示在 LED 及 七段顯示器上  

> 實作部分:  
> * 上數波形模擬  
> ![上數波形模擬](https://github.com/Sapphire1002/VHDL/blob/main/04%20counter/%E4%B8%8A%E6%95%B8%E8%A8%88%E6%95%B8%E5%99%A8(0_9%E6%B3%A2%E5%BD%A2).PNG)  
> * 下數波形模擬  
> ![下數波形模擬](https://github.com/Sapphire1002/VHDL/blob/main/04%20counter/%E4%B8%8B%E6%95%B8%E8%A8%88%E6%95%B8%E5%99%A8(9_0%20%E6%B3%A2%E5%BD%A2).PNG)  
> * 自定義計數器波形模擬  
> ![自定義計數器波形](https://github.com/Sapphire1002/VHDL/blob/main/04%20counter/%E8%87%AA%E5%AE%9A%E7%BE%A9%E8%A8%88%E6%95%B8%E5%99%A8(%E6%B3%A2%E5%BD%A2).PNG)

> [LED 上數影片](https://drive.google.com/file/d/1h8_54hwukTBwddUCOMGQsIpPvyr5TOIP/view?usp=sharing)  
> [LED 下數影片](https://drive.google.com/file/d/1HvNs_3RmeN6pVpBwUH8IC6rxIaLaB1HN/view?usp=sharing)
> 影片說明:  
> 影片中的 LED 最左邊為 8，最右邊為 1。 數字 9 則顯示 8 和 1，也就是會同時亮最左邊和最右邊

> 問題討論:  
> * 七段顯示器尚未研究怎麼使用  

> 解決方式:  
> FPGA 板子上的七段顯示器無法使用, 使用外接七段顯示器來處理  

> 程式檔案名稱:  
> counter.vhd  
> counter_led.vhd  
> counter_test.vhd  
> counter_led.xdc  

#include <Trade/Trade.mqh>

int handle; //Macd verilerini çeker.
int barsTotal; // Bar sayısını yani bar verilerini çeker.

CTrade trade;

ulong posTicket;

int OnInit(){
  handle = iMACD(_Symbol,PERIOD_CURRENT,12,26,9,PRICE_CLOSE);
  barsTotal = iBars(_Symbol,PERIOD_CURRENT);

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
  
 
}

void OnTick(){

   int bars = iBars(_Symbol,PERIOD_CURRENT);//Yeni bir bar eklendiğini anlamak için.
   if(bars>barsTotal){
      barsTotal = bars;
   

   double macd[];
   CopyBuffer(handle,MAIN_LINE,1,2,macd);
   double signal[];
   CopyBuffer(handle,SIGNAL_LINE,1,2,signal);
   
   if(macd[1] > signal[1] && macd[0] < signal[0]){
      Print(__FUNCTION__," > Buy crossover...");
      
      
      
       if(posTicket <= 2){
          double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
          
          double tp = ask + 150 * _Point;
          tp = NormalizeDouble(tp,_Digits);
          
          double sl = ask - 150 * _Point;
          sl = NormalizeDouble(sl,_Digits);
       
       if(trade.Buy(0.1,_Symbol,0,sl,tp)){
       posTicket = trade.ResultOrder();
       }
      }
   }else if(macd[1] < signal[1] && macd[0] > signal[0]){
      Print(__FUNCTION__," > Sell crossover...");
      
            
      
       if(posTicket <= 2){
       double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
          
          double tp = bid - 150 * _Point;
          tp = NormalizeDouble(tp,_Digits);
          
          double sl = bid + 150 * _Point;
          sl = NormalizeDouble(sl,_Digits);
       
       
       if(trade.Sell(0.1,_Symbol,0,sl,tp)){
       posTicket = trade.ResultOrder();
       
         }
        }
       } 
   
     Comment("\nBars Total: ",barsTotal,
             "\nPos Ticket:",posTicket,
             "\nMacd[0]:",DoubleToString(macd[0],4),
             "\nMacd[1]:",DoubleToString(macd[1],4),
             "\nSignal[0]:",DoubleToString(signal[0],4),
             "\nSignal[1]:",DoubleToString(signal[1],4)); 
             }  
          }


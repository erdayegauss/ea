//+------------------------------------------------------------------+
//|                                                         test.mq4 |
//|                                                         cymatics |
//|                                          https://www.cymatics.cc |
//+------------------------------------------------------------------+
#property copyright "cymatics"
#property link      "https://www.cymatics.cc"
#property version   "1.00"
#property strict

#include <stderror.mqh> 
#include <stdlib.mqh> 

#include <quant/martingale.mqh>
#include <quant/upadown.mqh>

#define N 3
mEA *ea[N]={NULL,};

int OnInit()
{
   for(int i=0;i<N;++i){
      PrintFormat("EA[%d] = %d\n",i,ea[i]);
   }
   ea[0] = new martingale("马丁策略1");
   ea[1] = new upadown("上上下下");
   ea[2] = new martingale("马丁策略2");
   Print("AccountNumber() = " + AccountNumber());
  //EventSetTimer(5);
  for(int i=0;i<N;++i){
      PrintFormat("EA[%d] = %p\n",i,ea[i]);
   }
   
  return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   for(int i=0;i<N;++i){
      delete ea[i];
   }
   EventKillTimer();
}

void OnTick()
  {
  for(int i=0;i<N;++i){
      if(ea[i]){
         ea[i].update();
      }
   }
   //Print("Symbol=",Symbol()); 
   //Print("Low day price=",MarketInfo(Symbol(),MODE_LOW)); 
   //Print("High day price=",MarketInfo(Symbol(),MODE_HIGH)); 
   //Print("The last incoming tick time=",(MarketInfo(Symbol(),MODE_TIME))); 
   //Print("Last incoming bid price=",MarketInfo(Symbol(),MODE_BID)); 
   //Print("Last incoming ask price=",MarketInfo(Symbol(),MODE_ASK)); 
   //Print("Point size in the quote currency=",MarketInfo(Symbol(),MODE_POINT)); 
   //Print("Digits after decimal point=",MarketInfo(Symbol(),MODE_DIGITS)); 
   //Print("Spread value in points=",MarketInfo(Symbol(),MODE_SPREAD)); 
   //Print("Lot size in the base currency=",MarketInfo(Symbol(),MODE_LOTSIZE)); 
   //Print("Tick value in the deposit currency=",MarketInfo(Symbol(),MODE_TICKVALUE)); 
   //Print("Tick size in points=",MarketInfo(Symbol(),MODE_TICKSIZE));  
   //Print("Swap of the buy order=",MarketInfo(Symbol(),MODE_SWAPLONG)); 
   //Print("Swap of the sell order=",MarketInfo(Symbol(),MODE_SWAPSHORT)); 
   //Print("Market starting date (for futures)=",MarketInfo(Symbol(),MODE_STARTING)); 
   //Print("Market expiration date (for futures)=",MarketInfo(Symbol(),MODE_EXPIRATION)); 
   //Print("Trade is allowed for the symbol=",MarketInfo(Symbol(),MODE_TRADEALLOWED)); 
   //Print("Minimum permitted amount of a lot=",MarketInfo(Symbol(),MODE_MINLOT)); 
   //Print("Step for changing lots=",MarketInfo(Symbol(),MODE_LOTSTEP)); 
   //Print("Maximum permitted amount of a lot=",MarketInfo(Symbol(),MODE_MAXLOT)); 
   //Print("Swap calculation method=",MarketInfo(Symbol(),MODE_SWAPTYPE)); 
   //Print("Profit calculation mode=",MarketInfo(Symbol(),MODE_PROFITCALCMODE)); 
   //Print("Margin calculation mode=",MarketInfo(Symbol(),MODE_MARGINCALCMODE)); 
   //Print("Initial margin requirements for 1 lot=",MarketInfo(Symbol(),MODE_MARGININIT)); 
   //Print("Margin to maintain open orders calculated for 1 lot=",MarketInfo(Symbol(),MODE_MARGINMAINTENANCE)); 
   //Print("Hedged margin calculated for 1 lot=",MarketInfo(Symbol(),MODE_MARGINHEDGED)); 
   //Print("Free margin required to open 1 lot for buying=",MarketInfo(Symbol(),MODE_MARGINREQUIRED)); 
   //Print("Stop level in points=",MarketInfo(Symbol(),MODE_STOPLEVEL)); 
   //Print("Order freeze level in points=",MarketInfo(Symbol(),MODE_FREEZELEVEL));
  
  if(!IsDemo()) return;
  
   if(!IsConnected()) {
      Print("No connection");
      return;
    }
   if(!IsExpertEnabled()) {
      Print("Expert Advisors are not Enabled.");
      return;
   }
   
   if(IsTradeContextBusy()) {
      Print("Trade context is busy. Please wait"); 
      return;
   }
   if(!IsTradeAllowed()) {
      Print("Trade is not allowed");
      return;
   }
   if(AccountFreeMargin()<=0) {
      Print("No more money.");
      return;
   }
  
   //if(!IsTesting()) return ;
  
   if(Bars<100) {
      Print("bars less than 100");
      return;
     }

   ShowError();
 }


void OnTimer()
  {
   //Print(__FUNCSIG__+"   "+TimeCurrent());    
  }

double OnTester()
  {
   double ret=0.0;
   return(ret);
  }

void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//Print(__FUNCSIG__); 
  Print(__FUNCSIG__+": id="+id +" lparam="+ lparam + " dparam="+ dparam + " sparam="+sparam);
  Print("We have no money. Free Margin = ",AccountFreeMargin());
     
  }

void ShowError()
  {
   string description;
   int err=GetLastError();
   if(err!=ERR_NO_ERROR) Print("Error: ",ErrorDescription(err)); 
   
  }
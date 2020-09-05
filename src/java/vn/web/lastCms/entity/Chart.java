/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.web.lastCms.entity;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import org.apache.log4j.Logger;

/**
 *
 * @author HTC-PC
 */
public class Chart {
    static final Logger logger = Logger.getLogger(Chart.class);
    
    private String date;
    private int moneyCharg;
    private int moneyTopup;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getMoneyCharg() {
        return moneyCharg;
    }

    public void setMoneyCharg(int moneyCharg) {
        this.moneyCharg = moneyCharg;
    }

    public int getMoneyTopup() {
        return moneyTopup;
    }

    public void setMoneyTopup(int moneyTopup) {
        this.moneyTopup = moneyTopup;
    }
    
    public ArrayList<Chart> chartTopupAndCharg(String stRequest, String endRequest) throws ParseException {
        ArrayList<Chart> arrayList = new ArrayList<>();
        Date myDate = new SimpleDateFormat("MM/dd/yyyy").parse(stRequest); 
        int year = Integer.parseInt(stRequest.substring(stRequest.length() - 4, stRequest.length()));
        int month = myDate.getMonth() + 1;
        int numberDayOfMonth = 0;
        int numberDayOfMonth2 = 28;
        if (year % 4 == 0) {
            if (year % 100 == 0) {
                if (year % 400 == 0) {
                    numberDayOfMonth2 = 29;
                } 
            }
        } 
        
        switch (month) {
            case 2:
                numberDayOfMonth = numberDayOfMonth2;
                break;
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                numberDayOfMonth = 31;
                break;
            default:
                numberDayOfMonth = 30;
                break;
        }
        
        HistoryTopup daoHTU = new HistoryTopup();
        HistoryCharg daoHC = new HistoryCharg();
        
        ArrayList<HistoryCharg> chartCharg = daoHC.chart(stRequest, endRequest);
        ArrayList<HistoryTopup> chartTopup = daoHTU.chart(stRequest, endRequest);
        
        for (int i = 1; i <= numberDayOfMonth; i++) {
            Chart h = new Chart();
            h.setDate(i + "");
            for (HistoryTopup historyTopup : chartTopup) {
                if (historyTopup.getDate().equals(h.getDate())) {
                    h.setMoneyTopup(historyTopup.getMoney());
                    break;
                }
            }
            for (HistoryCharg historyCharg : chartCharg) {
                if (historyCharg.getDate().equals(h.getDate())) {
                    h.setMoneyCharg(historyCharg.getMoney());
                    break;
                }
            }
            arrayList.add(h);
        }
        
        return arrayList;
    }
}

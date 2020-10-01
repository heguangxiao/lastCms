/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.web.lastCms.utils;

/**
 *
 * @author HTC-PC
 */
public class Advance {
    public static String intToTime(int num) {
        String str = "";
        int nguyen = num / 60;
        int du = num;
        if (nguyen >= 1) {
            du = num % 60;
            str = nguyen + " phút ";
        }
        str = str + du + " giây ";
        return str;
    }
    
    public static String stringToTime(String s) {
        int num = Integer.parseInt(s);
        String str = "";
        int nguyen = num / 60;
        int du = num;
        if (nguyen >= 1) {
            du = num % 60;
            str = nguyen + " phút ";
        }
        str = str + du + " giây ";
        return str;
    }
}

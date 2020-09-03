/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.web.lastCms.entity;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import vn.web.lastCms.db.DBPool;
import vn.web.lastCms.utils.Tool;

/**
 *
 * @author HTC-PC
 */
public class HistoryTopup {
    static final Logger logger = Logger.getLogger(HistoryTopup.class);

    public ArrayList<HistoryTopup> statistic(String stRequest, String endRequest, String telco) {
        ArrayList<HistoryTopup> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(MONEY) AS MONEY, TELCO FROM history_topup WHERE 1 = 1";  
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(TOPUPAT,STR_TO_DATE(?, '%m/%d/%Y %H:%i:%s')) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(TOPUPAT,STR_TO_DATE(?, '%m/%d/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND TELCO = ?";
        }        
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                HistoryTopup h = new HistoryTopup();
                h.setMoney(rs.getInt("MONEY"));
                h.setTelco(rs.getString("TELCO"));
                all.add(h);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    
    public ArrayList<HistoryTopup> findAll(String phone, String stRequest, String endRequest, String telco) {
        ArrayList<HistoryTopup> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM history_topup WHERE 1 = 1";        
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(TOPUPAT,STR_TO_DATE(?, '%m/%d/%Y %H:%i:%s')) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(TOPUPAT,STR_TO_DATE(?, '%m/%d/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND TELCO = ?";
        }
        if (!Tool.checkNull(phone)) {
            sql += " AND PHONE like ?";
        }
        System.out.println(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone + "%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                HistoryTopup h = new HistoryTopup();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getInt("MONEY"));
                h.setTopupAt(rs.getTimestamp("TOPUPAT"));
                h.setTelco(rs.getString("TELCO"));
                all.add(h);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    
    public ArrayList<HistoryTopup> findAll() {
        ArrayList<HistoryTopup> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM history_topup WHERE 1 = 1";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                HistoryTopup h = new HistoryTopup();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getInt("MONEY"));
                h.setTopupAt(rs.getTimestamp("TOPUPAT"));
                h.setTelco(rs.getString("TELCO"));
                all.add(h);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public HistoryTopup findById(int id) {
        HistoryTopup h = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM history_topup WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                h = new HistoryTopup();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getInt("MONEY"));
                h.setTopupAt(rs.getTimestamp("TOPUPAT"));
                h.setTelco(rs.getString("TELCO"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return h;
    }

    public boolean save(HistoryTopup h) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO history_topup(PHONE, MONEY, TOPUPAT, TELCO) VALUES(?, ?, ?, ?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, h.getPhone());
            pstm.setInt(i++, h.getMoney());
            pstm.setTimestamp(i++, h.getTopupAt());
            pstm.setString(i++, h.getTelco());
            result = pstm.executeUpdate() == 1;
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(HistoryTopup h) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE history_topup SET PHONE = ?, MONEY = ?, TOPUPAT = ?, TELCO = ? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, h.getPhone());
            pstm.setString(i++, h.getPhone());
            pstm.setInt(i++, h.getMoney());
            pstm.setTimestamp(i++, h.getTopupAt());
            pstm.setString(i++, h.getTelco());
            pstm.setInt(i++, h.getId());
            result = pstm.executeUpdate() == 1;
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean delete(int id) {
        boolean result = false;
        HistoryTopup h = findById(id);
        if (h != null) {
            Connection conn = null;
            PreparedStatement pstm = null;
            ResultSet rs = null;
            String sql = "DELETE FROM history_topup WHERE ID = ?";
            try {
                conn = DBPool.getConnection();
                pstm = conn.prepareStatement(sql);
                int i = 1;
                pstm.setInt(i++, id);
                result = pstm.executeUpdate() == 1;
            } catch (SQLException ex) {
                logger.error(Tool.getLogMessage(ex));
            } finally {
                DBPool.freeConn(rs, pstm, conn);
            } 
        }
        return result; 
    }
    
    private int id;
    private String phone;
    private int money;
    private Timestamp topupAt;
    private String telco;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }

    public Timestamp getTopupAt() {
        return topupAt;
    }

    public void setTopupAt(Timestamp topupAt) {
        this.topupAt = topupAt;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }
    
}

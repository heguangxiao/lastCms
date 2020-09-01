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

public class HistoryCharg {
    static final Logger logger = Logger.getLogger(HistoryCharg.class);

    public ArrayList<HistoryCharg> statistic(String stRequest, String endRequest, String telco) {
        ArrayList<HistoryCharg> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(MONEY) AS MONEY, TELCO FROM history_charg WHERE 1 = 1";        
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(CHARGAT,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(CHARGAT,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND TELCO = ?";
        }        
        sql += " GROUP BY TELCO";
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
                HistoryCharg h = new HistoryCharg();
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
    
    public ArrayList<HistoryCharg> findAll(String phone, String stRequest, String endRequest, String telco, int topupId) {
        ArrayList<HistoryCharg> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM history_charg WHERE 1 = 1";        
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(CHARGAT,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(CHARGAT,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND TELCO = ?";
        }
        if (!Tool.checkNull(phone)) {
            sql += " AND PHONE like ?";
        }
        if (topupId != 0) {
            sql += " AND TOPUP_ID = ?";
        }
        sql += " GROUP BY TELCO";
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
            if (topupId != 0) {
                pstm.setInt(i++, topupId);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                HistoryCharg h = new HistoryCharg();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getInt("MONEY"));
                h.setChargAt(rs.getTimestamp("CHARGAT"));
                h.setTelco(rs.getString("TELCO"));
                h.setTopupId(rs.getInt("TOPUP_ID"));
                all.add(h);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    
    public ArrayList<HistoryCharg> findAll() {
        ArrayList<HistoryCharg> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM history_charg WHERE 1 = 1";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                HistoryCharg h = new HistoryCharg();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getInt("MONEY"));
                h.setChargAt(rs.getTimestamp("CHARGAT"));
                h.setTelco(rs.getString("TELCO"));
                h.setTopupId(rs.getInt("TOPUP_ID"));
                all.add(h);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public HistoryCharg findById(int id) {
        HistoryCharg h = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM history_charg WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                h = new HistoryCharg();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getInt("MONEY"));
                h.setChargAt(rs.getTimestamp("CHARGAT"));
                h.setTelco(rs.getString("TELCO"));
                h.setTopupId(rs.getInt("TOPUP_ID"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return h;
    }

    public boolean save(HistoryCharg h) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO history_charg(PHONE, MONEY, CHARGAT, TELCO, TOPUP_ID) VALUES(?, ?, ?, ?, ?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, h.getPhone());
            pstm.setInt(i++, h.getMoney());
            pstm.setTimestamp(i++, h.getChargAt());
            pstm.setString(i++, h.getTelco());
            pstm.setInt(i++, h.getTopupId());
            result = pstm.executeUpdate() == 1;
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(HistoryCharg h) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE history_charg SET PHONE = ?, MONEY = ?, CHARGAT = ?, TELCO = ?, TOPUP_ID = ? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, h.getPhone());
            pstm.setInt(i++, h.getMoney());
            pstm.setTimestamp(i++, h.getChargAt());
            pstm.setString(i++, h.getTelco());
            pstm.setInt(i++, h.getTopupId());
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
        HistoryCharg h = findById(id);
        if (h != null) {
            Connection conn = null;
            PreparedStatement pstm = null;
            ResultSet rs = null;
            String sql = "DELETE FROM history_charg WHERE ID = ?";
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
    private Timestamp chargAt;
    private String telco;
    private int topupId;

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

    public Timestamp getChargAt() {
        return chargAt;
    }

    public void setChargAt(Timestamp chargAt) {
        this.chargAt = chargAt;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public int getTopupId() {
        return topupId;
    }

    public void setTopupId(int topupId) {
        this.topupId = topupId;
    }
}

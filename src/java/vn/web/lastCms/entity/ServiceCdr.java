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
import java.util.ArrayList;
import org.apache.log4j.Logger;
import vn.web.lastCms.db.DBPool;
import vn.web.lastCms.utils.Tool;

/**
 *
 * @author HTC-PC
 */
public class ServiceCdr {    
    static final Logger logger = Logger.getLogger(ServiceCdr.class);

    public ArrayList<ServiceCdr> findAll() {
        ArrayList<ServiceCdr> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM service_cdr WHERE 1 = 1";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ServiceCdr h = new ServiceCdr();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getString("MONEY"));
                h.setChargAt(rs.getString("CHARGAT"));
                h.setTopupAt(rs.getString("TOPUPAT"));
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

    public ServiceCdr findById(int id) {
        ServiceCdr h = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM service_cdr WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                h = new ServiceCdr();
                h.setId(rs.getInt("ID"));
                h.setPhone(rs.getString("PHONE"));
                h.setMoney(rs.getString("MONEY"));
                h.setChargAt(rs.getString("CHARGAT"));
                h.setTopupAt(rs.getString("TOPUPAT"));
                h.setTelco(rs.getString("TELCO"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return h;
    }

    public boolean save(ServiceCdr h) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO service_cdr(PHONE, MONEY, CHARGAT, TOPUPAT, TELCO) VALUES(?, ?, ?, ?, ?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, h.getPhone());
            pstm.setString(i++, h.getMoney());
            pstm.setString(i++, h.getChargAt());
            pstm.setString(i++, h.getTopupAt());
            pstm.setString(i++, h.getTelco());
            result = pstm.executeUpdate() == 1;
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(ServiceCdr h) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE service_cdr SET PHONE = ?, MONEY = ?, CHARGAT = ?, TOPUPAT = ?, TELCO = ? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, h.getPhone());
            pstm.setString(i++, h.getMoney());
            pstm.setString(i++, h.getChargAt());
            pstm.setString(i++, h.getTopupAt());
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
        ServiceCdr h = findById(id);
        if (h != null) {
            Connection conn = null;
            PreparedStatement pstm = null;
            ResultSet rs = null;
            String sql = "DELETE FROM service_cdr WHERE ID = ?";
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
    private String money;
    private String chargAt;
    private String topupAt;
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

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getChargAt() {
        return chargAt;
    }

    public void setChargAt(String chargAt) {
        this.chargAt = chargAt;
    }

    public String getTopupAt() {
        return topupAt;
    }

    public void setTopupAt(String topupAt) {
        this.topupAt = topupAt;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }
}

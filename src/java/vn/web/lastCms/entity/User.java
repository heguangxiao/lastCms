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
import java.util.Collection;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.xmlbeans.impl.store.Public2;
import vn.web.lastCms.db.DBPool;
import vn.web.lastCms.utils.Tool;

public class User {
    
    static final Logger logger = Logger.getLogger(User.class);
    public static final HashMap<Integer, User> CACHE = new HashMap<>();
    
    static {
        try {
            User dao = new User();
            ArrayList<User> cache = dao.findAll();
            cache.forEach((one) -> {
                CACHE.put(one.getId(), one);
            });
        } catch (Exception e) {
            System.out.println("Error when initialize : " + e);
        }
    }

    private static void reload() {
        synchronized (CACHE) {
            User dao = new User();
            ArrayList<User> cache = dao.findAll();
            CACHE.clear();
            cache.forEach((one) -> {
                CACHE.put(one.getId(), one);
            });
            CACHE.notifyAll();
        }
    }
    
    public static User getUser(HttpSession session) {
        User user = null;
        try {
            user = (User) session.getAttribute("userLogin");
            if (user != null) {
                // Lay Lai Doi tuong moi neu da bi Reload
                user = getUser(user.getId());
            }
        } catch (Exception e) {
            logger.error("User.getUser:" + Tool.getLogMessage(e));
        }
        return user;
    }

    public static User getUser(int id) {
        synchronized (CACHE) {
            return CACHE.get(id);
        }
    }

    public static User getUser(String user) {
        synchronized (CACHE) {
            User result = null;
            Collection<User> coll = CACHE.values();
            for (User one : coll) {
                if (one.getUserName().equals(user)) {
                    result = one;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }
    
    private int id;
    private String userName;
    private String password;
    private Timestamp createdAt;
    private String createdBy;
    private int status;
    private int type;
    private String role;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }    

    public ArrayList<User> findAll() {
        ArrayList<User> all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM account WHERE 1 = 1";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setUserName(rs.getString("USERNAME"));
                user.setPassword(rs.getString("PASSWORD"));
                user.setCreatedAt(rs.getTimestamp("CREATED_AT"));
                user.setCreatedBy(rs.getString("CREATED_BY"));
                user.setStatus(rs.getInt("STATUS"));
                user.setType(rs.getInt("TYPE"));
                user.setRole(rs.getString("ROLE"));
                all.add(user);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    
    public User findById(int id) {  
        User user = null;      
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM account WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("ID"));
                user.setUserName(rs.getString("USERNAME"));
                user.setPassword(rs.getString("PASSWORD"));
                user.setCreatedAt(rs.getTimestamp("CREATED_AT"));
                user.setCreatedBy(rs.getString("CREATED_BY"));
                user.setStatus(rs.getInt("STATUS"));
                user.setType(rs.getInt("TYPE"));
                user.setRole(rs.getString("ROLE"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return user;
    }
    
    public User findByUserName(String userName) {  
        User user = null;      
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM account WHERE USERNAME = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, userName);
            rs = pstm.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("ID"));
                user.setUserName(rs.getString("USERNAME"));
                user.setPassword(rs.getString("PASSWORD"));
                user.setCreatedAt(rs.getTimestamp("CREATED_AT"));
                user.setCreatedBy(rs.getString("CREATED_BY"));
                user.setStatus(rs.getInt("STATUS"));
                user.setType(rs.getInt("TYPE"));
                user.setRole(rs.getString("ROLE"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return user;
    }
    
    public boolean save(User user) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO account(USERNAME, PASSWORD, CREATED_AT, CREATED_BY, STATUS, TYPE, ROLE) VALUES(?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, user.getUserName());
            pstm.setString(i++, user.getPassword());
            pstm.setTimestamp(i++, user.getCreatedAt());
            pstm.setString(i++, user.getCreatedBy());
            pstm.setInt(i++, user.getStatus());
            pstm.setInt(i++, user.getType());
            pstm.setString(i++, user.getRole());
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
    public boolean update(User user) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE account SET USERNAME = ?, PASSWORD = ?, STATUS = ?, TYPE = ?, ROLE = ? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, user.getUserName());
            pstm.setString(i++, user.getPassword());
            pstm.setInt(i++, user.getStatus());
            pstm.setInt(i++, user.getType());
            pstm.setString(i++, user.getRole());
            pstm.setInt(i++, user.getId());
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
    public boolean checkGod(String userName) {        
        boolean result = false;
        if (userName.equalsIgnoreCase("cmswebgod")) {
            result = true;
        }
        return result;
    }
    
    public boolean delete(int id) {
        boolean result = false;
        User user = findById(id);
        if (!checkGod(user.getUserName())) {
            Connection conn = null;
            PreparedStatement pstm = null;
            ResultSet rs = null;
            String sql = "DELETE FROM account WHERE ID = ?";
            try {
                conn = DBPool.getConnection();
                pstm = conn.prepareStatement(sql);
                int i = 1;
                pstm.setInt(i++, id);
                result = pstm.executeUpdate() == 1;
                if (result) {
                    reload();
                }
            } catch (SQLException ex) {
                logger.error(Tool.getLogMessage(ex));
            } finally {
                DBPool.freeConn(rs, pstm, conn);
            } 
        }
        return result; 
    }
    
    public boolean existsByUserName(String userName) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT USERNAME FROM account WHERE USERNAME = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, userName);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = true;
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
}

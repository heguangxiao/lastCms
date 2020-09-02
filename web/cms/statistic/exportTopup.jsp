<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page import="vn.web.lastCms.entity.HistoryTopup"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="vn.web.lastCms.utils.DateProc"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<%
    try {
        HistoryTopup dao = new HistoryTopup();
        ArrayList<HistoryTopup> list = dao.statistic("", "", "");
        
        String phone = Tool.validStringRequest(request.getParameter("phone"));
        String stRequest = Tool.validStringRequest(request.getParameter("stRequest"));
        String endRequest = Tool.validStringRequest(request.getParameter("endRequest"));
        String telco = Tool.validStringRequest(request.getParameter("telco"));
        
        list = dao.statistic(stRequest, endRequest, telco);
        
        out.clear();
        out = pageContext.pushBody();
        createExcel(list, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<HistoryTopup> all, HttpServletResponse response) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
        ArrayList<Object[]> data = new ArrayList();
        int i = 1;
        data.add(new Object[]{
            "STT",
            "MONEY",
            "TELCO"
        });
        for (HistoryTopup one : all) {
            data.add(new Object[]{
                i++,
                one.getMoney(),
                one.getTelco()
            });
        }

        data.add(new Object[]{
            "", "", "", "", ""
        });

        int rownum = 0;

        for (Object[] objArr : data) {
            Row row = sheet.createRow(rownum++);
            int cellnum = 0;
            for (Object obj : objArr) {
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof Timestamp) {
                    cell.setCellValue((Date) obj);
                } else if (obj instanceof Boolean) {
                    cell.setCellValue((Boolean) obj);
                } else if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Double) {
                    cell.setCellValue((Double) obj);
                } else if (obj instanceof Integer) {
                    cell.setCellValue((Integer) obj);
                } else {
                    cell.setCellValue((String) obj);
                }
            }
        }

        try {
            ServletOutputStream os = null;
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=ListTopupStatistic-" + DateProc.createDDMMYYYY() + ".xlsx");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
%>
<%@page import="vn.web.lastCms.entity.ServiceCdr"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="vn.web.lastCms.utils.DateProc"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="vn.web.lastCms.utils.RequestTool"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<%
    try {
        ServiceCdr dao = new ServiceCdr();
        
        String phonesearch = RequestTool.getString(request, "phonesearch");
        
        ArrayList<ServiceCdr> list = dao.findAll(phonesearch);
        
        out.clear();
        out = pageContext.pushBody();
        createExcel(list, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<ServiceCdr> all, HttpServletResponse response) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
        ArrayList<Object[]> data = new ArrayList();
        int i = 1;
        data.add(new Object[]{
            "STT",
            "PHONE",
            "MONEY",
            "CHARGAT",
            "TOPUPAT",
            "TELCO"
        });
        for (ServiceCdr one : all) {
            data.add(new Object[]{
                i++,
                one.getPhone(),
                one.getMoney(),
                one.getChargAt(),
                one.getTopupAt(),
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
            response.setHeader("Content-Disposition", "attachment; filename=ListPhoneHistory-" + DateProc.createDDMMYYYY() + ".xlsx");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
%>
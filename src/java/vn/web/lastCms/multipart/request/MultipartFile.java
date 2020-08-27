package vn.web.lastCms.multipart.request;

/*
 MultipartRequest servlet library
 Copyright (C) 2001-2007 by Jason Pell

 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.

 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.

 You should have received a copy of the GNU Lesser General Public
 License along with this library; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

 A copy of the Lesser General Public License (lesser.txt) is included in 
 this archive or goto the GNU website http://www.gnu.org/copyleft/lesser.html.
 */
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import vn.web.lastCms.utils.DataConvert;

/**
 * @author Jason Pell
 * @version 2.00b11
 */
public class MultipartFile {

    private String m_fieldname;
    private String m_rawFileName;
    private String m_fileName;
    private File m_tmpFile;
    private byte[] m_fileContents;
    private long m_fileSize;
    private String m_contentType;
    private BufferedReader br;

    /**
     * @param fieldName - name of file field
     * @param fileName
     * @param contentType - Content type of file
     * @param fileSize - size of file
     * @param tmpFile - file contents
     */
    protected MultipartFile(String fieldName, String fileName, String contentType, long fileSize, File tmpFile) {
        m_fieldname = fieldName;
        m_rawFileName = fileName;
        m_fileName = getBasename(m_rawFileName);
        m_contentType = contentType;
        m_tmpFile = tmpFile;
        m_fileSize = fileSize;
    }

    /**
     * @param fieldName - name of file field
     * @param fileName
     * @param contentType - Content type of file
     * @param fileSize - size of file
     * @param fileContents - file contents
     */
    protected MultipartFile(String fieldName, String fileName, String contentType, long fileSize, byte[] fileContents) {
        m_fieldname = fieldName;
        m_rawFileName = fileName;
        m_fileName = getBasename(m_rawFileName);
        m_contentType = contentType;
        m_fileContents = fileContents;
        m_fileSize = fileSize;
    }

    public String getFieldName() {
        return m_fieldname;
    }

    public String getPathName() {
        return m_rawFileName;
    }

    public String getName() {
        return m_fileName;
    }

    public String getContentType() {
        return m_contentType;
    }

    public long getSize() {
        return m_fileSize;
    }

    public InputStream getInputStream() throws IOException {
        if (m_tmpFile != null) {
            return new FileInputStream(m_tmpFile);
        } else if (m_fileContents != null) {
            return new ByteArrayInputStream(m_fileContents);
        } else {
            return new EmptyInputStream();
        }
    }

    public BufferedReader getBufferedReader() throws IOException {
        if (br != null) {
            br.close();
        }
        if (m_tmpFile != null) {
            br = new BufferedReader(new FileReader(m_tmpFile));
        } else {
            br = new BufferedReader(new InputStreamReader(getInputStream()));
        }
        return br;
    }

    @Override
    public String toString() {
        return "fieldName=" + getFieldName()
                + "; pathName=" + getPathName()
                + "; name=" + getName()
                + "; contentType=" + getContentType()
                + "; size=" + getSize();
    }

    /**
     * This needs to support the possibility of a / or a \ separator.
     *
     * Returns strFilename after removing all characters before the last
     * occurence of / or \.
     */
    private String getBasename(String strFilename) {
        if (strFilename == null) {
            return strFilename;
        }

        int intIndex = strFilename.lastIndexOf("/");
        if (intIndex == -1 || strFilename.lastIndexOf("\\") > intIndex) {
            intIndex = strFilename.lastIndexOf("\\");
        }

        if (intIndex != -1) {
            return strFilename.substring(intIndex + 1);
        } else {
            return strFilename;
        }
    }

    public String getExtentsion() {
        String ext = "";
        if (m_rawFileName == null) {
            return ext;
        }
        int index = m_rawFileName.lastIndexOf(".");
        if (index != -1) {
            ext = m_rawFileName.substring(index + 1);
        } else {
            return ext;
        }
        return ext;
    }

    public byte[] getByteFromFile() {
        byte[] byteReturn = null;
        InputStream imgFullins = null;
        try {
            if (m_tmpFile != null) {
                imgFullins = new FileInputStream(m_tmpFile);
            } else if (m_fileContents != null) {
                imgFullins = new ByteArrayInputStream(m_fileContents);
            } else {
                imgFullins = new EmptyInputStream();
            }
            byteReturn = DataConvert.InputStream2Bytes(imgFullins);
        } catch (FileNotFoundException ex) {
        } finally {
            try {
                if (imgFullins != null) {
                    imgFullins.close();
                }
            } catch (IOException ex) {
            }
        }
        return byteReturn;
    }

    public static boolean checkFileExist(String file_path) {
        boolean check = false;
        try {
            File file = new File(file_path);
            if (file.exists()) {
                check = true;
            }
        } catch (Exception e) {
        }
        return check;
    }
}

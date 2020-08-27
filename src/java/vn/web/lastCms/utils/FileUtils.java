/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.web.lastCms.utils;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import javax.imageio.ImageIO;
import net.coobird.thumbnailator.Thumbnails;
import vn.web.lastCms.config.MyContext;

/**
 *
 * @author PLATUAN
 */
public class FileUtils {

    /**
     *
     * @param arrbyte
     * @param full_path
     * @return
     */
    public static boolean writeFileToDisk(byte[] arrbyte, String full_path) {
        boolean flag = false;
        FileOutputStream fsave = null;
        try {
            File f = new File(full_path);
            if (!f.exists()) {
                f.createNewFile();
            }
            fsave = new FileOutputStream(f);
            fsave.write(arrbyte);
            flag = true;
        } catch (IOException ex) {
        } finally {
            try {
                fsave.flush();
                fsave.close();
            } catch (IOException ex) {
                System.out.println("Loi dong Ouput Stream");
            }
        }
        return flag;
    }
    private static final int bufferSize = 8192;

    public static void copy(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[bufferSize];
        int read;

        while ((read = in.read(buffer, 0, bufferSize)) != -1) {
            out.write(buffer, 0, read);
        }
    }

    /**
     *
     * @param bis
     * @return
     */
    public static byte[] writeBuffer2Byte(BufferedInputStream bis) {
        byte[] byteReturn = null;
        byte[] buffer = new byte[1024];
        long fileSize = 0;
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            while (true) {
                int iBytes = bis.read(buffer);
                ////System.out.println(iBytes);
                // If there was nothing read, get out of loop
                if (iBytes == -1) {
                    break;
                } else {
                    fileSize += iBytes;
                }
                baos.write(buffer, 0, iBytes);
            }
            byteReturn = baos.toByteArray();
        } catch (IOException ie) {
        } finally {
            try {
                baos.flush();
                baos.close();
                bis.close();
            } catch (IOException e) {
            }
        }
        return byteReturn;
    }

    public static boolean writeContent(BufferedInputStream bis, ByteArrayOutputStream baos) {
        boolean flag = true;
        byte[] buffer = new byte[1024];
        long fileSize = 0;
        try {
            while (true) {
                int iBytes = bis.read(buffer);
                ////System.out.println(iBytes);
                // If there was nothing read, get out of loop
                if (iBytes == -1) {
                    break;
                } else {
                    fileSize += iBytes;
                }
                baos.write(buffer, 0, iBytes);
            }
            flag = fileSize <= MyContext.MAX_FILE_SIZE;
        } catch (IOException ie) {
            flag = false;
        } finally {
            try {
                baos.flush();
                baos.close();
                bis.close();
            } catch (IOException e) {
            }
        }
        return flag;
    }

    public static byte[] getBytesFromFile(File file) throws IOException, FileNotFoundException {
        byte[] bytes;
        // Get the size of the file
        try (InputStream fin = new FileInputStream(file)) {
            // Get the size of the file
            long length = file.length();
            if (length > Integer.MAX_VALUE) {
                throw new IOException("File is too large" + file.getName());
                // File is too large
            }   // Create the byte array to hold the data
            bytes = new byte[(int) length];
            // Read in the bytes
            int offset = 0;
            int numRead = 0;
            while (offset < bytes.length && (numRead = fin.read(bytes, offset, bytes.length - offset)) >= 0) {
                offset += numRead;
            }   // Ensure all the bytes have been read in
            if (offset < bytes.length) {
                throw new IOException("Could not completely read file " + file.getName());
            }
            // Close the input stream and return bytes
        }
        return bytes;
    }
    
    public static void resizeMaxWithWriteImg(InputStream ipst, int max_width, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(ipst);
            //----------------
            if (originalImage.getWidth() > max_width) {
                // resize va write
                Thumbnails.of(originalImage)
                        .width(max_width)
                        .outputFormat(extention)
                        .outputQuality(1)
                        .toFile(new File(realPath));
            } else {
                Thumbnails.of(originalImage)
                        .width(originalImage.getWidth())
                        .outputFormat(extention)
                        .outputQuality(1)
                        .toFile(new File(realPath));
            }

        } catch (IOException e) {
        }
    }

    public static void resizeMaxWithWriteImg(URL url, int max_width, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(url.openStream());
            //----------------
            if (originalImage.getWidth() > max_width) {
                // resize va write
                Thumbnails.of(url)
                        .width(max_width)
                        .outputQuality(1)
                        // .outputFormat(extention)
                        .toFile(new File(realPath));
            } else {
                Thumbnails.of(url)
                        .width(originalImage.getWidth())
                        .outputFormat(extention)
                        .outputQuality(1)
                        .toFile(new File(realPath));
            }

        } catch (IOException e) {
        }
    }

    public static boolean writeImg(InputStream ipst, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(ipst);
            Thumbnails.of(originalImage)
                    .width(originalImage.getWidth())
                    .outputFormat(extention)
                    .outputQuality(1)
                    .toFile(new File(realPath));
            return true;
        } catch (IOException e) {
        }
        return false;
    }

    public static void writeImg(URL url, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(url.openStream());
            Thumbnails.of(url)
                    .width(originalImage.getWidth())
                    .outputQuality(1)
                    .toFile(new File(realPath));

        } catch (IOException e) {
        }
    }

    public static void resizeWriteImg(InputStream ips, int width, String realPath, String extention) {
        try {
            // resize va write
            Thumbnails.of(ips)
                    .width(width)
                    .outputFormat(extention)
                    .outputQuality(1)
                    .toFile(new File(realPath));
        } catch (IOException e) {
        }
    }

    public static void resizeWriteImg(URL url, int width, String realPath, String extention) {
        try {
            // resize va write
            Thumbnails.of(url)
                    .width(width)
                    // .outputFormat(extention)
                    .outputQuality(1)
                    .toFile(new File(realPath));
        } catch (IOException e) {
        }
    }
}

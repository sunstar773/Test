package com.fh.util;


import com.aliyun.oss.OSSClient;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import org.apache.poi.ss.usermodel.Workbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

public class FileUtil {

	public static void xlsDownloadFile(HttpServletResponse response, Workbook wb) {
		OutputStream os = null;
		try {
			os = response.getOutputStream(); //重点突出(特别注意),通过response获取的输出流，作为服务端向客户端浏览器输出内容的通道
			// 处理下载文件名的乱码问题(根据浏览器的不同进行处理)
			response.reset(); // 重点突出
			response.setCharacterEncoding("UTF-8"); // 重点突出
			response.setContentType("application/x-msdownload");// 不同类型的文件对应不同的MIME类型 // 重点突出
			response.setHeader("Content-Disposition", "attachment;filename="+ UUID.randomUUID().toString()+".xlsx");// 重点突出
			wb.write(os);
		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		} finally {
			// 特别重要
			// 1. 进行关闭是为了释放资源
			// 2. 进行关闭会自动执行flush方法清空缓冲区内容
			try {
				if (null != os) {
					os.close();
					os = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}


	public static void pdfDownload(HttpServletResponse response, ByteArrayOutputStream byffer) {

		// inline在浏览器中直接显示，不提示用户下载
		// attachment弹出对话框，提示用户进行下载保存本地
		// 默认为inline方式
		response.setHeader("Content-Disposition", "attachment; filename=" + UUID.randomUUID().toString() + ".pdf");
		// 不同类型的文件对应不同的MIME类型
		response.setContentType("application/octet-stream;charset=UTF-8");
		ServletOutputStream out;
		try {
			//获取输出流
			out = response.getOutputStream();
			//调用方法下载
			byffer.writeTo(out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static PdfPCell createHeadline(String value, Font font) {
		// 创建一个单元格
		PdfPCell cell = new PdfPCell();
		// new Paragraph()是段落的处理，可以设置段落的对齐方式，缩进和间距。
		cell.setPhrase(new Paragraph(value, font));
		//设置单元格的水平对齐方式
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		// 设置单元格的垂直对齐方式
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setMinimumHeight(30);//设置表格行高
		cell.setBorderWidth(0f);//去除表格的边框
		cell.setColspan(19);//跨列
		return cell;
	}


	public static PdfPCell createCell(String value, Font font, int align) {
		// 创建一个单元格
		PdfPCell cell = new PdfPCell();
		// 设置单元格的垂直对齐方式
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		// 设置单元格的水平对齐方式
		cell.setHorizontalAlignment(align);
		cell.setPhrase(new Phrase(value, font));
		return cell;
	}

	static int maxWidth = 520;// 总宽度



	public static PdfPTable createTable(int colNumber) {
		// 创建表格
		PdfPTable table = new PdfPTable(colNumber);
		// 设置表格的总宽度
		table.setTotalWidth(maxWidth);
		//锁定宽度
		table.setLockedWidth(true);
		// 设置表格的垂直对齐方式
		table.setHorizontalAlignment(Element.ALIGN_CENTER);
		// 设置边框
		table.getDefaultCell().setBorder(1);
		return table;
	}

	public static  void deleteOssImg(String imgUrl){
		String endpoint = "http://oss-cn-beijing.aliyuncs.com";
		String accessKeyId = "LTAI4Fg1bdn7NZRNdLnBnaEL";
		String accessKeySecret = "lAmUQXKHTAJrhEeDQQG1gdc62dDpJn";
		String bucketName="sunstaroos";
		String replace = imgUrl.replace("https://sunstaroos.oss-cn-beijing.aliyuncs.com/", "");
		OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
		ossClient.deleteObject(bucketName,replace);
		ossClient.shutdown();
	}




}

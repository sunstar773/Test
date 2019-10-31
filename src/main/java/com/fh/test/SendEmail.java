package com.fh.test;

import javax.mail.Message;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendEmail {

    public static void SendQQEmail(String title,String email,String context) throws Exception {
        Properties prop = new Properties();
        // 设置邮件服务器主机名
        prop.setProperty("mail.host", "smtp.qq.com");
        // 发送邮件协议名称
        prop.setProperty("mail.transport.protocol", "smtp");
        // 发送服务器需要身份验证
        prop.setProperty("mail.smtp.auth", "true");
        //使用JavaMail发送邮件的5个步骤
        //1、创建session
        Session session = Session.getInstance(prop);
        //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
        session.setDebug(true);
        //2、通过session得到transport对象
        Transport ts = session.getTransport();
        //3、连接邮件服务器：邮箱类型，帐号，授权码代替密码（更安全）
        ts.connect("smtp.qq.com", "919702926@qq.com", "yxmopwfaryxubdac");
        //4、创建邮件
        Message message = createSimpleMail(session,title,email,context);
        //5、发送邮件
        ts.sendMessage(message, message.getAllRecipients());
        ts.close();
    }

    public static MimeMessage createSimpleMail(Session session,String title,String email,String context)
            throws Exception {
        //创建邮件对象
        MimeMessage message = new MimeMessage(session);
        //指明邮件的发件人
        message.setFrom(new InternetAddress("919702926@qq.com"));
        //指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
        //邮件的标题
        message.setSubject(title);
        //邮件的文本内容
        message.setContent(context, "text/html;charset=UTF-8");
        //返回创建好的邮件对象
        return message;
    }

}

package com.eshore.nrms.util;

import org.apache.commons.lang.time.DateFormatUtils;

import java.util.Date;

/**
 * 日期工具类
 */
public final class DateUtils {


    /**
     * 获取当前日期字符串
     * @return yyyy-MM-dd HH:mm:ss
     */
    public static String getDate() {
        return DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
    }

    private DateUtils() { }

}

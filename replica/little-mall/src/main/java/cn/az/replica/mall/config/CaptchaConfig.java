package cn.az.replica.mall.config;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * @author az
 * @since 2020-04-01
 */
@Configuration
public class CaptchaConfig {

    @Bean("captchaProducer")
    public DefaultKaptcha defaultKaptcha() {
        DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
        Properties properties = new Properties();

        // 是否有边框 默认为true 我们可以自己设置yes，no
        properties.setProperty(Constants.KAPTCHA_BORDER, "no");
        // 验证码文本生成器
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_IMPL, "ltd.newbee.mall.config.TextCreator");
        // 验证码文本字符颜色 默认为Color.BLACK
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_FONT_COLOR, "blue");
        // 验证码图片宽度 默认为200
        properties.setProperty(Constants.KAPTCHA_IMAGE_WIDTH, "100");
        // 验证码图片高度 默认为50
        properties.setProperty(Constants.KAPTCHA_IMAGE_HEIGHT, "37");
        // 验证码文本字符大小 默认为40
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_FONT_SIZE, "25");
        // 验证码文本字符长度 默认为4
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_CHAR_LENGTH, "4");
        // 验证码文本字符间隔 默认为2
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_CHAR_SPACE, "6");
        // 验证码文本字符来源
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_CHAR_STRING, "abcdefghijklmnopqrstuvwxyz");
        // SESSION_KEY
        properties.setProperty(Constants.KAPTCHA_SESSION_CONFIG_KEY, "kaptcha.code");
        // 噪点设置
        properties.setProperty(Constants.KAPTCHA_NOISE_IMPL, "com.google.code.kaptcha.impl.NoNoise");
        // 验证码文本字体样式 默认为new Font("Arial", 1, fontSize), new Font("Courier", 1, fontSize)
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_FONT_NAMES, "微软雅黑,宋体,楷体");
        // 和登录框背景颜色一致
        properties.setProperty(Constants.KAPTCHA_BACKGROUND_CLR_FROM, "247,247,247");
        properties.setProperty(Constants.KAPTCHA_BACKGROUND_CLR_TO, "126,236,236");
        // 图片样式 水纹com.google.code.kaptcha.impl.WaterRipple
        // 鱼眼com.google.code.kaptcha.impl.FishEyeGimpy
        // 阴影com.google.code.kaptcha.impl.ShadowGimpy
        properties.setProperty(Constants.KAPTCHA_OBSCURIFICATOR_IMPL, "com.google.code.kaptcha.impl.ShadowGimpy");

        Config config = new Config(properties);
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }
}

package cn.az.project.miaosha.domain;

import lombok.Data;
import lombok.ToString;

import java.math.BigDecimal;

/**
 * @author az
 */
@Data
@ToString
public class Goods {

    private Long id;
    private String goodsName;
    private String goodsTitle;
    private String goodsImg;
    private String goodsDetail;
    private BigDecimal goodsPrice;
    private Integer goodsStock;
}

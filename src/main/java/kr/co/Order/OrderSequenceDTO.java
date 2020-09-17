package kr.co.Order;

import kr.co.Product.ProductDTO;

public class OrderSequenceDTO {
   private String od_id; 
   private int od_amount; 
   private int pd_number;
   ProductDTO productDTO = new ProductDTO();
   
   public ProductDTO getProductDTO() {
	return productDTO;
   }
   public void setProductDTO(ProductDTO productDTO) {
	this.productDTO = productDTO;
   }
   
   public String getOd_id() {
      return od_id;
   }
   public void setOd_id(String od_id) {
      this.od_id = od_id;
   }
   public int getOd_amount() {
      return od_amount;
   }
   public void setOd_amount(int od_amount) {
      this.od_amount = od_amount;
   }
   public int getPd_number() {
      return pd_number;
   }
   public void setPd_number(int pd_number) {
      this.pd_number = pd_number;
   }
   
@Override
public String toString() {
	return "OrderSequenceDTO [od_id=" + od_id + ", od_amount=" + od_amount + ", pd_number=" + pd_number
			+ ", productDTO=" + productDTO + "]";
}


   
   
}
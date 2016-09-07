//
//  UIImage.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/1.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension UIImage {

    /**
     *  通过view生成图片
     *
     *  @param color 一个颜色指标【不能为nil】
     *
     *  @return 图片
     */
    public class func grh_image(view aView:UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(aView.frm_size, false, 0);
        //获取图像

        let context: CGContextRef? = UIGraphicsGetCurrentContext();
        var image: UIImage?;
        
        if (context != nil) {
            aView.layer.renderInContext(UIGraphicsGetCurrentContext()!);
            UIGraphicsEndImageContext();
        
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
        
        UIGraphicsEndImageContext();
        return image;
    }
    
    /**
    *  返回一像素（size(1,1)）这个color颜色的图片
    *
    *  @param color 一个颜色指标
    *
    *  @return 图片
    */
    public class func grh_image(withColor color: UIColor) -> UIImage {
        return self.grh_image(withColor: color, withSize: CGSizeMake(1, 1));
    }
    
     /**
     *  返回一像素（size(1,1)）这个color颜色的图片
     *
     *  @param color 颜色指标
     *  @param size 图片大小
     *
     *  @return 图片
     */
    public class func grh_image(withColor color: UIColor, withSize size:CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(size);
        
        let context: CGContextRef? = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }

    /**
    *  返回一个size为给定size的color颜色图片
    *
    *  @param size   size大小
    *  @param color  填充色颜色
    *  @param radius 圆角半径
    *
    *  @return 图片
    */
    public class func grh_image(withColor color: UIColor, withCornerRadius cornerRadius: CGFloat) -> UIImage {
        let width: CGFloat = cornerRadius * 2 + 3;
        return self.grh_image(withSize: CGSizeMake(width, width), withColor: color, withBorder: 0, withBorderColor: nil, withCornerRadius: cornerRadius);
    }
    
    /**
    *  返回一个size为给定size的color颜色带with宽边线和borderColor颜色的图片
    *
    *  @param color       填充色颜色
    *  @param width       边线宽度
    *  @param borderColor 边线颜色
    *  @param radius      圆角半径
    *
    *  @return 图片
    */
    public class func grh_image(withColor color: UIColor, withBorder border: CGFloat, withBorderColor borderColor: UIColor, withCornerRadius cornerRadius: CGFloat) -> UIImage {
        let width: CGFloat = cornerRadius * 2 + 3;
        return self.grh_image(withSize: CGSizeMake(width, width), withColor: color, withBorder: border, withBorderColor: borderColor, withCornerRadius: cornerRadius);
    }
    
    /**
     *  返回一个size为给定size的color颜色带with宽边线和borderColor颜色的图片
     *
     *  @param size        size大小
     *  @param color       填充色颜色
     *  @param width       边线宽度
     *  @param borderColor 边线颜色
     *  @param radius      圆角半径
     *
     *  @return 图片
     */
    public class func grh_image(withSize size: CGSize, withColor color: UIColor?, withBorder border: CGFloat, withBorderColor borderColor: UIColor?, withCornerRadius cornerRadius: CGFloat) -> UIImage {
        
        var backgroundColor: UIColor? = color;

        if (backgroundColor == nil) {
            backgroundColor = UIColor.clearColor();
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        let borderWidth: CGFloat = ceil(border);
        let radius: CGFloat = cornerRadius * 2;
        
        if(borderWidth > 0 && borderColor != nil) {
            let borderPath: UIBezierPath = UIBezierPath(roundedRect: CGRectMake(0, 0, size.width, size.height), cornerRadius: radius);
            
            if (color == UIColor.clearColor()) {
                borderPath.lineWidth = borderWidth;
                borderColor!.setStroke();
                borderPath.stroke();
            } else {
                borderColor!.setFill();
                borderPath.fill();
            }
        }
        
        let fillPath: UIBezierPath = UIBezierPath(roundedRect: CGRectMake(borderWidth, borderWidth, size.width - 2 * borderWidth, size.height - 2 * borderWidth), cornerRadius: radius);
        
        backgroundColor!.setFill();
        fillPath.fill();
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    /**
     *  通过当前图片，生成掉圆角边框的图片 (暂时都按centerfill处理)
     *
     *  @param size        size大小
     *  @param color       填充色颜色
     *  @param width       边线宽度
     *  @param borderColor 边线颜色
     *  @param radius      圆角半径
     *
     *  @return 图片
     */
    public func grh_image(withSize size: CGSize, withBorder border: CGFloat, withBorderColor borderColor: UIColor?, withCornerRadius cornerRadius: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        let borderWidth: CGFloat = ceil(border);

        let radius: CGFloat = cornerRadius * 2;
        let borderPath: UIBezierPath = UIBezierPath(roundedRect: CGRectMake(0, 0, size.width, size.height), cornerRadius: radius);
        
        borderPath.addClip();
        
        var imageRect: CGRect = CGRectZero;
        
        var radio: CGFloat = 0;
        if(self.size.width > self.size.height) {
            radio = self.size.height / size.height;
        } else {
            radio = self.size.width / size.width;
        }
        
        let newSize = CGSizeMake(self.size.width * radio, self.size.height * radio);
        
        imageRect.origin.x = newSize.width >= size.width ? 0 : (newSize.width - size.width) / 2;
        imageRect.origin.y = newSize.height >= size.height ? 0 : (newSize.height - size.height) / 2;
        imageRect.size = newSize;
        
        self.drawInRect(CGRectMake(0, 0, size.width, size.height));
        
        if(borderColor != nil && borderWidth != 0) {
            borderColor?.setStroke();
            borderPath.lineWidth = borderWidth;
            borderPath.stroke();
        }

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    /**
     *  中间拉伸图
     *
     *  @return 中间拉伸图
     */
    public func grh_centerStretchImage() -> UIImage {
        let size: CGSize = self.size;
        let halfWidth: CGFloat = floor(size.width / 2);
        let halfHeight: CGFloat = floor(size.height / 2);
        
        return self .resizableImageWithCapInsets(UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth));
    }
    
}

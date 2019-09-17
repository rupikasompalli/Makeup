//
//  Product.swift
//  MakeupRealm
//
//  Created by Venkata Nandamuri on 2019-07-09.
//  Copyright © 2019 Venkata Nandamuri. All rights reserved.
//

import UIKit
import RealmSwift


struct Product:Decodable {

      var product_id : Int?
      var brand : String?
      var name : String?
      var price : String?
      var price_sign : String?
      var currency : String?
      var image_link : String?
      var product_link : String?
      var website_link : String?
      var prod_description : String?
      var category : String?
      var prod_type : String?
      var rating : Double?
      var tagList : [String]?
      var product_colors : [ProductColor]?
      var created_at : String?
      var updated_at : String?
      var product_api_url : String?
      var api_featured_image : String?
    
    enum CodingKeys: String, CodingKey {
        case product_id = "id"
        case brand
        case name
        case price
        case price_sign
        case currency
        case image_link
        case product_link
        case website_link
        case prod_description = "description"
        case category
        case rating
        case tagList = "tag_list"
        case product_colors
        case prod_type = "product_type"
        case created_at
        case updated_at
        case product_api_url
        case api_featured_image
    }
    
    init(from decoder: Decoder) throws
    {
        
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            product_id = try container.decodeIfPresent(Int.self, forKey: .product_id)
            brand = try container.decodeIfPresent(String.self, forKey: .brand)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            price = try container.decodeIfPresent(String.self, forKey: .price)
            price_sign = try container.decodeIfPresent(String.self, forKey: .price_sign)
            currency = try container.decodeIfPresent(String.self, forKey: .currency)
            image_link = try container.decodeIfPresent(String.self, forKey: .image_link)
            product_link = try container.decodeIfPresent(String.self, forKey: .product_link)
            website_link = try container.decodeIfPresent(String.self, forKey: .website_link)
            prod_description = try container.decodeIfPresent(String.self, forKey: .prod_description)
            category = try container.decodeIfPresent(String.self, forKey: .category)
            rating = try container.decodeIfPresent(Double.self, forKey: .rating)
            
            tagList = try container.decodeIfPresent([String].self, forKey: .tagList)
            product_colors = try container.decodeIfPresent([ProductColor].self, forKey: .product_colors)
            
            prod_type = try container.decodeIfPresent(String.self, forKey: .prod_type)
            created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
            updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
            updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
            product_api_url = try container.decodeIfPresent(String.self, forKey: .product_api_url)
            api_featured_image = try container.decodeIfPresent(String.self, forKey: .api_featured_image)
            
        }catch{
            print(error)
        }
       
    }
   
}

struct ProductColor : Decodable{
    
    var hex_value : String?
    var color_name : String?
    
    enum CodingKeys: String, CodingKey {
        case hex_value
        case color_name
    }
    
    init(from decoder: Decoder) throws
    {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            hex_value = try container.decodeIfPresent(String.self, forKey: .hex_value)
            color_name = try container.decodeIfPresent(String.self, forKey: .color_name)
        }catch{
            print(error)
        }
       
    }
}

@objcMembers class RLMProduct: Object {
    
    dynamic var product_id : Int?
    dynamic var favourite : Bool = false
    dynamic var brand : String?
    dynamic var name : String?
    dynamic var price : String?
    dynamic var price_sign : String?
    dynamic var currency : String?
    dynamic var image_link : String?
    dynamic var product_link : String?
    dynamic var website_link : String?
    dynamic var prod_description : String?
    dynamic var category : String?
    dynamic var rating : String?
    dynamic var prod_type : String?
    
    
    let tagList = List<String>()
    let product_colors = List<RLMProductColor>()
    
}

@objcMembers class RLMProductColor : Object{
    
      dynamic var hex_value : String?
      dynamic var color_name : String?
    
}

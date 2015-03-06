//
//  WeatherTableViewCell.swift
//  ClearWeatherApp
//
//  Created by 瀧ヶ崎翔 on 2015/03/06.
//  Copyright (c) 2015年 FarConnection. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    let dateLabel = UILabel()
    let descriptionLabel = UILabel()
    let maxLabel = UILabel()
    let minLabel = UILabel()
    let weatherImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

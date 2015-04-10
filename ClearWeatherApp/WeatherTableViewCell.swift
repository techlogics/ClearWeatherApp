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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None // セルを選択した時の色の変更をなしに設定
        self.backgroundColor = UIColor.clearColor()
        
        // それぞれのパーツの色やフォントの設定
        //weatherImageView = UIImageView(frame: CGRectMake(0, 0, 60, 60))
        weatherImageView.tintColor = UIColor.whiteColor()
        
        //dateLabel = UILabel(frame: CGRectZero)
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 25)
        
        //descriptionLabel = UILabel(frame: CGRectZero)
        descriptionLabel.textColor = UIColor.whiteColor()
        descriptionLabel.font = UIFont(name: "HelveticaNeue-light", size: 15)
        
        //maxLabel = UILabel(frame: CGRectZero)
        maxLabel.textColor = UIColor.whiteColor()
        maxLabel.font = UIFont(name: "HelveticaNeue-light", size: 20)
        maxLabel.textAlignment = NSTextAlignment.Right
        
        //minLabel = UILabel(frame: CGRectZero)
        minLabel.textColor = UIColor.whiteColor()
        minLabel.font = UIFont(name: "HelveticaNeue-light", size: 20)
        minLabel.textAlignment = NSTextAlignment.Right
        
        // self.contentView.addSubView()でSubviewに追加
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(maxLabel)
        self.contentView.addSubview(minLabel)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ここでそれぞれのパーツを配置する位置を設定する
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let kCellSize: CGSize = self.frame.size
        weatherImageView.frame = CGRectMake(0, 0, 80, 80)
        weatherImageView.layer.position = CGPointMake(kCellSize.width/2, kCellSize.height/2)
        dateLabel.frame = CGRectMake(20, 20, 100, 40)
        descriptionLabel.frame = CGRectMake(20, 45, 150, 40)
        maxLabel.frame = CGRectMake(kCellSize.width-120, 20, 100, 40)
        minLabel.frame = CGRectMake(kCellSize.width-120, 50, 100, 40)
        
    }

}

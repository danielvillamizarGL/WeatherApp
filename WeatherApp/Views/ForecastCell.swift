//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import UIKit


class ForecastCell: UICollectionViewCell {
    
    
    //MARK: - Subviews
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "weather")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.montserrat(size: 16, weight: .semiBold)
        label.text = "30 °C"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.montserrat(size: 14)
        label.text = "Sunday"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Lifecycle methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Initial view configuration
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4
        contentView.backgroundColor = .white
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(temperatureLabel)
        
    }
    
    private func setupLayouts(){
                
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            weatherImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0)
        ])
    }
    
    //MARK: - Cell configuration methods
    
    func configureCell(with model: Data) {
    
        dayLabel.text = model.dateTimeConversion
        temperatureLabel.text = model.main.tempDescription
        weatherImage.image = UIImage(named: model.weather.first!.imageName)
    }
    
}


extension ForecastCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

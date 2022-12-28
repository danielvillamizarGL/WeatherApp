//
//  ForecastTableCell.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 28/12/22.
//

import UIKit

class ForecastTableCell: UITableViewCell {
    
    //MARK: - Subviews
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        
        label.font = UIFont.montserrat(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let temperatureLabel: UILabel = {
       let label = UILabel()
        
        label.font = UIFont.montserrat(size: 14, weight: .semiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Lifecycle methods
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Initial configuration methods
    
    private func setupViews() {
        contentView.addSubview(weatherImage)
        contentView.addSubview(dateLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    private func setupLayouts() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            weatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            weatherImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            weatherImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            weatherImage.widthAnchor.constraint(equalToConstant: 30),
            weatherImage.heightAnchor.constraint(equalToConstant: 40),
        ])
                
                
        constraints.append(contentsOf: [
            dateLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 12),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        constraints.append(contentsOf: [
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate(constraints)
    }
    
   //MARK: - Cell configuration methods
    
    public func configureCell(with model: Data) {
          
        dateLabel.text = model.dateTimeConversion
        weatherImage.image = UIImage(named: model.weather.first!.imageName)
        temperatureLabel.text = model.main.tempDescription
    }
    
}


extension ForecastTableCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    
    
}

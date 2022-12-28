//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 28/12/22.
//

import UIKit

class ForecastViewController: UIViewController {
    
    public var forecast: Forecast
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(ForecastTableCell.self, forCellReuseIdentifier: ForecastTableCell.identifier)
        
        return table
    }()
    
    init(forecast: Forecast) {
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Next 3 day forecast"
        
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        table.frame = view.bounds
        table.dataSource = self
        table.delegate = self        
            
        view.addSubview(table)
    }
    
    private func setupLayouts() {

    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableCell.identifier, for: indexPath) as! ForecastTableCell
        
        let data = forecast.list[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.configureCell(with: data)
        
        return cell
    }
    
    
}

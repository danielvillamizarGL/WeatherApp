//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 28/12/22.
//

import UIKit

class AddCityViewController: UIViewController {
    
    var delegate: AddCityDelegate?
    
    var cities = [CityModel(name: "Piedecuesta", lat: 7.0046272, lon: -73.0523224),
                  CityModel(name: "Bogotá", lat: 4.6486259, lon: -74.2478919),
                  CityModel(name: "Quebec", lat: 46.8572913, lon: -71.4849978),]
    
    //MARK: - Subviews
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - Initial view configurations
    
    private func setupViews(){
        view.backgroundColor = .white
        
        navigationItem.title = "Select a city"
        
        view.addSubview(table)
        table.frame = view.bounds
        
        table.dataSource = self
        table.delegate = self
    }
    
}

//MARK: - TableView extension

extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = cities[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.changeCity(city: cities[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}

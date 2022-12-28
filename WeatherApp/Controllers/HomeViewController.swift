//
//  ViewController.swift
//  WeatherApp
//
//  Created by Daniel José Villamizar on 26/12/22.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private var forecast: Forecast?
    
    private let service: WeatherService
    
    //MARK: - Subviews
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "daytime")
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let imageDescription: UILabel = {
        let label = UILabel()
        
        label.text = ""
        
        label.font = UIFont.montserrat(size: 12)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let temperature: UILabel = {
        let label = UILabel()
        
        label.text = ""
        
        label.font = UIFont.montserrat(size: 80, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let windStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.font = UIFont.montserrat(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let humidityStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.font = UIFont.montserrat(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let goToForecastButton: UIButton = {
        
        var configuration = UIButton.Configuration.plain()
        let largeFont = UIFont.systemFont(ofSize: 10)
        let imageConf = UIImage.SymbolConfiguration(font: largeFont)
        
        configuration.image = UIImage(systemName: "chevron.forward", withConfiguration: imageConf)
        configuration.imagePlacement = .trailing
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        
        button.setTitle("More details", for: .normal)
        button.titleLabel?.font =  UIFont.montserrat(size: 14)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let nextDaysForecastCollection: UICollectionView = {
        
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        
        collectionView.backgroundColor = .clear
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
        
    }()
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupViews()
        applyConstraints()
        setupLocation()
    }
    
    init(service: WeatherService){
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Initial view configuration
    
    private func setupLocation(){
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
    }
    
    private func setupNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.add)
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.action = #selector(addCity)
        navigationItem.leftBarButtonItem?.target = self
    }
        
    private func setupViews(){
        view.backgroundColor = .white
        
        view.addSubview(backgroundImage)
        view.addSubview(imageView)
        view.addSubview(imageDescription)
        view.addSubview(temperature)
        view.addSubview(infoStack)
        view.addSubview(nextDaysForecastCollection)
        view.addSubview(goToForecastButton)
        
        let windIcon = UIImage(systemName: "wind")?.withRenderingMode(.alwaysTemplate)
        let windImageView = UIImageView(image: windIcon)
        windImageView.tintColor = .black
        
        windStack.addArrangedSubview(windImageView)
        windStack.addArrangedSubview(windLabel)
        
        let humidityIcon = UIImage(systemName: "humidity")?.withRenderingMode(.alwaysTemplate)
        let humidityImageView = UIImageView(image: humidityIcon)
        humidityImageView.tintColor = .black
        
        humidityStack.addArrangedSubview(humidityImageView)
        humidityStack.addArrangedSubview(humidityLabel)
        
        nextDaysForecastCollection.dataSource = self
        nextDaysForecastCollection.delegate = self
    }
    
    private func applyConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        constraints.append(contentsOf: [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
        
        constraints.append(contentsOf: [
            imageDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            imageDescription.centerXAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        constraints.append(contentsOf: [
            temperature.topAnchor.constraint(equalTo: imageDescription.bottomAnchor, constant: 8),
            temperature.centerXAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        constraints.append(contentsOf: [
            infoStack.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 8),
            infoStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            infoStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        
        constraints.append(contentsOf: [
            nextDaysForecastCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextDaysForecastCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nextDaysForecastCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nextDaysForecastCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.21)
        ])
        
        constraints.append(contentsOf: [
            goToForecastButton.bottomAnchor.constraint(equalTo: nextDaysForecastCollection.topAnchor, constant: -8),
            goToForecastButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Networking methods
    
    private func getCurrenWeather(lat: String, lon: String, completion: @escaping (Result<WeatherData, RequestError>) -> Void) {
        
        Task(priority: .background) {
            let result = await service.getCurrentWeather(lat: lat, lon: lon)
            completion(result)
        }
    }
    
    
    private func getForecast(lat: String, lon: String, completion: @escaping (Result<Forecast, RequestError>) -> Void) {
        
        Task(priority: .background) {
            let result = await service.getForecast(lat: lat, lon: lon)
            completion(result)
        }
    }
    
    private func fetchData(latitude: String, longitude: String){
        getCurrenWeather(lat: latitude, lon: longitude) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                print(weatherData.name)
                
                self.goToForecastButton.addTarget(self, action: #selector(self.goToForecast), for: .touchUpInside)
                
                self.navigationItem.title = weatherData.name
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.montserrat(size: 20, weight: .semiBold)]
                self.imageView.image = UIImage(named: weatherData.weather.first!.imageName)
                self.temperature.text = weatherData.main.tempDescription
                self.imageDescription.text = weatherData.weather.first!.description.capitalized
                self.windLabel.text = weatherData.wind.speedDescription
                self.humidityLabel.text = weatherData.main.humidityDescription
                
                self.infoStack.addArrangedSubview(self.windStack)
                self.infoStack.addArrangedSubview(self.humidityStack)
                
                let hour = Calendar.current.component(.hour, from: Date())
                if hour < 18 && hour > 6 {
                    self.backgroundImage.image = UIImage(named: "daytime")
                }
                else{
                    self.backgroundImage.image = UIImage(named: "nighttime")
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        getForecast(lat: latitude, lon: longitude) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.forecast = data
                self.nextDaysForecastCollection.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Selectors
    
    @objc private func addCity() {
        let vc = AddCityViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToForecast(){
        guard let data = forecast else {
            return
        }
        let vc = ForecastViewController(forecast: data)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - TableView extension

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (forecast?.list) != nil {
            return 4
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.identifier, for: indexPath) as! ForecastCell
        
        if let data = forecast?.list[indexPath.row] {
            cell.configureCell(with: data)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {       
        
        return CGSize(width: 150, height: view.frame.height * 0.2)
    }
    
}

//MARK: - Location extension

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            fetchData(latitude: latitude.description, longitude: longitude.description)
        }
    }
    
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
   
}

//MARK: - AddCity extension

extension HomeViewController: AddCityDelegate {
    func changeCity(city: CityModel) {
        fetchData(latitude: city.lat.description, longitude: city.lon.description)
    }
    
    
}

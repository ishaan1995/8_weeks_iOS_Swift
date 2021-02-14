//
//  ViewController.swift
//  HelloWorld Networking
//
//  Created by Ishaan Kakkar on 14/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func refreshBtnClicked(_ sender: UIButton) {
        fetchWeather()
    }
    
    @IBOutlet weak var currentTempView: UILabel!
    
    @IBOutlet weak var placeView: UILabel!
    
    @IBOutlet weak var minMaxTempView: UILabel!

    @IBOutlet weak var refreshBtnView: UIButton!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchWeather()
    }
    
    func fetchWeather() {
        updateUI(showLoading: true)
        let session = URLSession.shared
        let url = URL(string: "https://www.metaweather.com/api/location/28743736")!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            if error != nil || httpResponse?.statusCode != 200 || data == nil {
                self.showErrorAlert(title: "Oops!", message: "Could not fetch weather. Please try again.")
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(MetaWeatherResponse.self, from: data!)
                let latestWeather = weatherResponse.consolidatedWeather[0]
                self.updatedWeatherViews(city: weatherResponse.title, country: weatherResponse.parent.title, temp: Int(latestWeather.theTemp.rounded()), minTemp: Int(latestWeather.minTemp.rounded()), maxTemp: Int(latestWeather.maxTemp.rounded()))
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                self.showErrorAlert(title: "Oops!", message: "Invalid response. Please try again")
            }
        })
        task.resume()
    }
    
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            self.updateUI(showLoading: false)
        }
    }
    
    func updatedWeatherViews(city: String, country: String, temp: Int,
                           minTemp: Int, maxTemp: Int) {
        DispatchQueue.main.async {
            self.placeView.text = "🏠 \(city), \(country)"
            self.currentTempView.text = "⛅️ \(temp)°C"
            self.minMaxTempView.text = "Min: \(minTemp)°C | Max: \(maxTemp)°C"
            self.updateUI(showLoading: false)
        }
    }
    
    func updateUI(showLoading: Bool) {
        minMaxTempView.isHidden = showLoading
        placeView.isHidden = showLoading
        currentTempView.isHidden = showLoading
        refreshBtnView.isHidden = showLoading
        
        if (showLoading) {
            loadingView.isHidden = false
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
            loadingView.isHidden = true
        }
    }
}


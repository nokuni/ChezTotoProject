//
//  ViewController.swift
//  ChezTotoProject
//
//  Created by Yann Christophe Maertens on 21/11/2023.
//

import UIKit
import MapKit
import CoreLocation
import Utility_Toolbox

class ViewController: UIViewController {
    
    let bannerImageView = UIImageView(image: UIImage(named: "chezToto"))
    var restaurant: Restaurant { Restaurant.get(name: "Chez Toto")! }
    var mapLocation: CLLocation?
    
    var mapView: MKMapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        topContent()
        scheduleList()
        informations()
        setupMap()
        menuButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLocation()
    }
    
    func topContent() {
        bannerImage(size: bannerImageSize)
        titleBackground(size: CGSize(width: 117, height: 68))
        titleLabel()
        subtitleLabel()
    }
    
    func informations() {
        addressImage()
        restaurantAddressLabel(restaurant: restaurant)
        
        websiteImage()
        restaurantWebsiteLabel(restaurant: restaurant)
        
        phoneNumberImage()
        restaurantPhoneNumberLabel(restaurant: restaurant)
    }
    
    func setLocation() {
        let address = restaurant.address
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else { return }
            self.mapLocation = location
            self.setMapRegion()
        }
    }
}

// MARK: - Sizes
extension ViewController {
    var bannerImageSize: CGSize { CGSize(width: 354, height: 150) }
    var titleBackgroundSize: CGSize { CGSize(width: 117, height: 68) }
    var titleLabelSize: CGSize { CGSize(width: 86, height: 23) }
}

// MARK: - Top content
extension ViewController {
    
    func titleLabel() {
        let label = UILabel()
        label.text = "Chez Toto"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold, width: .standard)
        label.textColor = .white
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: -288)
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: titleLabelSize.width)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: titleLabelSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func subtitleLabel() {
        let label = UILabel()
        label.text = "Pizzeria"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light, width: .standard)
        label.textAlignment = .center
        label.textColor = .gray
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: -264)
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: titleLabelSize.width)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: titleLabelSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func titleBackground(size: CGSize) {
        let subView = UIView()
        subView.frame = CGRect(x: 0, y: 0, width: titleBackgroundSize.width, height: titleBackgroundSize.height)
        subView.backgroundColor = .black
        subView.layer.cornerRadius = 5
        
        view.addSubview(subView)
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalConstant = (UIScreen.main.bounds.height / 2) - ((bannerImageView.frame.height - titleBackgroundSize.height) + titleBackgroundSize.height)
        
        let horizontalConstraint = NSLayoutConstraint(item: subView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: subView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: -verticalConstant)
        let widthConstraint = NSLayoutConstraint(item: subView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: titleBackgroundSize.width)
        let heightConstraint = NSLayoutConstraint(item: subView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: titleBackgroundSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func bannerImage(size: CGSize) {
        
        view.addSubview(bannerImageView)
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalConstant = (UIScreen.main.bounds.height / 2) - size.height
        
        let horizontalConstraint = NSLayoutConstraint(item: bannerImageView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: bannerImageView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant:  -verticalConstant)
        let widthConstraint = NSLayoutConstraint(item: bannerImageView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: size.width)
        let heightConstraint = NSLayoutConstraint(item: bannerImageView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: size.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

// MARK: - Schedule
extension ViewController {
    func scheduleImage(horizontalConstraint: CGFloat, verticalConstraint: CGFloat) {
        let clockImageView = UIImageView(image: UIImage(named: "clock"))
        
        view.addSubview(clockImageView)
        
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //let verticalConstant = (UIScreen.main.bounds.height / 2) - size.height
        
        let horizontalConstraint = NSLayoutConstraint(item: clockImageView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: clockImageView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant:  verticalConstraint)
        let widthConstraint = NSLayoutConstraint(item: clockImageView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 12)
        let heightConstraint = NSLayoutConstraint(item: clockImageView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 12)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func scheduleDayLabel(schedule: Schedule,
                          horizontalConstraint: CGFloat,
                          verticalConstraint: CGFloat) {
        let label = UILabel()
        label.text = "\(schedule.day)"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold, width: .standard)
        label.textColor = .gray
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: verticalConstraint)
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 70)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: label.intrinsicContentSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func scheduleOperationHoursLabel(schedule: Schedule,
                                     horizontalConstraint: CGFloat,
                                     verticalConstraint: CGFloat) {
        let label = UILabel()
        label.text = "\(schedule.operationHours)"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold, width: .standard)
        label.textColor = .gray
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: verticalConstraint)
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 200)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: label.intrinsicContentSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func scheduleList() {
        let schedules = restaurant.schedules
        
        var verticalConstraint: CGFloat = -180
        
        let imageStartingHorizontalConstraint = (UIScreen.main.bounds.width / 2) - 352
        let dayLabelStartingHorizontalConstraint = (UIScreen.main.bounds.width / 2) - 300
        let operationHoursLabelStartingHorizontalConstraint = (UIScreen.main.bounds.width / 2) - 130
        
        for schedule in schedules {
            scheduleImage(horizontalConstraint: imageStartingHorizontalConstraint,
                          verticalConstraint: verticalConstraint)
            scheduleDayLabel(schedule: schedule,
                             horizontalConstraint: dayLabelStartingHorizontalConstraint,
                             verticalConstraint: verticalConstraint)
            scheduleOperationHoursLabel(schedule: schedule,
                                        horizontalConstraint: operationHoursLabelStartingHorizontalConstraint,
                                        verticalConstraint: verticalConstraint)
            verticalConstraint += 22
        }
    }
}

// MARK: - Informations
extension ViewController {
    
    // Adress
    func addressImage() {
        let hConstraint = (UIScreen.main.bounds.width / 2) - 352
        
        let clockImageView = UIImageView(image: UIImage(named: "mapPin"))
        
        view.addSubview(clockImageView)
        
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: clockImageView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: hConstraint)
        let verticalConstraint = NSLayoutConstraint(item: clockImageView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant:  0)
        let widthConstraint = NSLayoutConstraint(item: clockImageView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 12)
        let heightConstraint = NSLayoutConstraint(item: clockImageView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 12)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    func restaurantAddressLabel(restaurant: Restaurant) {
        let hConstraint = (UIScreen.main.bounds.width / 2) - 235
        
        let label = UILabel()
        label.text = "\(restaurant.address)"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold, width: .standard)
        label.textColor = .gray
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: hConstraint)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 200)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: label.intrinsicContentSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    // Website
    func websiteImage() {
        let hConstraint = (UIScreen.main.bounds.width / 2) - 352
        
        let clockImageView = UIImageView(image: UIImage(named: "globe"))
        
        view.addSubview(clockImageView)
        
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: clockImageView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: hConstraint)
        let verticalConstraint = NSLayoutConstraint(item: clockImageView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant:  29)
        let widthConstraint = NSLayoutConstraint(item: clockImageView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 12)
        let heightConstraint = NSLayoutConstraint(item: clockImageView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 12)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    func restaurantWebsiteLabel(restaurant: Restaurant) {
        let hConstraint = (UIScreen.main.bounds.width / 2) - 235
        
        let label = UILabel()
        label.text = "\(restaurant.website)"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold, width: .standard)
        label.textColor = .gray
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: hConstraint)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 29)
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 200)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: label.intrinsicContentSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    // Phone number
    func phoneNumberImage() {
        let hConstraint = (UIScreen.main.bounds.width / 2) - 352
        
        let clockImageView = UIImageView(image: UIImage(named: "globe"))
        
        view.addSubview(clockImageView)
        
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: clockImageView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: hConstraint)
        let verticalConstraint = NSLayoutConstraint(item: clockImageView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 58)
        let widthConstraint = NSLayoutConstraint(item: clockImageView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 12)
        let heightConstraint = NSLayoutConstraint(item: clockImageView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 12)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    func restaurantPhoneNumberLabel(restaurant: Restaurant) {
        let hConstraint = (UIScreen.main.bounds.width / 2) - 235
        
        let label = UILabel()
        label.text = "\(restaurant.phoneNumber)"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold, width: .standard)
        label.textColor = .gray
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: hConstraint)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 58)
        let widthConstraint = NSLayoutConstraint(item: label,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 200)
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: label.intrinsicContentSize.height)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

// MARK: - Map
extension ViewController: MKMapViewDelegate {
    
    private func setMapRegion() {
        if let mapLocation {
            mapView.region = MKCoordinateRegion(center: mapLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
            let annotation = MKPointAnnotation()
            annotation.coordinate = mapLocation.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setupMap() {
        mapView.delegate = self
        
        mapView.layer.cornerRadius = 20
        mapView.overrideUserInterfaceStyle = .dark
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: mapView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: mapView,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 170)
        let widthConstraint = NSLayoutConstraint(item: mapView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 354)
        let heightConstraint = NSLayoutConstraint(item: mapView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 159)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

// MARK: - Menu Button
extension ViewController {
    
    @objc func accessToMenu() {
        let viewController = MenuViewController()
        
        guard let navigationController = self.navigationController else {
            print("No navigation controller")
            return
        }
        navigationController.pushViewController(viewController, animated: true)
        print("Pushed")
    }
    
    func menuButton() {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.setTitle("Accéder au menu", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(accessToMenu), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: button,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: button,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 350)
        let widthConstraint = NSLayoutConstraint(item: button,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 335)
        let heightConstraint = NSLayoutConstraint(item: button,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 40)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}

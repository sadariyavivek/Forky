//
//  PostDetailsVC.swift
//  Forky
//
//  Created by Irfan Tai on 20/01/23.
//

import UIKit
import MapKit

class PostDetailsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var vwDate: UIView!
    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var imgVendor: UIImageView!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var lblVendorAddress: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblLocationAddress: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    
    var objPostModel : PostDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponent()
        // Do any additional setup after loading the view.
    }
    
    func setComponent(){
        scrollView.contentInsetAdjustmentBehavior = .never
        imgVendor.roundedView()
        vwDate.roundedView()
        vwDate.addShadow(cornerRadius: self.vwDate.frame.height / 2,opacity: 1.0)
        if let objPostModel = objPostModel {
                self.lblSubtitle.text = objPostModel.caption?.htmlToString
                self.imgPost.loadImageUsingCache(withUrl: objPostModel.photo ?? "")
                self.lblPostDate.text = "From \(objPostModel.from_date?.convertDateFormat(toFormat:"EEEE dd MMM") ?? "") to \(objPostModel.to_date?.convertDateFormat(toFormat:"EEEE dd MMM") ?? "")"

                if let vendorData = objPostModel.vendor {
                    self.lblVendorName.text = vendorData.business_name
                    self.lblVendorAddress.text = vendorData.address_line_1
                    self.imgVendor.loadImageUsingCache(withUrl: vendorData.logo ?? "")
                    self.lblMobile.text = vendorData.primary_contact
                    self.lblLocationAddress.text = "\(vendorData.address_line_1 ?? "")\n\(vendorData.address_line_2 ?? "")"
                    
                    if let pLat = Double(vendorData.latitude ?? "0"), let pLong = Double(vendorData.longitude ?? "0") {
                        let center = CLLocationCoordinate2D(latitude: pLat, longitude: pLong)
                        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        let annotation = MKPointAnnotation()
                        annotation.title = vendorData.business_name
                        annotation.coordinate = center
                        self.mapView.addAnnotation(annotation)
                        self.mapView.setRegion(region, animated: true)
                    }
                }
            
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCopyTapped(_ sender: Any) {
        if let strMobile = self.lblMobile.text {
            UIPasteboard.general.string = strMobile
        }
    }
    
    @IBAction func btnCallTapped(_ sender: UIButton) {
        
        if let objPostModel = objPostModel, let vendorData = objPostModel.vendor, let strMobNumber = vendorData.primary_contact {
            if let url = URL(string: "tel://\(strMobNumber)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }
        }
    }
    
    @IBAction func btnMapTapped(_ sender: UIButton) {
        if let objPostModel = objPostModel,let vendorData = objPostModel.vendor {
            if let lat = vendorData.latitude, let long = vendorData.longitude,let url = URL(string: "http://maps.apple.com/?daddr=\(lat),\(long)") {
                if UIApplication.shared.canOpenURL(url) {
                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}

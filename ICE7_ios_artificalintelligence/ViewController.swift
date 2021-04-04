//
//  ViewController.swift
//  ICE7_ios_artificalintelligence
//
//  Created by Supriya G on 4/4/21.
//

import Vision
import Photos
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var pictureChosen: UIImageView!
    
    
    @IBAction func getImage(_ sender: Any) {
        getPhoto()
    }
    
    func getPhoto() {
         let picker = UIImagePickerController()
         picker.delegate = self
         picker.sourceType = .savedPhotosAlbum
         present(picker, animated: true, completion: nil)
     }
    
    func analyzeImage(image: UIImage)
    {
     let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [ : ])
     messageLabel.text = "Analyzing picture..."
     let request =
     VNDetectFaceRectanglesRequest(completionHandler: handleFaceRecognition)
     try! handler.perform([request])
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true, completion: nil)
           
           guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
           pictureChosen.image = image
           
           analyzeImage(image: pictureChosen.image!)
       }
    
    func handleFaceRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError ("Can't find a face in the picture")
        }
        messageLabel.text = "Found \(foundFaces.count) faces in the picture"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


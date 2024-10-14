//
//  ViewController.swift
//  SandBoxIOS
//
//  Created by Eren Elçi on 14.10.2024.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    var notes = [String]()
    var fileName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SandBox Structure"
        print(NSHomeDirectory())
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(addImageClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = "\(UUID().uuidString).jpeg"
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        print(imagePath)
        
        if let jpegDta = image.jpegData(compressionQuality: 0.5) {
            try? jpegDta.write(to: imagePath)
            
        }
        
        dismiss(animated: true)
        imageView.image = UIImage(contentsOfFile: imagePath.path)
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        //Uygulamanın belgeler dizinine (document directory) erişim sağlar. Bu dizin, uygulamanın verilerini saklamak için idealdir.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        //Belgeler dizininin URL'sini alır. Genellikle tek bir yol döner, bu yüzden ilk eleman kullanılır
        return paths[0]
    }
    
    @objc func addImageClicked(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
    
    
    func SaveTextFile()
    {
        guard let fileName = fileName else { return }
        
        var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        path.appendPathComponent(fileName)
        
        print(path.absoluteString)//debug print
        
        do
        {
            try self.notes.joined(separator: "\n").write(to: path, atomically: false, encoding: .utf8)
        }
        
        catch
        {
            print(error)
        }
    }
    
    
    @objc func addNote()
    {
        // İki text field ile birlikte bir UIAlertController oluşturuyoruz
        let ac = UIAlertController(title: "Enter details", message: nil, preferredStyle: .alert)
        
        ac.addTextField { textField in
            textField.placeholder = "Enter file name" // Dosya adı girilecek alan
        }
        
        ac.addTextField { textField in
            textField.placeholder = "Enter note" // Not girilecek alan
        }
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            // İlk metin alanından dosya adını alıyoruz
            if let enteredFileName = ac.textFields?.first?.text, !enteredFileName.isEmpty {
                self?.fileName = "\(enteredFileName).txt"
            } else {
                self?.fileName = "Default.txt" // Varsayılan dosya adı
            }
            
            // İkinci metin alanından notu alıyoruz
            if let enteredNote = ac.textFields?[1].text, !enteredNote.isEmpty {
                self?.notes.append(enteredNote)
                self?.SaveTextFile()
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    
}

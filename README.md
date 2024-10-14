<details>
    <summary><h2>Uygulma Amacı</h2></summary>
   Bu uygulama, SandBox yapisi ile kullanıcıların resim eklemesine ve kişisel notlarını saklamasına olanak tanır. Kullanıcı, bir resim seçip kaydedebilir ve ayrıca metin alanları aracılığıyla not ekleyip bu notları dosya olarak saklayabilir. Uygulama, kullanıcıların fotoğraflarını ve notlarını yönetmelerini sağlayarak basit bir kişisel not ve medya uygulaması işlevi görür.
  </details> 
  <details>
    <summary><h2>SandBox Yapisi Detayli Anlatim </h2></summary>
    [Medium Makale]([https://www.ornek.com](https://medium.com/@erenelci/swift-ile-ios-ipad-sandbox-yapısı-ios-geliştirici-rehberi-21237bcbe3c7))
  </details>

  
  

  <details>
    <summary><h2>imagePickerController</h2></summary>
    Kullanıcı bir resim seçtiğinde bu yöntem çağrılır. Seçilen resim UIImage formatında alınır ve uygulamanın belgeler dizinine kaydedilir.
    Resmin adı UUID ile oluşturulur ve .jpeg uzantısı eklenir.
    Resim, belirtilen yol altında kaydedilir ve ardından imageView üzerinde görüntülenir.
    
    ```
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



    ```
  </details> 

  <details>
    <summary><h2>getDocumentsDirectory</h2></summary>
    Uygulamanın belgeler dizinine erişim sağlar. FileManager kullanarak, kullanıcı belgeleri için geçerli yolu döndürür. Bu dizin, kullanıcı verilerini saklamak için uygundur.

    
    ```
    func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
    }
    ```
  </details> 




<details>
    <summary><h2>SaveTextFile</h2></summary>
    Kullanıcının eklediği notları belirlenen dosya adıyla kaydeder. notes dizisi birleştirilip belirtilen dosya yoluna yazılır. Hata oluşursa, hata mesajı konsola yazdırılır.

    
    ```
    func SaveTextFile() {
    guard let fileName = fileName else { return }
    
    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    path.appendPathComponent(fileName)

    print(path.absoluteString) // debug print
    
    do {
        try self.notes.joined(separator: "\n").write(to: path, atomically: false, encoding: .utf8)
    } catch {
        print(error)
    }
    }

    ```
  </details>

  <details>
    <summary><h2>addNote</h2></summary>
    Kullanıcıdan dosya adını ve notunu girmesini isteyen bir UIAlertController oluşturur. Kullanıcı "Ok" butonuna bastığında, girilen bilgiler kontrol edilir ve notlar dizisine eklenir. SaveTextFile yöntemi çağrılarak not dosyası kaydedilir.

    
    ```
    @objc func addNote() {
    let ac = UIAlertController(title: "Enter details", message: nil, preferredStyle: .alert)
    
    ac.addTextField { textField in
        textField.placeholder = "Enter file name" // Dosya adı girilecek alan
    }
    
    ac.addTextField { textField in
        textField.placeholder = "Enter note" // Not girilecek alan
    }
    
    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
        if let enteredFileName = ac.textFields?.first?.text, !enteredFileName.isEmpty {
            self?.fileName = "\(enteredFileName).txt"
        } else {
            self?.fileName = "Default.txt" // Varsayılan dosya adı
        }

        if let enteredNote = ac.textFields?[1].text, !enteredNote.isEmpty {
            self?.notes.append(enteredNote)
            self?.SaveTextFile()
        }
    }))
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(ac, animated: true, completion: nil)
    }

    ```
  </details>
  
  
<details>
    <summary><h2>Uygulama Görselleri </h2></summary>
    
    
 <table style="width: 100%;">
    <tr>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">TXT. Dosyasi olusturma</h4>
            <img src="https://github.com/user-attachments/assets/52d30978-3a57-4c97-83bb-8ee9838a0dba" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Image Secimi</h4>
            <img src="https://github.com/user-attachments/assets/21469ce2-9ae7-45dd-963e-4c2d76b15ce3" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Dosy Yolu</h4>
            <img src="https://github.com/user-attachments/assets/51854dea-59a3-41ff-9e76-118a29440275" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Kaydedilen Txt Dosyalari</h4>
            <img src="https://github.com/user-attachments/assets/e041487a-c8b8-4776-b105-55304d67eb4e" style="width: 100%; height: auto;">
        </td>
    </tr>
</table>
  </details> 

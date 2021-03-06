//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by NAOKI II on 2020/03/02.
//  Copyright © 2020 NAOKI.II. All rights reserved.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    
    //ライブラリを指定してピッカーを開く
    @IBAction func handleLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        //カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    //写真撮影/選択した時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            //撮影、選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            
           // あとでCLImageEditorライブラリで加工する
           print("DEBUG_PRINT: image = \(image)")
           // CLImageEditorにimageを渡して、加工画面を起動する。
           let editor = CLImageEditor(image: image)!
           editor.delegate = self
           picker.present(editor, animated: true, completion: nil)
        }
    }
    
    // CLImageEditorで加工が終わったときに呼ばれるメソッド
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        // 投稿画面を開く
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.image = image!
        editor.present(postViewController, animated: true, completion: nil)
    }
    
    // CLImageEditorの編集がキャンセルされた時に呼ばれるメソッド
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        // ImageSelectViewController画面を閉じてタブ画面に戻る
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //キャンセルをした時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //ImageSelectViewController画面を閉じてタブ画面に戻る
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleCancelButton(_ sender: Any) {
        
        //画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}

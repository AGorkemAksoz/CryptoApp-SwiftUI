//
//  LocaleFileManager.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 17.01.2024.
//

import Foundation
import SwiftUI

class LocaleFileManager {
    
    static let shared = LocaleFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // Create Folder
        createFolderIfNeeded(folderName: folderName)
        
        // Get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // Save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let
                url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)
        else { return nil}
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error while creating directory. FolderName: \(folderName) \(error.localizedDescription)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
        
    }
}

//
//  ProfileViewModel.swift
//  FitnessApp
//
//  Created by Thành Trung on 17/2/25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profileName: String? = UserDefaults.standard.string(forKey: "profileName")
    @Published var profileImage: String? = UserDefaults.standard.string(forKey: "profileImage")
    @Published var selectedImage: String? = UserDefaults.standard.string(forKey: "profileImage")
    @Published var isEditingName = false
    @Published var currentName = ""
    @Published var isEditingImage = false
    var images = [
        "oldman", "ambessa", "darius", "draven", "ironman", "hulk", "caitlyn", "liss", "elise", "gagi", "steve", "tom", "black"
    ]
    
    func presentEditName() {
        isEditingName = true
        isEditingImage = false
    }
    
    func presentEditImage() {
        isEditingName = false
        isEditingImage = true
    }
    func dismissEdit() {
        isEditingName = false
        isEditingImage = false
    }
    func setNewName() {
        profileName = currentName
        UserDefaults.standard.set(currentName, forKey: "profileName")
        self.dismissEdit()
    }
    func didSelectNewImage(name: String) {
        selectedImage = name
    }
    func setNewImage() {
        profileImage = selectedImage
        UserDefaults.standard.set(selectedImage, forKey: "profileImage")
        self.dismissEdit()
    }
}

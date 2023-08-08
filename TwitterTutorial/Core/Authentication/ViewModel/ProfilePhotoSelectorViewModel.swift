//
//  ProfilePhotoSelectorViewModel.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/06.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase

@MainActor
class ProfilePhotoSelectorViewModel: ObservableObject {
    @Published var uiImage: UIImage?
    @Published var profileImage: Image?
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task{ await loadImage(fromItem: selectedImage) } }
    }
    private let service = AuthService.shared
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func uploadImage() async throws {
        try await AuthService.shared.uploadImage(uiImage)
    }
}

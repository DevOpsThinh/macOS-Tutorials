//
//  ImagePicker.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

import SwiftUI
import PhotosUI
import PetKit
/// A `ImagePicker` struct type for use a UIKit view in SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    // MARK: - BINDINGS
    @Binding var isPresented: Bool

    let nurture: Nurture

    // MARK: - IMPLEMENT THE CUSTOM WRAPPER
    /// Return a new PHPickerViewController limited to a single image
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images

        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController,
                              context: Context) {
        // Do some thing here
    }
    
    // MARK: - DELEGATE & COMMUNICATE BACK TO SWIFTUI
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    /// The `Coordinator` class acts as a bridge between UIView's delegate and SwiftUI
    /// Is responsible for communicating changes from our view controller to our SwiftUI views, also the delegate for `PHPickerViewController`
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        /// Handling pick an image without .jpeg extension
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let result = results.first,
                  result.itemProvider.canLoadObject(
                    ofClass: UIImage.self) else {
                        // Hide the PHPickerViewController via the Cancel button
                        picker.dismiss(animated: true)
                        return }

            result.itemProvider
                .loadObject(ofClass: UIImage.self) { [weak self] (obj, error) in
                    defer { self?.parent.isPresented = false }

                    guard let img = obj as? UIImage,
                            let parent = self?.parent else { return }


                    if error != nil {
//                        print("Erro in picker image: \(error)")
                        return
                    }

                    guard let attachmentId = parent.nurture.storeImage(img)
                    else {
//                        print("Failed storing, no UUID")
                        return
                    }

                    DispatchQueue.main.async {
                        parent.nurture.addMoment(with: attachmentId)
                    }
                }
        }
    }
}

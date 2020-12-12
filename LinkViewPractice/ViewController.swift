//
//  ViewController.swift
//  LinkViewPractice
//
//  Created by Usaid Ather on 12/12/2020.
//

import UIKit
import LinkPresentation

class ViewController: UIViewController {
    @IBOutlet weak var linkTextView: UITextField!
    @IBOutlet weak var linkPreviewView: UIView!
    @IBOutlet weak var getPreviewButton: UIButton!
    
    private var linkView: LPLinkView = LPLinkView(metadata: LPLinkMetadata())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // addingLinkView
        addLinkViewtToViewContainer()
        
    }
    
    @IBAction func getPreviewButtonTapped(_ sender: Any) {
        // fetching preview
        fetchPreview()
    }
    
    private func addLinkViewtToViewContainer(){
        DispatchQueue.main.async {
            self.linkView.frame = self.linkPreviewView.bounds
            self.linkPreviewView.addSubview(self.linkView)
            self.linkPreviewView.sizeToFit()
        }
    }
    
    // fetching preview
    private func fetchPreview(){
        if let text = self.linkTextView.text, let url = URL(string: text) {
            let metadataProvider = LPMetadataProvider()
            
            metadataProvider.startFetchingMetadata(for: url) { [weak self] (metadata, error) in
                if let error = error {
                    print(error)
                }
                else if let metadata = metadata {
                    DispatchQueue.main.async { [weak self] in
                        self?.linkView.metadata = metadata
                    }
                }
            }
        }
    }
    
}


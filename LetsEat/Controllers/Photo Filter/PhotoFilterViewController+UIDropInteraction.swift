//
//  PhotoFilterViewController+UIDropInteraction.swift
//  LetsEat
//
//  Created by Xinyi Li on 16/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import Foundation
import UIKit

extension PhotoFilterViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        if session.localDragSession == nil {
            return session.canLoadObjects(ofClass: UIImage.self)
        }
        else {
            return false
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let operation: UIDropOperation
        if session.localDragSession == nil {
            operation = .copy
        }
        else {
            operation = .copy
        }
        return UIDropProposal(operation: operation)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if session.localDragSession == nil {
            for dragItem in session.items {
//                loadImage(dragItem.itemProvider)
                print("Should be working")
            }
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, previewForDropping item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
        if item.localObject == nil {
            return nil
        } else {
            let target = UIDragPreviewTarget(container: view, center: imgExample.center)
            return defaultPreview.retargetedPreview(with: target)
        }
    }
    
    
}

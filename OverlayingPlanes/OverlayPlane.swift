//
//  OverlayPlane.swift
//  OverlayingPlanes
//
//  Created by Abdulfatah Mohamed on 23/11/2022.
//

import Foundation
import SceneKit
import ARKit

class OverlayPlane: SCNNode {
    
    var anchor: ARPlaneAnchor
    var planeGeometry: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        setup()
    }
    
    func update(anchor: ARPlaneAnchor) {
        self.planeGeometry.width = CGFloat(anchor.planeExtent.width)
        self.planeGeometry.height = CGFloat(anchor.planeExtent.height)
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    }
    
    private func setup() {
        self.planeGeometry = SCNPlane(width: CGFloat(self.anchor.planeExtent.width),
                                      height: CGFloat(self.anchor.planeExtent.height))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "overlay_grid.png")
        
        self.planeGeometry.materials = [material]
        
        let planeNode = SCNNode(geometry: self.planeGeometry)
        
        planeNode.position = SCNVector3Make(anchor.center.x,
                                            0,
                                            anchor.center.y)
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0.0, 0.0)
        
        // add to the parent
        self.addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

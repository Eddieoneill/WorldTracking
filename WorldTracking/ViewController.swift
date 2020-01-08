//
//  ViewController.swift
//  WorldTracking
//
//  Created by Edward O'Neill on 1/6/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    let randomColor: [UIColor] = [.black, .blue, .green]
    let randomNumber: [CGFloat] = [0.1, 0.2, 0.3, 0.4, 0.5, 0, -0.1, -0.2, -0.3, -0.4, -0.5]
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
//        node.geometry = SCNCone(topRadius: 0.01, bottomRadius: 0.1, height: 0.3)
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.5)
//        node.geometry = SCNTorus(ringRadius: 0.03, pipeRadius: 0.01)
//        node.geometry = SCNPlane(width: 0.1, height: 0.1)
        node.geometry = SCNPyramid(width: 0.1, height: 0.3, length: 0.1)
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = randomColor.randomElement()!
        node.position = SCNVector3(0, 0, -0.7)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}


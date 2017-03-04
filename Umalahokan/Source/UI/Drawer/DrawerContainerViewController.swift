//
//  DrawerContainerViewController.swift
//  Umalahokan
//
//  Created by Mounir Ybanez on 04/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class DrawerContainerController: UIViewController {

    lazy var gestureHelperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private(set) var drawerMenuViewController: UIViewController!
    private(set) var drawerMenuInteractiveTransition = DrawerMenuInteractiveTransition()
    private(set) var drawerMenuTransitioning = DrawerMenuTransitioning()
    
    private(set) var edgePanGesture: UIScreenEdgePanGestureRecognizer!
    private(set) var currentContentId: String = ""
    
    var contentHandler: DrawerContainerContentHandlerProtocol?
    
    convenience init(drawerMenu: DrawerMenuProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        let vc = drawerMenu.drawerMenuViewController
        vc.transitioningDelegate = drawerMenuTransitioning
        vc.modalPresentationStyle = .custom
        drawerMenu.drawerMenuInteractiveTransition = drawerMenuInteractiveTransition
        
        drawerMenuViewController = vc
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(gestureHelperView)
        
        edgePanGesture = UIScreenEdgePanGestureRecognizer()
        edgePanGesture.isEnabled = true
        edgePanGesture.cancelsTouchesInView = true
        edgePanGesture.delaysTouchesBegan = false
        edgePanGesture.delaysTouchesEnded = true
        edgePanGesture.minimumNumberOfTouches = 1
        edgePanGesture.edges = .left
        edgePanGesture.addTarget(self, action: #selector(self.handleEdgePanGesture(_ :)))
        view.addGestureRecognizer(edgePanGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect.zero
        rect.size.width = 8
        rect.origin.x = 0
        rect.size.height = view.frame.height
        gestureHelperView.frame = rect
        
        view.bringSubview(toFront: gestureHelperView)
    }
    
    func changeContentUsing(_ content: DrawerContainerContentProtocol) {
        guard content.drawerContentId != currentContentId else { return }
        
        for subview in view.subviews {
            guard subview != gestureHelperView else {
                continue
            }
            subview.removeFromSuperview()
        }
        
        let viewController = content.drawerContentViewController.navigationController ?? content.drawerContentViewController
        
        viewController.view.frame.size = view.frame.size
        view.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
        
        currentContentId = content.drawerContentId
        content.hamburger = self
    }
    
    func handleEdgePanGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let progress = drawerMenuInteractiveTransition.computeProgress(translation, viewBounds: view.bounds, direction: .right)
        drawerMenuInteractiveTransition.updateUsing(gesture.state, progress: progress) {
            [unowned self] in
            self.showMenu()
        }
    }
}

extension DrawerContainerController: DrawerContainerHamburger {
    
    var isMenuEnabled: Bool {
        return edgePanGesture.isEnabled
    }
    
    func showMenu() {
        guard isMenuEnabled else { return }
        
        drawerMenuTransitioning.interactiveTransition = drawerMenuInteractiveTransition
        
        present(drawerMenuViewController, animated: true, completion: nil)
    }
    
    func enableMenu(_ isEnabled: Bool) {
        edgePanGesture.isEnabled = isEnabled
    }
}

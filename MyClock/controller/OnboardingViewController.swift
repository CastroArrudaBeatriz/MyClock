//
//  OnboardingViewController.swift
//  MyClock
//
//  Created by Beatriz Castro on 25/04/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    private var pages = Page.allCases
    private var currentIndex = 0

    private lazy var pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        decoratePageController()
        setupPageController()
        addInitialPage()
    }

    private func decoratePageController() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingViewController.self])
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
    }

   
    private func setupPageController() {
        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.backgroundColor = .systemBackground
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(pageController)
        view.addSubview(pageController.view)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: margins.topAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])

        pageController.didMove(toParent: self)
    }

    private func addInitialPage() {
        let initialPage = DefaultPageViewController(with: pages[0])
        pageController.setViewControllers([initialPage], direction: .forward, animated: false, completion: nil)
    }

}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = (viewController as? DefaultPageViewController)?.page.index,
              index > 0 else {
            return nil
        }

        currentIndex = index - 1

        return DefaultPageViewController(with: pages[currentIndex])
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = (viewController as? DefaultPageViewController)?.page.index,
              index < pages.count - 1 else {
            return nil
        }

        currentIndex = index + 1

        return DefaultPageViewController(with: pages[currentIndex])
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentIndex
    }
}

extension UIView {
    func edgesTo(_ view: UIView) {
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

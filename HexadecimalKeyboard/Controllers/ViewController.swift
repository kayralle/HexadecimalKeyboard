//
//  ViewController.swift
//  KeyboardCustomAppOnly
//
//  Created by Marcy Vernon on 7/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var hexField: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = hexField.map { createKeyboard($0) }
        addPositionFinderButton()
    }

    private func addPositionFinderButton() {
        let btn = UIButton(type: .system)
        btn.setTitle("⚽  Find Your Soccer Position", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 14
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(showPositionFinder), for: .touchUpInside)
        view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            btn.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

    @objc private func showPositionFinder() {
        let selectorVC = SportSelectorViewController()
        selectorVC.onSportSelected = { [weak self] sport in
            self?.showDetail(for: sport)
        }
        let nav = UINavigationController(rootViewController: selectorVC)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }

    private func showDetail(for sport: Sport) {
        guard let nav = presentedViewController as? UINavigationController else { return }
        let detailVC = SportDetailViewController(sport: sport)
        detailVC.onResult = { [weak nav] archetype in
            let resultVC = ArchetypeResultViewController(archetype: archetype)
            nav?.pushViewController(resultVC, animated: true)
        }
        nav.pushViewController(detailVC, animated: true)
    }
    
    
    func createKeyboard(_ textField: UITextField) {
        textField.backgroundColor = .systemGroupedBackground
        textField.clearButtonMode = .whileEditing
        textField.inputView = HexadecimalKeyboard(target: textField)
    }
    
    
    @IBAction func clickTextField(_ sender: UITextField) {
        sender.reloadInputViews()
    }
    
} // end of View Controller
    

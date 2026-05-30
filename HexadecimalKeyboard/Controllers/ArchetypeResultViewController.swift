import UIKit

class ArchetypeResultViewController: UIViewController {

    private let archetype: SoccerArchetype

    init(archetype: SoccerArchetype) {
        self.archetype = archetype
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Position"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done", style: .done, target: self, action: #selector(doneTapped))
        buildUI()
    }

    private func buildUI() {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)

        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(content)

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            content.topAnchor.constraint(equalTo: scroll.topAnchor),
            content.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            content.widthAnchor.constraint(equalTo: scroll.widthAnchor),
        ])

        let accent = color(from: archetype.accentColor)

        // Badge
        let badge = UIView()
        badge.backgroundColor = accent.withAlphaComponent(0.15)
        badge.layer.cornerRadius = 60
        badge.layer.borderWidth = 3
        badge.layer.borderColor = accent.cgColor
        badge.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(badge)
        NSLayoutConstraint.activate([
            badge.widthAnchor.constraint(equalToConstant: 120),
            badge.heightAnchor.constraint(equalToConstant: 120),
            badge.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            badge.topAnchor.constraint(equalTo: content.topAnchor, constant: 32),
        ])

        let codeLabel = UILabel()
        codeLabel.text = archetype.positionCode
        codeLabel.font = .boldSystemFont(ofSize: 28)
        codeLabel.textColor = accent
        codeLabel.textAlignment = .center
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        badge.addSubview(codeLabel)
        NSLayoutConstraint.activate([
            codeLabel.centerXAnchor.constraint(equalTo: badge.centerXAnchor),
            codeLabel.centerYAnchor.constraint(equalTo: badge.centerYAnchor),
        ])

        // Position name
        let positionLabel = UILabel()
        positionLabel.text = archetype.position
        positionLabel.font = .boldSystemFont(ofSize: 26)
        positionLabel.textAlignment = .center
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(positionLabel)

        // Archetype name
        let archetypeLabel = UILabel()
        archetypeLabel.text = archetype.archetypeName
        archetypeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        archetypeLabel.textColor = accent
        archetypeLabel.textAlignment = .center
        archetypeLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(archetypeLabel)

        // Description card
        let descCard = makeCard(accent: accent)
        let descLabel = UILabel()
        descLabel.text = archetype.description
        descLabel.font = .systemFont(ofSize: 15)
        descLabel.textColor = .label
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .natural
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descCard.addSubview(descLabel)
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: descCard.topAnchor, constant: 14),
            descLabel.leadingAnchor.constraint(equalTo: descCard.leadingAnchor, constant: 14),
            descLabel.trailingAnchor.constraint(equalTo: descCard.trailingAnchor, constant: -14),
            descLabel.bottomAnchor.constraint(equalTo: descCard.bottomAnchor, constant: -14),
        ])
        content.addSubview(descCard)

        // Traits card
        let traitsCard = makeCard(accent: accent)
        let traitsTitle = UILabel()
        traitsTitle.text = "Key Traits"
        traitsTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        traitsTitle.textColor = .secondaryLabel
        traitsTitle.textTransform()
        traitsTitle.translatesAutoresizingMaskIntoConstraints = false
        traitsCard.addSubview(traitsTitle)

        let traitsStack = UIStackView()
        traitsStack.axis = .vertical
        traitsStack.spacing = 8
        traitsStack.translatesAutoresizingMaskIntoConstraints = false
        traitsCard.addSubview(traitsStack)

        for trait in archetype.traits {
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 8
            row.alignment = .center

            let dot = UIView()
            dot.backgroundColor = accent
            dot.layer.cornerRadius = 4
            dot.widthAnchor.constraint(equalToConstant: 8).isActive = true
            dot.heightAnchor.constraint(equalToConstant: 8).isActive = true
            row.addArrangedSubview(dot)

            let traitLabel = UILabel()
            traitLabel.text = trait
            traitLabel.font = .systemFont(ofSize: 15)
            row.addArrangedSubview(traitLabel)

            traitsStack.addArrangedSubview(row)
        }

        NSLayoutConstraint.activate([
            traitsTitle.topAnchor.constraint(equalTo: traitsCard.topAnchor, constant: 14),
            traitsTitle.leadingAnchor.constraint(equalTo: traitsCard.leadingAnchor, constant: 14),
            traitsStack.topAnchor.constraint(equalTo: traitsTitle.bottomAnchor, constant: 10),
            traitsStack.leadingAnchor.constraint(equalTo: traitsCard.leadingAnchor, constant: 14),
            traitsStack.trailingAnchor.constraint(equalTo: traitsCard.trailingAnchor, constant: -14),
            traitsStack.bottomAnchor.constraint(equalTo: traitsCard.bottomAnchor, constant: -14),
        ])
        content.addSubview(traitsCard)

        // Player comparison card
        let compCard = makeCard(accent: accent)
        compCard.backgroundColor = accent.withAlphaComponent(0.1)
        let compLabel = UILabel()
        compLabel.text = archetype.playerComparison
        compLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        compLabel.textColor = accent
        compLabel.textAlignment = .center
        compLabel.translatesAutoresizingMaskIntoConstraints = false
        compCard.addSubview(compLabel)
        NSLayoutConstraint.activate([
            compLabel.topAnchor.constraint(equalTo: compCard.topAnchor, constant: 14),
            compLabel.leadingAnchor.constraint(equalTo: compCard.leadingAnchor, constant: 14),
            compLabel.trailingAnchor.constraint(equalTo: compCard.trailingAnchor, constant: -14),
            compLabel.bottomAnchor.constraint(equalTo: compCard.bottomAnchor, constant: -14),
        ])
        content.addSubview(compCard)

        // Try Again button
        let tryAgainBtn = UIButton(type: .system)
        tryAgainBtn.setTitle("Try Another Sport", for: .normal)
        tryAgainBtn.titleLabel?.font = .systemFont(ofSize: 16)
        tryAgainBtn.setTitleColor(.secondaryLabel, for: .normal)
        tryAgainBtn.translatesAutoresizingMaskIntoConstraints = false
        tryAgainBtn.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
        content.addSubview(tryAgainBtn)

        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: badge.bottomAnchor, constant: 16),
            positionLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            positionLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            archetypeLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 4),
            archetypeLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            archetypeLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            descCard.topAnchor.constraint(equalTo: archetypeLabel.bottomAnchor, constant: 20),
            descCard.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            descCard.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            traitsCard.topAnchor.constraint(equalTo: descCard.bottomAnchor, constant: 12),
            traitsCard.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            traitsCard.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            compCard.topAnchor.constraint(equalTo: traitsCard.bottomAnchor, constant: 12),
            compCard.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            compCard.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            tryAgainBtn.topAnchor.constraint(equalTo: compCard.bottomAnchor, constant: 20),
            tryAgainBtn.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            tryAgainBtn.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -32),
        ])
    }

    private func makeCard(accent: UIColor) -> UIView {
        let card = UIView()
        card.backgroundColor = .secondarySystemBackground
        card.layer.cornerRadius = 14
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }

    private func color(from hex: String) -> UIColor {
        var h = hex.trimmingCharacters(in: .init(charactersIn: "#"))
        if h.count == 6 { h = "FF" + h }
        guard h.count == 8, let value = UInt64(h, radix: 16) else { return .systemBlue }
        return UIColor(
            red:   CGFloat((value & 0x00FF0000) >> 16) / 255,
            green: CGFloat((value & 0x0000FF00) >> 8)  / 255,
            blue:  CGFloat( value & 0x000000FF)         / 255,
            alpha: CGFloat((value & 0xFF000000) >> 24)  / 255
        )
    }

    @objc private func doneTapped() {
        dismiss(animated: true)
    }

    @objc private func tryAgainTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// Small helper to uppercase a label's text for section headers
private extension UILabel {
    func textTransform() {
        text = text?.uppercased()
    }
}

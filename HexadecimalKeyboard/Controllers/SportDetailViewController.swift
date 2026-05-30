import UIKit

class SportDetailViewController: UIViewController {

    private let sport: Sport
    var onResult: ((SoccerArchetype) -> Void)?

    private var selectedHandicap: Int = 12
    private var selectedGolferType: GolferType = .allAround
    private var golferTypeButtons: [UIButton] = []
    private var handicapValueLabel: UILabel?

    init(sport: Sport) {
        self.sport = sport
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = sport.rawValue
        view.backgroundColor = .systemBackground
        sport.isGolf ? buildGolfUI() : buildPositionUI()
    }

    // MARK: - Position UI

    private func buildPositionUI() {
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

        let header = UILabel()
        header.text = "\(sport.emoji)  What's your position?"
        header.font = .boldSystemFont(ofSize: 20)
        header.textAlignment = .center
        header.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(header)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(stack)

        for (i, position) in sport.positions.enumerated() {
            let btn = UIButton(type: .system)
            btn.setTitle(position, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            btn.backgroundColor = .secondarySystemBackground
            btn.layer.cornerRadius = 12
            btn.heightAnchor.constraint(equalToConstant: 54).isActive = true
            btn.tag = i
            btn.addTarget(self, action: #selector(positionTapped(_:)), for: .touchUpInside)
            stack.addArrangedSubview(btn)
        }

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: content.topAnchor, constant: 24),
            header.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -24),
        ])
    }

    // MARK: - Golf UI

    private func buildGolfUI() {
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

        let outer = UIStackView()
        outer.axis = .vertical
        outer.spacing = 28
        outer.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(outer)

        outer.addArrangedSubview(buildHandicapSection())
        outer.addArrangedSubview(buildGolferTypeSection())

        let submitBtn = UIButton(type: .system)
        submitBtn.setTitle("Find My Position  →", for: .normal)
        submitBtn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        submitBtn.backgroundColor = .systemGreen
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.layer.cornerRadius = 14
        submitBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        submitBtn.addTarget(self, action: #selector(golfSubmitTapped), for: .touchUpInside)
        outer.addArrangedSubview(submitBtn)

        NSLayoutConstraint.activate([
            outer.topAnchor.constraint(equalTo: content.topAnchor, constant: 24),
            outer.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            outer.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            outer.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -24),
        ])
    }

    private func buildHandicapSection() -> UIView {
        let section = UIView()

        let title = UILabel()
        title.text = "⛳  What's your handicap?"
        title.font = .boldSystemFont(ofSize: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(title)

        let valueLabel = UILabel()
        valueLabel.text = "\(selectedHandicap)"
        valueLabel.font = .monospacedDigitSystemFont(ofSize: 48, weight: .bold)
        valueLabel.textColor = .systemGreen
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(valueLabel)
        handicapValueLabel = valueLabel

        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 36
        slider.value = Float(selectedHandicap)
        slider.tintColor = .systemGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handicapChanged(_:)), for: .valueChanged)
        section.addSubview(slider)

        let minLabel = UILabel()
        minLabel.text = "Scratch (0)"
        minLabel.font = .systemFont(ofSize: 12)
        minLabel.textColor = .secondaryLabel
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(minLabel)

        let maxLabel = UILabel()
        maxLabel.text = "36+"
        maxLabel.font = .systemFont(ofSize: 12)
        maxLabel.textColor = .secondaryLabel
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(maxLabel)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: section.topAnchor),
            title.leadingAnchor.constraint(equalTo: section.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: section.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            valueLabel.centerXAnchor.constraint(equalTo: section.centerXAnchor),
            slider.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            slider.leadingAnchor.constraint(equalTo: section.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: section.trailingAnchor),
            minLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 4),
            minLabel.leadingAnchor.constraint(equalTo: section.leadingAnchor),
            maxLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 4),
            maxLabel.trailingAnchor.constraint(equalTo: section.trailingAnchor),
            minLabel.bottomAnchor.constraint(equalTo: section.bottomAnchor),
        ])
        return section
    }

    private func buildGolferTypeSection() -> UIView {
        let section = UIView()

        let title = UILabel()
        title.text = "🏌️  What type of golfer are you?"
        title.font = .boldSystemFont(ofSize: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(title)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(stack)

        golferTypeButtons.removeAll()
        for (i, type) in GolferType.allCases.enumerated() {
            let btn = makeGolferTypeButton(type, index: i)
            golferTypeButtons.append(btn)
            stack.addArrangedSubview(btn)
        }
        updateGolferTypeButtonStyles()

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: section.topAnchor),
            title.leadingAnchor.constraint(equalTo: section.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: section.trailingAnchor),
            stack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: section.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: section.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: section.bottomAnchor),
        ])
        return section
    }

    private func makeGolferTypeButton(_ type: GolferType, index: Int) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 12
        btn.layer.borderWidth = 0
        btn.layer.borderColor = UIColor.systemGreen.cgColor
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        btn.tag = index
        btn.addTarget(self, action: #selector(golferTypeTapped(_:)), for: .touchUpInside)

        let inner = UIStackView()
        inner.axis = .vertical
        inner.spacing = 2
        inner.alignment = .center
        inner.isUserInteractionEnabled = false
        inner.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(inner)
        NSLayoutConstraint.activate([
            inner.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            inner.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            inner.leadingAnchor.constraint(greaterThanOrEqualTo: btn.leadingAnchor, constant: 8),
            inner.trailingAnchor.constraint(lessThanOrEqualTo: btn.trailingAnchor, constant: -8),
        ])

        let nameLabel = UILabel()
        nameLabel.text = "\(type.emoji)  \(type.rawValue)"
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.textColor = .label
        inner.addArrangedSubview(nameLabel)

        let descLabel = UILabel()
        descLabel.text = type.blurb
        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = .secondaryLabel
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 2
        inner.addArrangedSubview(descLabel)

        return btn
    }

    private func updateGolferTypeButtonStyles() {
        for (i, btn) in golferTypeButtons.enumerated() {
            let selected = GolferType.allCases[i] == selectedGolferType
            UIView.animate(withDuration: 0.15) {
                btn.backgroundColor = selected
                    ? UIColor.systemGreen.withAlphaComponent(0.15)
                    : .secondarySystemBackground
                btn.layer.borderWidth = selected ? 2 : 0
            }
        }
    }

    // MARK: - Actions

    @objc private func positionTapped(_ sender: UIButton) {
        let position = sport.positions[sender.tag]
        let archetype = ArchetypeEngine.archetype(sport: sport, position: position)
        onResult?(archetype)
    }

    @objc private func handicapChanged(_ sender: UISlider) {
        selectedHandicap = Int(sender.value)
        handicapValueLabel?.text = "\(selectedHandicap)"
    }

    @objc private func golferTypeTapped(_ sender: UIButton) {
        selectedGolferType = GolferType.allCases[sender.tag]
        updateGolferTypeButtonStyles()
    }

    @objc private func golfSubmitTapped() {
        let archetype = ArchetypeEngine.archetypeForGolf(handicap: selectedHandicap, type: selectedGolferType)
        onResult?(archetype)
    }
}

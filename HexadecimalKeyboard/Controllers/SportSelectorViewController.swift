import UIKit

class SportSelectorViewController: UIViewController {

    var onSportSelected: ((Sport) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Best Sport"
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
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

        let header = UILabel()
        header.text = "⚽ Find Your Soccer Position"
        header.font = .boldSystemFont(ofSize: 22)
        header.textAlignment = .center
        header.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(header)

        let sub = UILabel()
        sub.text = "What sport have you played the most?"
        sub.font = .systemFont(ofSize: 15)
        sub.textColor = .secondaryLabel
        sub.textAlignment = .center
        sub.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(sub)

        let grid = makeGrid()
        grid.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(grid)

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: content.topAnchor, constant: 24),
            header.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            sub.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 6),
            sub.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            sub.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            grid.topAnchor.constraint(equalTo: sub.bottomAnchor, constant: 20),
            grid.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            grid.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            grid.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -24),
        ])
    }

    private func makeGrid() -> UIStackView {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 12

        var index = 0
        let sports = Sport.allCases
        while index < sports.count {
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 12
            row.distribution = .fillEqually

            row.addArrangedSubview(makeSportCard(sports[index]))
            index += 1

            if index < sports.count {
                row.addArrangedSubview(makeSportCard(sports[index]))
                index += 1
            } else {
                row.addArrangedSubview(UIView())
            }

            vStack.addArrangedSubview(row)
        }
        return vStack
    }

    private func makeSportCard(_ sport: Sport) -> UIButton {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 14
        btn.heightAnchor.constraint(equalToConstant: 88).isActive = true
        btn.tag = Sport.allCases.firstIndex(of: sport) ?? 0
        btn.addTarget(self, action: #selector(sportTapped(_:)), for: .touchUpInside)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: btn.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: btn.trailingAnchor, constant: -8),
        ])

        let emoji = UILabel()
        emoji.text = sport.emoji
        emoji.font = .systemFont(ofSize: 30)
        stack.addArrangedSubview(emoji)

        let name = UILabel()
        name.text = sport.rawValue
        name.font = .systemFont(ofSize: 12, weight: .semibold)
        name.textColor = .label
        name.textAlignment = .center
        name.numberOfLines = 2
        stack.addArrangedSubview(name)

        return btn
    }

    @objc private func sportTapped(_ sender: UIButton) {
        let sport = Sport.allCases[sender.tag]
        onSportSelected?(sport)
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

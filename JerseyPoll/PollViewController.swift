import UIKit

class PollViewController: UIViewController {

    private let poll: JerseyPoll
    private let canVote: Bool
    var onVote: ((JerseyPoll) -> Void)?
    var onSend: (() -> Void)?

    init(poll: JerseyPoll, canVote: Bool) {
        self.poll = poll
        self.canVote = canVote
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        buildUI()
    }

    private func buildUI() {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -16),
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor, constant: -32),
        ])

        let title = UILabel()
        title.text = "⚽ Jersey Poll"
        title.font = .boldSystemFont(ofSize: 20)
        title.textAlignment = .center
        stack.addArrangedSubview(title)

        let subtitle = UILabel()
        subtitle.text = canVote ? "Tap to cast your vote" : "Vote for your favorite jersey"
        subtitle.font = .systemFont(ofSize: 13)
        subtitle.textColor = .secondaryLabel
        subtitle.textAlignment = .center
        stack.addArrangedSubview(subtitle)

        let divider = UIView()
        divider.backgroundColor = .separator
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        stack.addArrangedSubview(divider)

        for (i, option) in poll.options.enumerated() {
            stack.addArrangedSubview(makeOptionRow(option: option, index: i))
        }

        if !canVote {
            let sendBtn = UIButton(type: .system)
            sendBtn.setTitle("Send Poll", for: .normal)
            sendBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
            sendBtn.backgroundColor = .systemBlue
            sendBtn.setTitleColor(.white, for: .normal)
            sendBtn.layer.cornerRadius = 10
            sendBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
            sendBtn.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
            stack.addArrangedSubview(sendBtn)
        }
    }

    private func makeOptionRow(option: JerseyOption, index: Int) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 10
        container.tag = index
        container.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let nameLabel = UILabel()
        nameLabel.text = option.name
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        let total = poll.totalVotes
        let pct = total > 0 ? Int(Double(option.votes) / Double(total) * 100) : 0

        let voteLabel = UILabel()
        voteLabel.text = "\(pct)%"
        voteLabel.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        voteLabel.textColor = .secondaryLabel
        voteLabel.translatesAutoresizingMaskIntoConstraints = false

        let progress = UIProgressView()
        progress.progress = total > 0 ? Float(option.votes) / Float(total) : 0
        progress.tintColor = .systemBlue
        progress.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(nameLabel)
        container.addSubview(voteLabel)
        container.addSubview(progress)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            voteLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            voteLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            progress.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            progress.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            progress.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
        ])

        if canVote {
            let tap = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
            container.addGestureRecognizer(tap)
            container.isUserInteractionEnabled = true
        }

        return container
    }

    @objc private func optionTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        var updated = poll
        updated.options[index].votes += 1
        onVote?(updated)
    }

    @objc private func sendTapped() {
        onSend?()
    }
}

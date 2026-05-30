import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        presentPoll(for: conversation)
    }

    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else { return }
        presentPoll(for: conversation)
    }

    private func presentPoll(for conversation: MSConversation) {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        let poll: JerseyPoll
        let canVote: Bool

        if let message = conversation.selectedMessage,
           let url = message.url,
           let decoded = JerseyPoll.from(url: url) {
            poll = decoded
            canVote = true
        } else {
            poll = JerseyPoll.defaultPoll()
            canVote = false
        }

        let pollVC = PollViewController(poll: poll, canVote: canVote)
        pollVC.onVote = { [weak self] updated in
            self?.send(poll: updated, in: conversation)
        }
        pollVC.onSend = { [weak self] in
            self?.send(poll: poll, in: conversation)
        }

        addChild(pollVC)
        pollVC.view.frame = view.bounds
        pollVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(pollVC.view)
        pollVC.didMove(toParent: self)
    }

    private func send(poll: JerseyPoll, in conversation: MSConversation) {
        var components = URLComponents()
        components.queryItems = [poll.toURLQueryItem()].compactMap { $0 }
        guard let url = components.url else { return }

        let layout = MSMessageTemplateLayout()
        layout.caption = "⚽ Jersey Poll"
        layout.subcaption = poll.options.max(by: { $0.votes < $1.votes })?.name
        layout.trailingCaption = "\(poll.totalVotes) vote\(poll.totalVotes == 1 ? "" : "s")"

        let message = MSMessage(session: conversation.selectedMessage?.session ?? MSSession())
        message.url = url
        message.layout = layout

        conversation.insert(message) { [weak self] _ in
            self?.dismiss()
        }
    }
}

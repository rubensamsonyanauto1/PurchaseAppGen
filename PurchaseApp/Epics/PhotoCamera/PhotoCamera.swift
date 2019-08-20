import Model
import RxSwift
import EventResponder

enum PhotoCamera {} //namespace

extension PhotoCamera {
    struct Context {
        let translator: Observable<Translator>
    }

    struct InputData {
    }

    enum Event: EventType {
    }

    enum PresentEvent: EventType {
        case present(InputData)
    }
}
import SkeletonCore
import Commander

command(
    Argument<String>("name", description: "Name of module"),
    Option("folder", default: "PurchaseApp/Epics", description: "Parent folder name of module relative to script folder."),
    Option("type", default: "basic", description: "Templates group type")
) { name, folder, type in
    let input = Input(name: name, folder: folder, type: type)
    let tool = Skeleton(input: input)

    do {
        try tool.run()
    } catch {
        print("Whoops! An error occurred: \(error)")
    }
}.run()

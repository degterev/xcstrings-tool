import Foundation
import PackagePlugin

private let stringResourceExtensions: Set<String> = ["xcstrings", "strings", "stringsdict"]
private let ignoreExtensions: Set<String> = ["lproj"]

extension FileList {
    var stringResources: [File] {
        self.filter { stringResourceExtensions.contains($0.path.extension ?? "") && !ignoreExtensions.contains($0.path.extension ?? "") }
    }
    
    var stringTables: [(tableName: String, files: [File])] {
        Dictionary(grouping: stringResources, by: \.path.stem)
            .map { ($0.key, $0.value) }
            .sorted(by: { $0.tableName.localizedStandardCompare($1.tableName) == .orderedAscending })
    }
}

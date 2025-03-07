//
//  main.swift
//  FileSorter
//
//  Created by Pankaj Kulkarni on 7/3/25.
//

import Foundation

func sortFile(inputFilePath: String, outputFilePath: String) {
    do {
        let fileContent = try String(contentsOfFile: inputFilePath, encoding: .utf8)
        // Filter out blank lines
        let lines = fileContent.components(separatedBy: "\n").filter { !$0.isEmpty }

        // Sort the lines alphabetically (case insensitive)
        let sortedLines = lines.sorted { $0.lowercased() < $1.lowercased() }

        // Write the sorted lines to the output file
        try sortedLines.joined(separator: "\n").write(toFile: outputFilePath, atomically: true, encoding: .utf8)

        print("File sorted successfully!")
    } catch {
        print("Error: \(error)")
    }
}


// 4. Command-line argument handling
if CommandLine.arguments.count != 3 {
    print("Usage: FileSorter <input_file> <output_file>")
    exit(1)
}

let inputFilePath = CommandLine.arguments[1]
let outputFilePath = CommandLine.arguments[2]

sortFile(inputFilePath: inputFilePath, outputFilePath: outputFilePath)



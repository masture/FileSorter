//
//  main.swift
//  FileSorter
//
//  Created by Pankaj Kulkarni on 7/3/25.
//

import Foundation

func sortFile(inputFilePath: String, outputFilePath: String? = nil) {
    do {
        let fileContent = try String(contentsOfFile: inputFilePath, encoding: .utf8)
        let lines = fileContent.components(separatedBy: "\n").filter { !$0.isEmpty }
        let sortedLines = lines.sorted { $0.lowercased() < $1.lowercased() }

        // Determine the output file path if not provided
        let outputPath: String
        if let outputFilePath = outputFilePath {
            outputPath = outputFilePath
        } else {
            // Get the file name and extension from the input file path
            let fileName = inputFilePath.components(separatedBy: "/").last!
            let fileExtension = fileName.components(separatedBy: ".").last!
            // Construct the output file path in the same directory as the input file
            outputPath = inputFilePath.replacingOccurrences(of: fileName, with: fileName.replacingOccurrences(of: ".", with: "_output."))
        }

        try sortedLines.joined(separator: "\n").write(toFile: outputPath, atomically: true, encoding: .utf8)
        print("File sorted successfully and saved to \(outputPath)!")
    } catch {
        print("Error: \(error)")
    }
}

// Command-line argument handling
if CommandLine.arguments.count < 2 || CommandLine.arguments.count > 3 {
    print("Usage: FileSorter <input_file> [output_file]")
    exit(1)
}

let inputFilePath = CommandLine.arguments[1]
let outputFilePath = CommandLine.arguments.count == 3 ? CommandLine.arguments[2] : nil

sortFile(inputFilePath: inputFilePath, outputFilePath: outputFilePath)

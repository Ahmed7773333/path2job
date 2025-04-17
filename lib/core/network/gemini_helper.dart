import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:async';

class GeminiHelper {
  final Gemini _gemini = Gemini.instance;

  // Stream methods
  Stream<String> streamAPlan(String wantedJob) {
    String prompt = '''
    Generate a sorted list of 5 course links (Coursera/Udemy) for a $wantedJob. 
    Format: ["title|url", ...]. Only return the list.
    Example: ["Flutter Development|https://www.coursera.org/learn/flutter"]
    ''';

    final controller = StreamController<String>();
    
    _gemini.promptStream(parts: [Part.text(prompt)]).listen((response) {
      controller.add(response?.output ?? '');
    }, onDone: () {
      controller.close();
    }, onError: (error) {
      controller.addError(error);
      controller.close();
    });

    return controller.stream;
  }

  Stream<String> streamAListOfSkills(String wantedJob) {
    String prompt = '''
    List 10 essential technical skills for a $wantedJob. 
    Format: ["skill1", "skill2", ...]. No explanations.
    ''';

    final controller = StreamController<String>();
    
    _gemini.promptStream(parts: [Part.text(prompt)]).listen((response) {
      controller.add(response?.output ?? '');
    }, onDone: () {
      controller.close();
    }, onError: (error) {
      controller.addError(error);
      controller.close();
    });

    return controller.stream;
  }

  Stream<String> streamAProfileText(String wantedJob) {
    String prompt = '''
    Create a 3-line professional profile for a $wantedJob CV. 
    Focus on technical abilities. No markdown.
    Example: "Flutter developer with 3+ years experience building..." 
    ''';

    final controller = StreamController<String>();
    
    _gemini.promptStream(parts: [Part.text(prompt)]).listen((response) {
      controller.add(response?.output ?? '');
    }, onDone: () {
      controller.close();
    }, onError: (error) {
      controller.addError(error);
      controller.close();
    });

    return controller.stream;
  }

  Stream<String> streamAListOfQA(String wantedJob) {
    String prompt = '''
    Generate 5 common interview Q&A for $wantedJob. 
    Format: {"Q1": "A1", "Q2": "A2", ...}. 
    Answers should be under 50 words.
    ''';

    final controller = StreamController<String>();
    
    _gemini.promptStream(parts: [Part.text(prompt)]).listen((response) {
      controller.add(response?.output ?? '');
    }, onDone: () {
      controller.close();
    }, onError: (error) {
      controller.addError(error);
      controller.close();
    });

    return controller.stream;
  }

  // Helper methods to process streams into usable data
  Future<List<String>> collectStreamToList(Stream<String> stream) async {
    final completeResponse = await _collectStreamToString(stream);
    return _parseListResponse(completeResponse);
  }

  Future<String> collectStreamToString(Stream<String> stream) async {
    return await _collectStreamToString(stream);
  }

  Future<Map<String, String>> collectStreamToMap(Stream<String> stream) async {
    final completeResponse = await _collectStreamToString(stream);
    return _parseMapResponse(completeResponse);
  }

  // Private helper to accumulate stream chunks into a complete string
  Future<String> _collectStreamToString(Stream<String> stream) async {
    final buffer = StringBuffer();
    await for (final chunk in stream) {
      buffer.write(chunk);
    }
    return buffer.toString();
  }

  // Original parsing methods
  List<String> _parseListResponse(String? response) {
    if (response == null || response.isEmpty) return [];
    
    try {
      // First, try to handle it as a proper JSON list if possible
      if (response.trim().startsWith('[') && response.trim().endsWith(']')) {
        final cleanedResponse = response
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',')
            .map((e) => e.trim().replaceAll('"', '').replaceAll("'", ''))
            .where((e) => e.isNotEmpty)
            .toList();
        return cleanedResponse;
      } else {
        // Handle plain text responses by splitting at newlines
        return response
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
    } catch (e) {
      print('Error parsing list response: $e');
      return [];
    }
  }

  Map<String, String> _parseMapResponse(String? response) {
    final map = <String, String>{};
    if (response == null || response.isEmpty) return map;
    
    try {
      // Try to handle common Q&A response formats
      if (response.contains(':')) {
        final entries = response
            .replaceAll('{', '')
            .replaceAll('}', '')
            .split(RegExp(r',(?=\s*"?\w+"|Q\d+)')) // Split on commas followed by keys
            .map((e) {
              final parts = e.split(':');
              if (parts.length >= 2) {
                final key = parts[0].trim().replaceAll('"', '').replaceAll("'", '');
                final value = parts.sublist(1).join(':').trim().replaceAll('"', '').replaceAll("'", '');
                return [key, value];
              }
              return null;
            })
            .where((e) => e != null)
            .cast<List<String>>();

        for (final entry in entries) {
          map[entry[0]] = entry[1];
        }
      } else {
        // Handle Q&A in plain text format
        final lines = response.split('\n');
        String currentQuestion = '';
        
        for (final line in lines) {
          final trimmedLine = line.trim();
          if (trimmedLine.isEmpty) continue;
          
          if (trimmedLine.startsWith('Q') || trimmedLine.contains('?')) {
            currentQuestion = trimmedLine;
            map[currentQuestion] = '';
          } else if (currentQuestion.isNotEmpty) {
            map[currentQuestion] = (map[currentQuestion] ?? '') + ' ' + trimmedLine;
          }
        }
      }
      return map;
    } catch (e) {
      print('Error parsing map response: $e');
      return {};
    }
  }
}
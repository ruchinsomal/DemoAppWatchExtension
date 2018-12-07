//
//  RSArticles.swift
//  NickelFoxDemo
//
//  Created by Ruchin Somal on 07/12/18
//  Copyright (c) . All rights reserved.
//

import Foundation

public final class RSArticles: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let url = "url"
    static let author = "author"
    static let title = "title"
    static let content = "content"
    static let publishedAt = "publishedAt"
    static let source = "source"
    static let descriptionValue = "description"
    static let urlToImage = "urlToImage"
  }

  // MARK: Properties
  public var url: String?
  public var author: String?
  public var title: String?
  public var content: String?
  public var publishedAt: String?
  public var source: RSSource?
  public var descriptionValue: String?
  public var urlToImage: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    url = json[SerializationKeys.url].string
    author = json[SerializationKeys.author].string
    title = json[SerializationKeys.title].string
    content = json[SerializationKeys.content].string
    publishedAt = json[SerializationKeys.publishedAt].string
    source = RSSource(json: json[SerializationKeys.source])
    descriptionValue = json[SerializationKeys.descriptionValue].string
    urlToImage = json[SerializationKeys.urlToImage].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = author { dictionary[SerializationKeys.author] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = content { dictionary[SerializationKeys.content] = value }
    if let value = publishedAt { dictionary[SerializationKeys.publishedAt] = value }
    if let value = source { dictionary[SerializationKeys.source] = value.dictionaryRepresentation() }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = urlToImage { dictionary[SerializationKeys.urlToImage] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.author = aDecoder.decodeObject(forKey: SerializationKeys.author) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.content = aDecoder.decodeObject(forKey: SerializationKeys.content) as? String
    self.publishedAt = aDecoder.decodeObject(forKey: SerializationKeys.publishedAt) as? String
    self.source = aDecoder.decodeObject(forKey: SerializationKeys.source) as? RSSource
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.urlToImage = aDecoder.decodeObject(forKey: SerializationKeys.urlToImage) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(author, forKey: SerializationKeys.author)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(content, forKey: SerializationKeys.content)
    aCoder.encode(publishedAt, forKey: SerializationKeys.publishedAt)
    aCoder.encode(source, forKey: SerializationKeys.source)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(urlToImage, forKey: SerializationKeys.urlToImage)
  }

}

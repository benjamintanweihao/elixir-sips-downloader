# Extract a Set of Files from an Feed Item Description.
class ElixirSipsDownloader::Extractors::Files < ElixirSipsDownloader::Extractor
  # @param item_description [String] the feed item description extracted with
  #   `feed.items[i].description`.
  # @return [Set<ElixirSipsDownloader::Downloadables::File>] the Set of Files
  #   extracted from feed item description.
  def extract item_description
		require 'nokogiri'
    files = Set.new

    document = Nokogiri::XML(item_description)
		document.search("//a[contains(@href, 'download')]").each do |element|
      name = element.text
      link = element.attribute('href').to_s
      files << ElixirSipsDownloader::Downloadables::File.new(name, link)
		end
    files
  end
end

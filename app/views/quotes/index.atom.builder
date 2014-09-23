atom_feed do |feed|
  feed.title "#{@channel.name} quotes"
  feed.updated(@channel.quotes.maximum(:updated_at)) if @quotes.length > 0
  @quotes.each do |quote|
    feed.entry(quote) do |entry|
      entry.title(Quote.first.body.truncate(20))
      entry.content(quote.to_html, type: 'html')

      entry.author do |author|
        author.name(quote.owner.email)
      end
    end
  end
end
Book.destroy_all

loop do
  begin
    book = Book.create name: Faker::Book.unique.title,
                       isbn: 1_000_000 + Book.all.count
    p "\"#{book.name}\" created with ISBN: #{book.isbn}"
  rescue Faker::UniqueGenerator::RetryLimitExceeded
    p 'All unique books have been created'
    break
  end
end

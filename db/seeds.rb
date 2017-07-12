Book.destroy_all
begin
  loop do
    book = Book.create! name: Faker::Book.unique.title,
                        isbn: 1_000_000 + Book.all.count,
                        quantity: rand(0..3)
    p "\"#{book.name}\" created with ISBN: #{book.isbn}"
  end
rescue Faker::UniqueGenerator::RetryLimitExceeded
  p 'All unique books have been created'
end

User.destroy_all
User.create! email: 'test@te.st',
             password: '123456',
             password_confirmation: '123456'

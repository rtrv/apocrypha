require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { Book.new(name: 'Example', isbn: '123-456-789-0') }

  it 'is valid with name and isbn' do
    expect(book).to be_valid
  end

  it 'is valid with name, ISBN and positive quantity' do
    book.quantity = 10
    expect(book).to be_valid
  end

  it 'should have name' do
    expect(book).to validate_presence_of(:name)
  end

  it 'should have present and unique ISBN' do
    expect(book).to validate_uniqueness_of(:isbn).case_insensitive
    expect(book).to validate_presence_of(:isbn)
  end

  it 'should have not negative quantity' do
    expect(book).to(
      validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)
    )
  end

  it 'is not valid with anything besides digits and dashes in ISBN' do
    book.isbn = '123-45B-789-0'
    expect(book).not_to be_valid
  end
end

def demo_data
  [
    {
      title: "A Tale of Two Cities",
      author: "Charles Dickens",
      publication_date: Date.parse('31-12-1859'),
      first_purchased_at: Time.utc(1859,"jan",1,20,15,1),
      sold: 200_000_000
    },
    {
      title: "The Lord of the Rings",
      author: "J. R. R. Tolkien",
      publication_date: Date.parse('31-12-1954'),
      first_purchased_at: Time.utc(1954,"jan",1,20,15,1),
      sold: 150_000_000
    },
    {
      title: "The Little Prince (Le Petit Prince)",
      author: "Antoine de Saint-Exupery",
      publication_date: Date.parse('31-12-1943'),
      first_purchased_at: Time.utc(1943,"jan",1,20,15,1),
      sold: 140_000_000
    },
    {
      title: "The Hobbit",
      author: "J. R. R. Tolkien",
      publication_date: Date.parse('31-12-1937'),
      first_purchased_at: Time.utc(1937,"jan",1,20,15,1),
      sold: 100_000_000
    },
    {
      title: "Hong lou meng (Dream of the Red Chamber/The Story of the Stone)",
      author: "Cao Xueqin",
      publication_date: Date.parse('31-12-1754'),
      first_purchased_at: Time.utc(1754,"jan",1,20,15,1),
      sold: 100_000_000
    },
    {
      title: "And Then There Were None",
      author: "Agatha Christie",
      publication_date: Date.parse('31-12-1939'),
      first_purchased_at: Time.utc(1939,"jan",1,20,15,1),
      sold: 100_000_000
    }
  ]
end

def open_struct_books
  demo_data.collect {|d| OpenStruct.new(d) }
end
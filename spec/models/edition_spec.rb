require 'spec_helper'

describe Edition do
  it { should have_db_column(:id).of_type(:integer) }
  it { should have_db_column(:isbn10).of_type(:string) }
  it { should have_db_column(:image_url).of_type(:string) }
  it { should have_db_column(:year).of_type(:date) }
  it { should have_db_column(:readings_count).of_type(:integer) }
  it { should have_db_column(:ownings_count).of_type(:integer) }

  it { should belong_to :book }
  it { should belong_to :editor }
  it { should have_many(:readers).through(:readings).class_name("User") }
  it { should have_many :readings }
  it { should have_many :ownings }
  it { should have_many(:owners).through(:ownings).class_name("User") }
end

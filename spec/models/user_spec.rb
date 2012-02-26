require 'spec_helper'

describe User do
  it { should have_db_column(:readings_count).of_type(:integer) }
  it { should have_many(:read_editions).through(:readings).class_name("Edition") }
  it { should have_many(:owned_editions).through(:ownings).class_name("Edition") }
  it { should have_many(:ownings) }
  it { should have_many(:readings) }
end

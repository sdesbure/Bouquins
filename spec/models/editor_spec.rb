require 'spec_helper'

describe Editor do
  it { should have_db_column(:id).of_type(:integer) }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:website).of_type(:string) }
  it { should have_db_column(:logo).of_type(:string) }
  it { should have_db_column(:wikipedia_url).of_type(:string) }

  it { should have_many :editions }
  it { should have_many(:books).through(:editions) }
end

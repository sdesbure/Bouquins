require 'spec_helper'

describe Author do
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:wikipedia_url).of_type(:string) }
  it { should have_db_column(:image_url).of_type(:string) }

  it { should have_and_belong_to_many :books }

end

require 'spec_helper'

describe Rate do
  it { should belong_to(:rater).class_name(User) }
end

require 'spec_helper'

describe Review do
  it { validate_presence_of :rating }

  it { validate_presence_of :review_text }
  
  it { should belong_to :video }

  it { should belong_to :user}
end
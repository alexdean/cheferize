require 'spec_helper'
require_relative '../../../lib/cheferize/chef_string'

RSpec.describe Cheferize::ChefString do
  describe '#in_same_case_as' do
    it 'returns target string transformed into the same case as the first character of target' do
      subject = Cheferize::ChefString.new('a')
      expect(subject.in_same_case_as('B')).to eq 'A'

      subject = Cheferize::ChefString.new('a')
      expect(subject.in_same_case_as('b')).to eq 'a'

      subject = Cheferize::ChefString.new('A')
      expect(subject.in_same_case_as('B')).to eq 'A'

      subject = Cheferize::ChefString.new('A')
      expect(subject.in_same_case_as('b')).to eq 'a'
    end
  end
end

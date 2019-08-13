require 'spec_helper'
require_relative '../../lib/cheferize'

class String
  include Cheferize
end

RSpec.describe Cheferize do
  describe '#to_chef' do
    it 'does the bork' do
      subject = 'hello world'
      expect(subject.to_chef).to eq 'hellu vurld'
    end

    it 'does more borking' do
      subject = 'the quick brown fox jumped over the lazy dog'
      expect(subject.to_chef).to eq 'zee qooeeck broon fux joomped oofer zee lezy dug'
    end
  end
end

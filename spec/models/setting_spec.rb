require 'rails_helper'

RSpec.describe Setting, type: :model do

  context 'created without a name' do

    it 'is invalid' do
      setting = Setting.new
      expect(setting).to be_invalid
    end

  end

  context 'created with a name' do

    it 'is valid' do
      setting = Setting.new(name: 'foo')
      expect(setting).to be_valid
    end

  end

end

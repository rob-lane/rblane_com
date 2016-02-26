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

  context 'created without a type' do

    it "defaults to 'text'" do
      setting = Setting.create(name: 'foo')
      expect(setting.field_type).to eql('text')
      setting.destroy!
    end

  end

end

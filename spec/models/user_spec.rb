require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :tokens }
    it { is_expected.to have_db_column :role }
  end

  describe 'Associations' do
    it { is_expected.to have_many :articles }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:user)).to be_valid
    end
    
    it 'should have valid Factory' do
      expect(create(:journalist)).to be_valid
    end
  end
end

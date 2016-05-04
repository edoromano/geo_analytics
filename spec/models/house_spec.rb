require 'spec_helper'

describe House, type: :model do
  let(:house) { FactoryGirl.build :house }
  subject { house }

  it { should respond_to(:description) }
  it { should respond_to(:price) }
  it { should respond_to(:published) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:user_id) }

  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :user_id }

end

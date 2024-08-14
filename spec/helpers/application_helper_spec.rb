require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#bootstrap_class_for_flash' do
    it 'Generate class for flass[:success]' do
      expect(helper.bootstrap_class_for_flash('success')).to eq('alert-success')
    end
    it 'Generate class for flass[:error]' do
      expect(helper.bootstrap_class_for_flash('error')).to eq('alert-danger')
    end
    it 'Generate class for flass[:alert]' do
      expect(helper.bootstrap_class_for_flash('alert')).to eq('alert-warning')
    end
    it 'Generate class for flass[:notice]' do
      expect(helper.bootstrap_class_for_flash('notice')).to eq('alert-primary')
    end
    it 'Generate class for custom flash' do
      expect(helper.bootstrap_class_for_flash('custom-alert')).to eq('custom-alert')
    end
  end
end

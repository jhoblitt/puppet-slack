require 'spec_helper'

describe 'slack', :type => :class do

  describe 'for osfamily RedHat' do
    it { should contain_class('slack') }
  end

end

require 'spec_helper'

describe 'slack', :type => :class do

  describe 'for operatingsystem Fedora' do
    let(:facts) {{ :operatingsystem => 'Fedora' }}
    it { should contain_class('slack') }
  end
end

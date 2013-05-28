require 'spec_helper'

describe "ceph::osd" do

  let :facts do
    { :ipaddress => '2.4.6.8' }
  end

  it { should include_class('ceph::package') }

  it { shoudl contain_package('btrfs-tools') }
  it { should contain_package('parted') }

end

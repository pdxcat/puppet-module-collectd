require 'spec_helper'

describe 'collectd::plugin::libvirt', type: :class do
  let :pre_condition do
    'include ::collectd'
  end

  context 'interface_format in libvirt.conf' do
    let :params do
      { connection: 'qemu:///system',
        interface_format: 'address',
      }
    end

    context 'with collectd_version < 5.0' do
      let :facts do
        { osfamily: 'Debian',
          collectd_version: '4.10.1',
        }
      end

      it 'is ignored' do
        should contain_file('libvirt.load')
          .without_content(/.*InterfaceFormat \"address\".*/)
      end
    end

    context 'with collectd_version >= 5.0' do
      let :facts do
        { osfamily: 'Debian',
          collectd_version: '5.0.0',
        }
      end

      it 'is included' do
        should contain_file('libvirt.load')
          .with_content(/.*InterfaceFormat \"address\".*/)
      end
    end
  end
end

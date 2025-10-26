require 'spec_helper'

describe 'rspamd::config' do
  let(:title) { 'dkim_signing' }

  let(:params) do
    {
      value: {
        domain: {
          'example.org' => {
            selectors: [
              {
                path: "/usr/local/etc/rspamd/dkim-keys/20251021-rsa2048.key",
                selector: "20251021-rsa2048",
              },
              {
                path: "/usr/local/etc/rspamd/dkim-keys/20251021-ed25519.key",
                selector: "20251021-ed25519",
              }
            ]
          }
        }
      }
    }
  end

  it { is_expected.to contain_file('/etc/rspamd/local.d/dkim_signing.conf').with_content(<<~CONTENT) }
    {
      "domain": {
        "example.org": {
          "selectors": [
            {
              "path": "/usr/local/etc/rspamd/dkim-keys/20251021-rsa2048.key",
              "selector": "20251021-rsa2048"
            },
            {
              "path": "/usr/local/etc/rspamd/dkim-keys/20251021-ed25519.key",
              "selector": "20251021-ed25519"
            }
          ]
        }
      }
    }
  CONTENT
end

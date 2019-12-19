class Deadlinks < Formula
  include Language::Python::Virtualenv

  desc "CLI/API for links liveness checking"
  homepage "https://github.com/butuzov/deadlinks"
  url "https://files.pythonhosted.org/packages/47/1e/7658a413673bbb994a8fd3c4f54539bd954ef2b5500b43eaa9821079885b/deadlinks-0.2.1.tar.gz"
  sha256 "63f3fdc998a5938881b115d4faa78b3efbaf5323a23ae8cc0a379428d461fdf9"

  depends_on "python"

  resource "requests" do
    url "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz"
    sha256 "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/f8/5c/f60e9d8a1e77005f664b76ff8aeaee5bc05d0a91798afd7f53fc998dbc47/Click-7.0.tar.gz"
    sha256 "5b94b49521f6456670fdb30cd82a4eca9412788a93fa6dd6df72c94d5a8ff2d7"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/ad/fc/54d62fa4fc6e675678f9519e677dfc29b8964278d75333cf142892caf015/urllib3-1.25.7.tar.gz"
    sha256 "f3c5fd51747d450d4dcf6f923c81f78f811aab8205fda64b0aba34a4e48b0745"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/41/bf/9d214a5af07debc6acf7f3f257265618f1db242a3f8e49a9b516f24523a6/certifi-2019.11.28.tar.gz"
    sha256 "25b64c7da4cd7479594d035c08c2d809eb4aab3a26e5a990ea98cc450c320f1f"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz"
    sha256 "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # version assertion
    assert_match /#{version}/, shell_output("#{bin}/deadlinks --version")

    # deaddomain expected result
    (testpath/"localhost.localdomain.log").write <<~EOS
      ===========================================================================
      URL=<http://localhost.localdomain>; External Checks=Off; Threads=1; Retry=0
      ===========================================================================
      Links Total: 1; Found: 0; Not Found: 1; Ignored: 0; Redirects: 0
      ---------------------------------------------------------------------------\e[?25h
      [ failed ] http://localhost.localdomain
    EOS

    # deaddomain assertion
    output = shell_output("deadlinks localhost.localdomain --no-progress --no-colors")
    assert_equal (testpath/"localhost.localdomain.log").read, output
  end
end

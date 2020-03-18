class Deadlinks < Formula
  include Language::Python::Virtualenv

  desc "Health checks for your documentation links"
  homepage "https://github.com/butuzov/deadlinks"
  url "https://files.pythonhosted.org/packages/de/43/f4aa1e06c33a988b3d32d7faa9bf2c286966141d93978cfc64e576b8ec68/deadlinks-0.3.2.tar.gz"
  sha256 "85d1cc8cf7ffad76fa64563d94ffe7ddeec9c99467171f13cbe4e5bc67d6dd56"

  depends_on "python"

  resource "requests" do
    url "https://files.pythonhosted.org/packages/f5/4f/280162d4bd4d8aad241a21aecff7a6e46891b905a4341e7ab549ebaf7915/requests-2.23.0.tar.gz"
    sha256 "b3f43d496c6daba4493e7c431722aeb7dbc6288f52a6e04e7b6023b0247817e6"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/4e/ab/5d6bc3b697154018ef196f5b17d958fac3854e2efbc39ea07a284d4a6a9b/click-7.1.1.tar.gz"
    sha256 "8a18b4ea89d8820c5d0c7da8a64b2c324b4dabb695804dbfea19b9be9d88c0cc"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/09/06/3bc5b100fe7e878d3dee8f807a4febff1a40c213d2783e3246edde1f3419/urllib3-1.25.8.tar.gz"
    sha256 "87716c2d2a7121198ebcb7ce7cccf6ce5e9ba539041cfbaeecfb641dc0bf6acc"
  end

  resource "reppy" do
    url "https://files.pythonhosted.org/packages/b0/b9/8bb8a4cd95dfc6038fb721fad95da8e9558ec936688150302cbd7874c45c/reppy-0.4.14.tar.gz"
    sha256 "ad98ca17bfc39f543e81b85278f71ceaa1ba3f7c6817ff5a18f7305afa5fff87"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz"
    sha256 "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a"
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
    url "https://files.pythonhosted.org/packages/cb/19/57503b5de719ee45e83472f339f617b0c01ad75cba44aba1e4c97c2b0abd/idna-2.9.tar.gz"
    sha256 "7588d1c14ae4c77d74036e8c22ff447b26d0fde8f007354fd48a7814db15b7cb"
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

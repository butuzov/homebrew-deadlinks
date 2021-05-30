class Deadlinks < Formula
    include Language::Python::Virtualenv

    desc "Health checks for your documentation links"
    homepage "https://github.com/butuzov/deadlinks"
    url "https://files.pythonhosted.org/packages/c8/46/312cccc8715b2c4c21d643386e7e2419136242233e0396982bb28805229b/deadlinks-0.3.3.tar.gz"
    sha256 "085fe08e6556a327047cba7df525a4be57ec515e149c9bce444ea9c6a638c702"

    depends_on "python"

    resource "requests" do
      url "https://files.pythonhosted.org/packages/6b/47/c14abc08432ab22dc18b9892252efaf005ab44066de871e72a38d6af464b/requests-2.25.1.tar.gz"
      sha256 "27973dd4a904a4f13b263a19c866c13b92a39ed1c964655f025f3f8d3d75b804"
    end

    resource "click" do
      url "https://files.pythonhosted.org/packages/21/83/308a74ca1104fe1e3197d31693a7a2db67c2d4e668f20f43a2fca491f9f7/click-8.0.1.tar.gz"
      sha256 "8c04c11192119b1ef78ea049e0a6f0463e4c48ef00a30160c704337586f3ad7a"
    end

    resource "urllib3" do
      url "https://files.pythonhosted.org/packages/94/40/c396b5b212533716949a4d295f91a4c100d51ba95ea9e2d96b6b0517e5a5/urllib3-1.26.5.tar.gz"
      sha256 "a7acd0977125325f516bda9735fa7142b909a8d01e8b2e4c8108d0984e6e0098"
    end

    resource "six" do
      url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
      sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
    end

    resource "chardet" do
      url "https://files.pythonhosted.org/packages/ee/2d/9cdc2b527e127b4c9db64b86647d567985940ac3698eeabc7ffaccb4ea61/chardet-4.0.0.tar.gz"
      sha256 "0d6f53a15db4120f2b08c94f11e7d93d2c911ee118b6b30a04ec3ee8310179fa"
    end

    resource "certifi" do
      url "https://files.pythonhosted.org/packages/06/a9/cd1fd8ee13f73a4d4f491ee219deeeae20afefa914dfb4c130cfc9dc397a/certifi-2020.12.5.tar.gz"
      sha256 "1a4995114262bffbc2413b159f2a1a480c969de6e6eb13ee966d470af86af59c"
    end

    resource "idna" do
      url "https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005/idna-3.2.tar.gz"
      sha256 "467fbad99067910785144ce333826c71fb0e63a425657295239737f7ecd125f3"
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

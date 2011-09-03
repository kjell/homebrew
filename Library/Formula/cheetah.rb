require 'formula'

class Cheetah < Formula
  url 'http://pypi.python.org/packages/source/C/Cheetah/Cheetah-2.4.4.tar.gz#md5=853917116e731afbc8c8a43c37e6ddba'
  homepage 'http://cheetahtemplate.org/'
  md5 '853917116e731afbc8c8a43c37e6ddba'
  version '2.4.4'

  def cheetah_already_installed?
    quiet_system %W{/usr/bin/env python -c 'import Cheetah'}
  end

  def install
    ENV.prepend 'PYTHONPATH', "#{HOMEBREW_PREFIX}/lib/python", ':'
    unless cheetah_already_installed?
      quiet_system "mkdir -p #{HOMEBREW_PREFIX}/lib/python"
      safe_system "python setup.py install --install-lib #{HOMEBREW_PREFIX}/lib/python"
      @installed = true
    else
      ohai "Cheetah already installed in your system's python"
    end
  end

  def test
    ENV.prepend 'PYTHONPATH', "#{HOMEBREW_PREFIX}/lib/python", ':'
    cheetah_already_installed?
  end

  def caveats;
    return unless @installed
    <<-EOS
This formula won't function until you amend your PYTHONPATH like so:
    export PYTHONPATH=#{HOMEBREW_PREFIX}/lib/python:$PYTHONPATH
EOS
  end
end

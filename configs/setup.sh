#!/bin/bash
echo "nit dependencies..."
sudo yum install -y ccache libffi-devel libgc-devel graphviz libunwind-devel
echo "nit cloning..."
if [ ! -d /opt/nit ]; then
  cd ~/tmp
  rm -rf nit
  git clone git@github.com:irr/nit.git
  cd nit
  git remote add upstream https://github.com/privat/nit.git
  git fetch upstream && git merge upstream/master
  cd ..
  echo "nit deploying..."
  sudo rm -rf /opt/nit
  sudo mv nit /opt/
  sudo chown irocha: /opt/nit
fi
echo "nit building..."
cd /opt/nit
make 
make docs 
cd share/man 
make
cd
echo "nit vim configuring..."
rm -rf ~/.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle 
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle
rm -rf nit
ln -s /opt/nit/misc/vim nit
echo "nit environment"
sudo cp -v /opt/linux/libevent-release-2.0.22-stable/*.pc /usr/lib64/pkgconfig/
cd
rm -rf .bash_completion
ln -s ~/nit/configs/.bash_completion
rm -rf .bashrc
ln -s ~/nit/configs/.bashrc
rm -rf .vimrc
ln -s ~/nit/configs/.vimrc
echo "nit installed ok."

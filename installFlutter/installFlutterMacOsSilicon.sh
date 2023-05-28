function install_flutter() {
    git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
    echo PATH=\"\${PATH}:\${HOME}/flutter/bin\" >> ~/.zprofile
    echo export PATH >> ~/.zprofile
    source ~/.zprofile
    flutter doctor  --android-licenses
    flutter doctor
}

sudo softwareupdate --install-rosetta --agree-to-license
brew install cocoapods
install_flutter
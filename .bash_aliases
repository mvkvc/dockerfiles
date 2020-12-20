alias dbuild = 'docker build -f /dockerfiles/optcu110.dockerfile -t options-image .'
alias drun1 = 'docker run -i --gpus all --name options-container options-image -p 8888:8888'
alias drun = 'docker run -i --gpus all --name options-container -p 8888:8888'

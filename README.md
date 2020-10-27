## Adicionando executável ELF em imagens com o comando dd

O dd é uma ferramenta de linha de comando de baixo nível, presente nativamente como utilitário do kernel linux. O utilitário dd permite converter, formatar e copiar arquivos de discos preservando os mesmos dados e partições do disco de origem, sendo muito utilizado para efetuar backup de partições. Para mais detalhes, digite no terminal linux, o comando: 
```
$ man dd
```
Neste exemplos vamos concatenar um executável ELF em um aquivo de imagem. Primeiramente vamos instalar o compilador shc para compilar arquivos escritos em Shell script. O shc gera uma cópia do script em C e depois compila para o seu respectivo código binário. Para instalar o shc no linux debian e seus derivados:
```
$ sudo apt install shc
```
Vamos criar um arquivo Shell script arbitrário para inserir no arquivo de imagem:
```
$ cat << EOF > script_append.sh
#! /bin/sh
echo '[*] Payload!'
sleep 5
exit 0
EOF
```
Agora vamos compilar com shc o script:
```
$ shc -f script_append.sh -o script_append.bin
```
Adicione o diretório do ddapend e ddcut ao $PATH:
```
$ export PATH=$PATH:$(pwd) 
```
Ou de forma alternativa, crie links simbolicos no diretório /bin... :
```
$ ln -s $(pwd)/ddappend.sh /bin/ddappend && ln -s $(pwd)/ddcut.sh /bin/ddcut
```
Para concatenar o arquivo executável na imagem:
```
$ ddapend in.png script_append.bin
```
Entre na nova pasta que foi gerada no diretório corrente:
```
$ cd in.png_projeto 
$ ls
in.png.append  in.png.log
```
Agora temos o arquivo ELF concatenado na imagem e o arquivo in.png.log que contém o tamnho em bytes da imagem original.
Para extrair o arquivo executável da imagem:
```
$ ddcut in.png.append in.png.log
```
Teste o arquivo extraído:
```
$ ./in.png.append.out 
```
## Visualizualização interativa 
Usando o hexdump podemos visualizar as diferenças entre a imagem original e a imagem concatenada com o binário ELF:
```
$ hd in.png > in.txt
$ hd in.png.append > out.txt
```
![hexdump](https://github.com/tpaphysics/dd_append/blob/master/docs/hexdump.png)

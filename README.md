Alo 👋 

Luego de setear varias computadores con Mac OS para diferentes personas y principalmente para mí, decidí armar esta guía como recordatorio personal y para uso de otros. Es altamente probable que algunas cosas fallen en el camino, a no desesperar. Todas las respuestas están en google y stackoverflow. La idea es agilizar el proceso de instalación y configuración de algunas herramientas típicas de uso en IT. 
>💡 **pssss**  👉🏼  El listado de aplicaciones y tools a instalar es total y completamente personal, por lo que la idea es customizar a gusto.
Algunas son de uso exclusivo para sistemas (ejemplo git), otras de uso general (ej spotify 🎧), otras de uso mixto (ej Notion) y varias son afines a mis intereses/usos particulares.

> [Acá](https://sourabhbajaj.com/mac-setup/) hay buena data aunque algo vieja 

</br>

- [Homebrew](#homebrew)
  - [GUI soft](#gui-soft)
  - [CLI tools](#cli-tools)
- [Shell](#shell)
  - [Iterm look](#iterm-look)
  - [~~Bash~~ Hello zsh](#bash-hello-zsh)
  - [Venvs y otros lenguanges](#venvs-y-otros-lenguanges)
- [Conda defaults](#conda-defaults)
- [Fonts](#fonts)
- [Versionado](#versionado)
  - [Git](#git)
  - [SSH](#ssh)
  - [SSH pública en Github](#ssh-pública-en-github)


---

# Homebrew

[Homebrew](https://brew.sh/) o `brew` es una herramienta de línea de comando que permite en forma simple, instalar software. En palabras de sus creadores: `"The Missing Package Manager for macOS (or Linux)"`. La vamos a usar para instalar muchas cosas. Tiene varios comandos, pero en general se usan solo estos:
- `brew install <app>`: Software típicamente relacionado con la línea de comando (va a parar a _/usr/local/Cellar/_ y luego agrega symlinks en _/usr/local/bin/_ para que el OS lo encuentre). Se pueden poner varios paquetes e instala todos de una.
- `brew install --cask <app>` : Software con interfaz gráfica (típicamente va a parar a _/Applications/_). Se pueden poner varios paquetes e instala todos de una.
- `brew bundle --file path/to/Brewfile` (opcionalmente `brew bundle install` si el archivo está en el directorio donde estamos posicionados): Instala todo lo que esté en el archivo _Brewfile_, ergo nos permite instalar múltiples cosas de una. Estrictamente hablando, se podría instalar todo usando los dos primeros, pero a mi al menos me gusta usar este método para poder ir administrando el listado.
- `brew tap <tap_name>`: Agrega el repositorio _tap_name_ alternativo al "oficial" de homebrew. 

Para buscar qué está disponible en homebrew, ver la web del desarrollador de cada paquete/soft para saber más, etc.--> https://formulae.brew.sh

**Instalación**
1. Abrir la terminal.
2. Pegar:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Puede que nos pregunte cosas, por lo que hay que mirar la pantalla cada tanto. Al final nos pedirá que corramos otros dos comandos para terminar la instalación.
<br>

## GUI soft
El listado de las apps que instalaremos está en [Brewfile_cask_apps](./brewfiles/Brewfile_cask_apps.txt). Se pueden agregar o comentar las que no interesen. No hay ninguna diferencia funcional al final del proceso entre instalarlas de esta manera o bajar individualmente desde la web del desarrollador y luego arrastrar a la carpeta de Aplicaciones. 

> :point_right: Tip 1: Las aplicaciones sensibles en lo que respecta a seguridad, como administradores de contraseñas, 2FA, etc. recomiendo bajarlas de la web del desarrollador. Yo tengo listadas algunas que uso como recordatorio, pero en general las comento y no las instalo con este método.

> :point_right: Tip 2: Cada instalador que se sube al repositorio de `Homebrew` debería tener un hash SHA256 (secuencia alfanúmerica que identifica en forma unívoca a ese archivo tal y como es) para asegurarse de que no esté corrupto o modificado. Lamentablemente algunos no lo tienen (caso Dropbox o Google Drive al momento de la redacción de esta guía). El archivo con el listado de apps tiene un flag `require_sha: true` que hará que algunas apps fallen al intentar ser instaladas justamente por la ausencia de este hash en la información de la instalación que tiene homebrew. Queda a criterio personal sacar el flag para instalar todo sin errores o para aquellas que fallan, bajarlas luego de la web. 

1. Abrir terminal.
2. Pegar:
```shell
brew bundle --file /path/to/Brewfile_cask_apps.txt
```
Si son varias apps, tener paciencia. Homebrew a veces nos hará preguntas sobre el soft instalado, nos pedirá la conrtaseña, etc.  ```brew --cask <app_name>```

## CLI tools
El listado de las apps que instalaremos está en [Brewfile_cli_apps](./brewfiles/Brewfile_cli_apps.txt). Se trata de por ejemplo git, githhub cli, tmux, etc. Pueden buscar en la página de homebrew cada una y ver para qué sirve.

1. Abrir iterm si lo instalaron, o sino la terminal, y pegar
```shell
brew bundle --file /path/to/Brewfile_cli_apps.txt
```
2. Por algún motivo `z` no funciona directo, así que luego de googlear 


# Shell
Mac OS trae una aplicación de terminal por defecto, pero es un poco limitada, por lo que la mayoría de la gente utiliza alguna alternativa. Iterm es la más popular y está en la lista Brewfile de GUI apps, si no está instalada, recomiendo instalarla. De ahora en más cuando mencione la terminal, me refiero a iterm.

## Iterm look
💄 La apariencia de la terminal y la información que muestra es motivo de infinitos tutoriales y guías similares a estas con diversos grados de personalización y locura.

1. Themes. Hay $10^7$ color themes. [Acá un muestrario, instructivo y zip para bajarlos](https://iterm2colorschemes.com/). Cuando se configura el color te hace un preview de cómo se vería la terminal.
>iTerm → Preferences → Profiles → Colors → Color presets → Import. Luego elegir.
2. Por defecto hay un par de comandos básicos que no funcionan (borrar palabras con alt+backspace por ejemplo). Si quieren activarlos:
>iTerm → Preferences → Profiles → Keys → Load Preset… → Natural Text Editing

## ~~Bash~~ Hello zsh
### Zsh y ohmyzsh
Por defecto, la terminal usa bash. Pero vamos a usar **zsh** que permite algunas cosas extras y útiles. [oh-my-zsh](https://ohmyz.sh) es un framework para administrar zsh con múltiples plugins, cuestión de explorar las [275+ opciones](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins). Vamos a configurar con algunos ejemplos, luego es cuestión de leer y agregar. El mundo de las terminales se puede poner hardcore y confuso muy rápido. Está la shell, bash, zsh, scripting languages, frameworks para administrar todo este mundo, etc. Acá muestro una alternativa, hay muchas.

<br>

>👉 Aviso 1: Es importante mencionar que cuando se abre la terminal (ya sea con la aplicación Terminal.app que trae mac os o con iterm), se carga automáticamente un archivo oculto que reside en el directorio del usuario (`~/`). El archivo en cuestión es `.bashrc` (para bash) ó `.zshrc` (para zsh). En este archivo se pueden agregar comandos personalizados que se ejecuten al iniciar la terminal y vamos a tener que acceder a este archivo para realizar algunas configuracione extras.

>👉 Aviso 2: Existen otros shells interesantes como [fish](https://fishshell.com/). También hace poco descubrí [fig](https://fig.io/). La terminal es un mundo en si mismo en el que mucha gente pasa horas trabajando, por lo que no está mal dedicarle un rato para trabajar cómodo.

1. Abrimos iterm y pegamos el comando de brew para instalar instalar zsh y algunos agregados para tener autocompletition y syntax highlighting:
```shell
brew install zsh zsh-autosuggestions zsh-syntax-highlighting
```
2. Luego tenemos que agregar dos líneas al archivo `.zshrc`. Con este comando agregamos lo que figuar entre comillas al final del archivo sin necesidad de abrirlo (que bien puede hacerse con cualquier editor):
```shell
echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
```
```shell
echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```
3. Instalamos oh-my-zsh:
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
4. Plugins: vamos a editar el listado de plugins de ohmyzsh que queremos usar. Como mencioné, vienen muchísimos por defecto y existen muchos otros que se pueden agregar. Pueden utilizar cualquier editor de texto, yo para este tipo de cosas uso `nano` que viene con la terminal:
```shell
cd
nano .zshrc
```
Una vez abierto tenemos que buscar la línea que dice 
`plugins=(...)` y colocar los que queremos usar. En mi caso arranco con `plugins=(git z colorize copypath copyfile gh gitfast jsontools sublime tmux vscode)`
<br>

### Powerlevel prompt

Ahora vamos a instalar el theme (*Powerlevel10k*). Alternativamente podemos instalar [oh-my-posh](https://ohmyposh.dev/) o [starship](https://starship.rs/) que son exclusivos para el prompt y ambos deben estar buenos, pero nunca los probé: 

1. Clonamos el repo en la carpeta adecuada:
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
2. El siguiente comando agrega la variable ZSH_THEME y su valor a `.zshrc`.
```
echo 'source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```
3. Reiniciamos zsh:
```
exec zsh
```
4. Ahora viene la parte divertida. Powerlevel tiene un wizard que ayuda a configurar todo. Hay muchas opciones y en general ya con eso vamos a estar bien contentos. El wizard no permite desplegar el 100% del potencial, pero en la [página de github](https://github.com/romkatv/powerlevel10k) hay una explicación de muchas cosas que se pueden hacer (colores, git info expandida, batería, qué música suena, IP, etc). También van a encontrar que mucha gente comparte sus configuraciones y .zshrc.
```shell
p10k configure
```

## Venvs y otros lenguanges
En mi caso trabajo con miniconda/python, R/RStudio y julia. Las instalaciones relacionadas están en [Brewfile_langs](./confs/Brewfile_lang_apps).

1. Abrir iterm (podemos dejar de usar la terminal de mac os)
2. Pegar:
```shell
brew bundle --file ~/path/to/Brewfile_lang
```
3. Para terminar con la instalación de miniconda corremos
```shell
conda init "$(basename "${SHELL}")"
```

# Conda defaults
A la hora de crear nuevos entornos virtuales con conda (o cualquier otra tool similar), siempre es medio tedioso instalar los paquetes base que siempre usamos. Existe un archivo de configuración opcional `.condarc` donde podemos especificar qué paquetes queremos instalar por defecto al crear un nuevo entorno y muchas otras cosas más ([documentación](https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html)). Pueden usar el [sample file de conda](https://docs.conda.io/projects/conda/en/latest/configuration.html) como esqueleto, o el [mío](./confs/defaults.condarc). El archivo no existe por defecto, con lo cual hay que crearlo, ya sea con la terminal o cualquier editor y luego guardarlo. Si quieren crearlo y editarlo con la terminal:
```shell
nano ~/.condarc
```
Pegamos y editamos, luego `ctrl+X` y `Y` para guardar.

<br>

# Fonts
Aunque no parezca, la tipografía que utilicemos al programar puede ayudar de diversas maneras en la productividad, lectura, etc. Vamos a instalar [`fira code`](https://github.com/tonsky/FiraCode) que es una fuente monoespaciada con ligaduras, caracteres especiales y más que embellecen la lectura y experiencia. [Acá están las instrucciones para mac os](https://github.com/tonsky/FiraCode/wiki/Installing#macos). Ya que estamos instalamos también `hack nerd font` por si en algún momento queremos probarla. Ambas se instalan fácilmente en forma manual o con homebrew. Vamos por la segunda opción.
>Si quieren otras fuentes para probar, pueden instalar el [Poweline font pack](https://github.com/powerline/fonts) que incluye fira y muchas fuentes preparadas para el mismo fin.

1. Abrir iterm.
2. Pegar 
```
brew tap homebrew/cask-fonts
```
```
brew install --cask font-hack-nerd-font font-fira-code
```
Luego hay que configurar el uso de esta font en todos los softwares que deseemos. Acá se muestran los pasos para [Sublime](https://github.com/tonsky/FiraCode/wiki/Sublime-Text-Instructions), [VS code](https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions), [Rstudio](https://github.com/tonsky/FiraCode/wiki/RStudio-instructions). Específicamente para para iterm podemos:
> iTerm2 → Preferences → Profiles → Text → Change Font (y activar ligaduras)

<br>


# Versionado
## Git

La idea es configurar Git y Github para poder pushear a nuestros repos sin tener que autenticarse cada vez.

>Si te encontrás en la situación de tener que usar dos usuarios distintos (personal y laboral por ejemplo) la cosa se pone más compleja pero se puede, podés seguir la información de [acá](https://www.linkedin.com/pulse/manage-multiple-github-accounts-mac-nadun-malinda/) y/o [acá](https://gist.github.com/Jonalogy/54091c98946cfe4f8cdab2bea79430f9).

1. Configuramos nuestros datos
``` shell
git config --global user.name "CharlyGarcia"
git config --global user.email "charly@garcia.com"
```
2. (opcional) Configuramos el nombre de nuestra branch inicial al hacer `git init` en una carpeta. En 2020 arrancó una discusión acerca de ciertos términos usados en la industria (`blacklist`, `master`, por ejemplo) que derivaron en que github deje de llamarle `master` a la branch inicial y lo cambió por `main`. Más allá de la discusión semántica y cultural, no existen branches esclavas, sino "alternativas", con lo cual llamarle `main` es desde un punto de vista técnico incluso más correcto (si nos ponemos estrictos, la branch "principal" no tiene casi diferencia con el resto, pero eso es otro tema).

``` shell
git config --global init.defaultBranch main
```

3. (opcional) Default `gitignore`. Generamos un archivo global que aplica a todos los repos. 
``` shell
touch ~/.gitignore
```
```shell
git config --global core.excludesFile ~/.gitignore
```
Qué poner en este archivo depende del uso que le den a git así que lo dejo a criterio del usuario. Como ejemplo, podemos agregar los archivos .DS_Store, típico archivo oculto de Mac Os que suele estar en todas las carpetas.

``` shell 
echo .DS_Store >> ~/.gitignore
```
4. (opcional) Configuramos el editor de commit por defecto que nos guste.
``` shell
git config --global core.editor "sublime"
```

## SSH

Para poder usar git en nuestros repos remotos de github, tenemos que generar y configurar una clave ssh. Básicamente es seguir los pasos de la [documentación de github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
1. Generamos una clave SSH. Reemplazar el mail por el que utilizan en github
``` shell
ssh-keygen -t ed25519 -C "charly@garcia.com"
```
Nos va a preguntar "Enter a file in which to save the key", le damos `enter`. 
Luego nos va a preguntar "Enter passphrase (empty for no passphrase)", le damos `enter`. 
Una vez finalizado, tendremos dos archivos generados en `~/.ssh`. Algo del tipo:
- `nombre_archivo`: Clave privada. No compartirla con nadie.
- `nombre_archivo.pub`: Clave pública que usaremos para configurar github. Github

2. Arrancamos el ssh-agent
```shell
eval "$(ssh-agent -s)"
```
1. Agregamos la clave privada a nuestro agente y config.
```shell
nano ~/.ssh/config
```
Pegamos
```text
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/nombre_archivo
```
Luego `ctrl+X` y `Y` para guardar.

4. Registramos la clave privada:
```shell
ssh-add -K ~/.ssh/nombre_archivo
```

## SSH pública en Github

1. Seguimos los pasos de la [documentación de github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).
2. Podemos comprobar si todo funciona siguiendo [estos pasos](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection).

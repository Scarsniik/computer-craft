-- URL du dépôt GitHub
local repo_url = "https://raw.githubusercontent.com/Scarsniik/computer-craft/main/"

-- Nom du fichier contenant la liste des fichiers à télécharger
local list_file = "files_list.txt"

-- Fonction pour télécharger un fichier
function download_file(url, filename)
  print("Téléchargement de " .. filename .. "...")
  local response = http.get(url .. filename)
  if response then
    local file = io.open(filename, "w")
    file:write(response.readAll())
    file:close()
    print(filename .. " téléchargé.")
  else
    print("Erreur lors du téléchargement de " .. filename)
  end
end

-- Téléchargement du fichier contenant la liste des fichiers
download_file(repo_url, list_file)

-- Lecture du fichier contenant la liste des fichiers
local files = {}
for line in io.lines(list_file) do
  files[#files + 1] = line
end

-- Création des dossiers si nécessaire
for _, file in ipairs(files) do
  local path = shell.dir(file)
  if path ~= "" then
    shell.execute("mkdir", "-p", path)
  end
end

-- Téléchargement des fichiers
for _, file in ipairs(files) do
  download_file(repo_url, file)
end
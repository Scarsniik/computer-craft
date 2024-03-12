-- Liste des fichiers à récupérer
local files = {
    "fichier1.lua",
    "dossier/fichier2.lua",
    "autre_dossier/fichier3.lua"
  }
  
  -- URL du dépôt GitHub
  local repo_url = "https://raw.githubusercontent.com/VotreNomUtilisateur/votre-depot/main/"
  
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
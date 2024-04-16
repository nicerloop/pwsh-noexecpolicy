build:
    vagrant snapshot restore clean || (vagrant up && vagrant snapshot save clean)
    vagrant ssh -- pwsh c:/vagrant/build.ps1

clean:
    -vagrant destroy --force

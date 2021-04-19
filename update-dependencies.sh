update_all_but_chart() {
    for chart in ./*; do
        if [ -d "$chart" ] && [ "$chart" != "./$1" ] ; then
            update_chart "$chart"
        fi
    done
}

update_chart() {
    cd "./$1" 
    echo "------------------------------"$1"--------------------------------"
    helm dependencies update
    cd ..
}

directory_check() {
        if [ -d "$1" ]
            then
                 echo true    
            else
                echo false
        fi
}

common_change() {
    while true; do
        read -p "did you make changes to the common library(y/n)?" yn
            case $yn in
                [Yy]* ) echo true; break;;
                [Nn]* ) echo false; exit;;
                * ) echo "Please answer yes or no.";;
            esac
    done
}

cd ..
read -p 'please enter your main helm chart name: ' main
while [[ $(directory_check "$main") == "false" ]]; do
    read -p 'no dir found with name '$main'. please enter your main helm chart name: ' main
done
if [[ $(directory_check "$main") == "true" ]]
    then
        if [[ $(common_change) == "true" ]] 
            then
                update_all_but_chart "$main"
        fi

    update_chart "$main"

fi

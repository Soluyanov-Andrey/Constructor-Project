#-----------------------------------------------------------------------------------------
# Данный скрипт удалит весь проект, из всех папок.
#-----------------------------------------------------------------------------------------
PROJECT_NAME="server-test.ru"

function jumpto
{
    if [ -d "../../www/$PROJECT_NAME" ]
        then
          echo "Удаляем проект"
           # "Директории PROJECT_NAME есть"
           sudo rm -R  "../../www/$PROJECT_NAME"
            rm -R  "../archive_project/$PROJECT_NAME.sh"
            rm -R  "../backup_project/$PROJECT_NAME.sh"
            rm -R  "../delete_project/$PROJECT_NAME.sh"
            rm -R  "../infa_project/$PROJECT_NAME.txt"
            rm -R  "../run_project/$PROJECT_NAME.sh"
        else
           # "Директории PROJECT_NAME нет"
          echo "Проекта нет в папке www"
    fi
    exit
}
echo "Вы действительно хотите удалить проект? $PROJECT_NAME"

select yn in "Да" "Нет"; do
    case $yn in
        Да ) jumpto;;
        Нет ) exit;;
    esac
done

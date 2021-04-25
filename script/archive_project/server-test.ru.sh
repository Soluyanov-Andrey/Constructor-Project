#-------------------------------Переменные окружения--------------------------------------
# Данный скрипт переносит папку с рабочем проектов в папку archive
#-----------------------------------------------------------------------------------------

# Папка в которой будет работать проект
WWW="www"

# Переменные для работы скрипта

PROJECT_NAME="server-test.ru"
DIRECTORY_WWW=../../$WWW
DIRECTORY_ARCHIVE=../../archive

#-----------------------------------------------------------------------------------------


script_move_archive(){
 mkdir ../../www/$PROJECT_NAME/$PROJECT_NAME.script

 mkdir ../../www/$PROJECT_NAME/$PROJECT_NAME.script/backup_project
 mkdir ../../www/$PROJECT_NAME/$PROJECT_NAME.script/delete_project
 mkdir ../../www/$PROJECT_NAME/$PROJECT_NAME.script/infa_project
 mkdir ../../www/$PROJECT_NAME/$PROJECT_NAME.script/run_project

 mv ../backup_project/$PROJECT_NAME.sh ../../www/$PROJECT_NAME/$PROJECT_NAME.script/backup_project
 mv ../delete_project/$PROJECT_NAME.sh ../../www/$PROJECT_NAME/$PROJECT_NAME.script/delete_project
 mv ../infa_project/$PROJECT_NAME.txt ../../www/$PROJECT_NAME/$PROJECT_NAME.script/infa_project
 mv ../run_project/$PROJECT_NAME.sh ../../www/$PROJECT_NAME/$PROJECT_NAME.script/run_project
}

script_move_project(){
 mv ../../www/$PROJECT_NAME/$PROJECT_NAME.script/backup_project/$PROJECT_NAME.sh ../backup_project/
 mv ../../www/$PROJECT_NAME/$PROJECT_NAME.script/delete_project/$PROJECT_NAME.sh ../delete_project/
 mv ../../www/$PROJECT_NAME/$PROJECT_NAME.script/infa_project/$PROJECT_NAME.txt ../infa_project/
 mv ../../www/$PROJECT_NAME/$PROJECT_NAME.script/run_project/$PROJECT_NAME.sh ../run_project/
 sudo rm -R ../../www/$PROJECT_NAME/$PROJECT_NAME.script/
}

copy(){

              script_move_archive;
              echo "Меняем права на папку data от базы данных"
              sleep 0.5s
              sudo chmod 777 * -R $DIRECTORY_WWW/$PROJECT_NAME/data
              echo "Перемещаем папку в архив"
              sleep 0.5s

              sudo mv $DIRECTORY_WWW/$PROJECT_NAME $DIRECTORY_ARCHIVE

              echo "Файлы перемещены в архив"


}

     # "Директория www c проектом есть"
     if [ -d "$DIRECTORY_WWW/$PROJECT_NAME" ]
         then
             echo "Выключены ли все docker контейнеры связанные с проектом?"
               select yn in "Да" "Нет"; do
                  case $yn in
                      Да ) copy; break;;
                      Нет ) exit;;
                  esac
               done

         else
             # "Директории www нет"
             echo "Копируем проект $PROJECT_NAME из архива"
             sudo mv $DIRECTORY_ARCHIVE/$PROJECT_NAME $DIRECTORY_WWW
             script_move_project;
             sleep 0.5s
             echo "Проект $PROJECT_NAME скопирован"
     fi



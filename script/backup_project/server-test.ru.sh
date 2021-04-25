#-----------------------------------------------------------------------------------------
#Данный скрипт создает архив проекта, в папке un_backup
#-----------------------------------------------------------------------------------------


#-------------------------------Переменные окружения--------------------------------------
YANDEX_DICK_INSTALL=true
YANDEX_DICK="/media/test/project/Yandex.Disk/backup"

# Переменные для работы скрипта
PROJECT_NAME="server-test.ru"
DIRECTORY_WWW="../../www"
#-----------------------------------------------------------------------------------------


if [ -d "$DIRECTORY_WWW/$PROJECT_NAME" ]

  then
     # "Директория PROJECT_NAME есть"
        echo "Копируем шаблоны backup"
        cp  -R ../../system_folder/template/backup_template ../../backup/backup_create

        sleep 1s

        echo "Переименовываем название шаблонов в имя сайта"
        mv ../../backup/backup_create/backup_template ../../backup/backup_create/$PROJECT_NAME


        sleep 1s

        echo "Копируем проект для backup"
        cp  -R ../../www/$PROJECT_NAME ../../backup/backup_create/$PROJECT_NAME

        sleep 1s

        echo "Перемещение script файлов"
        cp  -R ../../script/archive_project/$PROJECT_NAME.sh ../../backup/backup_create/$PROJECT_NAME/script/archive_project
        cp  -R ../../script/backup_project/$PROJECT_NAME.sh ../../backup/backup_create/$PROJECT_NAME/script/backup_project
        cp  -R ../../script/delete_project/$PROJECT_NAME.sh ../../backup/backup_create/$PROJECT_NAME/script/delete_project
        cp  -R ../../script/infa_project/$PROJECT_NAME.txt ../../backup/backup_create/$PROJECT_NAME/script/infa_project
        cp  -R ../../script/run_project/$PROJECT_NAME.sh ../../backup/backup_create/$PROJECT_NAME/script/run_project
        sleep 1s

        echo "Делаем архив"

        sleep 1s
        cd ..
        cd ..
        cd backup/backup_create
        tar -cvf $PROJECT_NAME.tar.gz $PROJECT_NAME
        sudo chmod 777 * -R $PROJECT_NAME.tar.gz

        echo "Удаляем созданные папки"
        sleep 1s
        sudo rm -R $PROJECT_NAME
        if [ $YANDEX_DICK_INSTALL = true ]
            then
                echo "Копируем на Яндекс Диск"
                cp  -R ../../backup/backup_create/$PROJECT_NAME.tar.gz $YANDEX_DICK
                yandex-disk sync
            else
              echo "Копирование на Яндекс Диск не настроено"
            fi

  else
     # "Директории PROJECT_NAME нет"
     echo "Выполните скрипт archive_project проекта нет в папке www"

fi

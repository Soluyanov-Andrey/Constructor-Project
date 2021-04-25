WWW="www"
ARCHIVE="archive"
DIRECTORY_WWW=../$WWW
archive_project ()
{
# Создаем фаил по шаблону
cat > archive_project/$NAME.sh << EOF
#-------------------------------Переменные окружения--------------------------------------
# Данный скрипт переносит папку с рабочем проектов в папку archive
#-----------------------------------------------------------------------------------------

# Папка в которой будет работать проект
WWW="www"

# Переменные для работы скрипта

PROJECT_NAME="$NAME"
DIRECTORY_WWW=../../\$WWW
DIRECTORY_ARCHIVE=../../archive

#-----------------------------------------------------------------------------------------


script_move_archive(){
 mkdir ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script

 mkdir ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/backup_project
 mkdir ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/delete_project
 mkdir ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/infa_project
 mkdir ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/run_project

 mv ../backup_project/\$PROJECT_NAME.sh ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/backup_project
 mv ../delete_project/\$PROJECT_NAME.sh ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/delete_project
 mv ../infa_project/\$PROJECT_NAME.txt ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/infa_project
 mv ../run_project/\$PROJECT_NAME.sh ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/run_project
}

script_move_project(){
 mv ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/backup_project/\$PROJECT_NAME.sh ../backup_project/
 mv ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/delete_project/\$PROJECT_NAME.sh ../delete_project/
 mv ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/infa_project/\$PROJECT_NAME.txt ../infa_project/
 mv ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/run_project/\$PROJECT_NAME.sh ../run_project/
 sudo rm -R ../../www/\$PROJECT_NAME/\$PROJECT_NAME.script/
}

copy(){

  script_move_archive;
  echo "Меняем права на папку data от базы данных"
  sleep 0.5s
  sudo chmod 777 * -R \$DIRECTORY_WWW/\$PROJECT_NAME/data
  echo "Перемещаем папку в архив"
  sleep 0.5s

  sudo mv \$DIRECTORY_WWW/\$PROJECT_NAME \$DIRECTORY_ARCHIVE

  echo "Файлы перемещены в архив"

}

# "Директория www c проектом есть"
if [ -d "\$DIRECTORY_WWW/\$PROJECT_NAME" ]
   then
       echo "Выключены ли все docker контейнеры связанные с проектом?"
         select yn in "Да" "Нет"; do
            case \$yn in
                Да ) copy; break;;
                Нет ) exit;;
            esac
         done

   else
       # "Директории www нет"
       echo "Копируем проект \$PROJECT_NAME из архива"
       sudo mv \$DIRECTORY_ARCHIVE/\$PROJECT_NAME \$DIRECTORY_WWW
       script_move_project;
       sleep 0.5s
       echo "Проект \$PROJECT_NAME скопирован"
fi


EOF
}
backup_project(){
     cat > backup_project/$NAME.sh << EOF
#-----------------------------------------------------------------------------------------
#Данный скрипт создает архив проекта, в папке un_backup
#-----------------------------------------------------------------------------------------


#-------------------------------Переменные окружения--------------------------------------
YANDEX_DICK_INSTALL=false
YANDEX_DICK="/media/test/project/Yandex.Disk/backup"

# Переменные для работы скрипта
PROJECT_NAME="$NAME"
DIRECTORY_WWW="../../www"
#-----------------------------------------------------------------------------------------


if [ -d "\$DIRECTORY_WWW/\$PROJECT_NAME" ]

  then
     # "Директория PROJECT_NAME есть"
        echo "Копируем шаблоны backup"
        cp  -R ../../system_folder/template/backup_template ../../backup/backup_create

        sleep 1s

        echo "Переименовываем название шаблонов в имя сайта"
        mv ../../backup/backup_create/backup_template ../../backup/backup_create/\$PROJECT_NAME


        sleep 1s

        echo "Копируем проект для backup"
        cp  -R ../../www/\$PROJECT_NAME ../../backup/backup_create/\$PROJECT_NAME

        sleep 1s

        echo "Перемещение script файлов"
        cp  -R ../../script/archive_project/\$PROJECT_NAME.sh ../../backup/backup_create/\$PROJECT_NAME/script/archive_project
        cp  -R ../../script/backup_project/\$PROJECT_NAME.sh ../../backup/backup_create/\$PROJECT_NAME/script/backup_project
        cp  -R ../../script/delete_project/\$PROJECT_NAME.sh ../../backup/backup_create/\$PROJECT_NAME/script/delete_project
        cp  -R ../../script/infa_project/\$PROJECT_NAME.txt ../../backup/backup_create/\$PROJECT_NAME/script/infa_project
        cp  -R ../../script/run_project/\$PROJECT_NAME.sh ../../backup/backup_create/\$PROJECT_NAME/script/run_project
        sleep 1s

        echo "Делаем архив"

        sleep 1s
        cd ..
        cd ..
        cd backup/backup_create
        tar -cvf \$PROJECT_NAME.tar.gz \$PROJECT_NAME
        sudo chmod 777 * -R \$PROJECT_NAME.tar.gz

        echo "Удаляем созданные папки"
        sleep 1s
        sudo rm -R \$PROJECT_NAME
        if [ \$YANDEX_DICK_INSTALL = true ]
            then
                echo "Копируем на Яндекс Диск"
                cp  -R ../../backup/backup_create/\$PROJECT_NAME.tar.gz \$YANDEX_DICK
                yandex-disk sync
            else
              echo "Копирование на Яндекс Диск не настроено"
            fi

  else
     # "Директории PROJECT_NAME нет"
     echo "Выполните скрипт archive_project проекта нет в папке www"

fi
EOF
}

delete_project(){
     cat > delete_project/$NAME.sh << EOF
#-----------------------------------------------------------------------------------------
# Данный скрипт удалит весь проект, из всех папок.
#-----------------------------------------------------------------------------------------
PROJECT_NAME="$NAME"

function jumpto
{
    if [ -d "../../www/\$PROJECT_NAME" ]
        then
          echo "Удаляем проект"
           # "Директории PROJECT_NAME есть"
           sudo rm -R  "../../www/\$PROJECT_NAME"
            rm -R  "../archive_project/\$PROJECT_NAME.sh"
            rm -R  "../backup_project/\$PROJECT_NAME.sh"
            rm -R  "../delete_project/\$PROJECT_NAME.sh"
            rm -R  "../infa_project/\$PROJECT_NAME.txt"
            rm -R  "../run_project/\$PROJECT_NAME.sh"
        else
           # "Директории PROJECT_NAME нет"
          echo "Проекта нет в папке www"
    fi
    exit
}
echo "Вы действительно хотите удалить проект? \$PROJECT_NAME"

select yn in "Да" "Нет"; do
    case \$yn in
        Да ) jumpto;;
        Нет ) exit;;
    esac
done
EOF
}

run_project(){
      cat > run_project/$NAME.sh << EOF
#-----------------------------------------------------------------------------------------
# В этом скрипте, записываем основные команды, необходимые для запуска проекта.
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
# Так, указываем путь к папке, что позволяет запускать sh скрипты в другой папке.
#-----------------------------------------------------------------------------------------
cd ..
cd ..
cd www
cd $NAME
cd docker
#-----------------------------------------------------------------------------------------
# Пишем команды для запуска.
#-----------------------------------------------------------------------------------------
EOF
}

infa_project(){
      cat > infa_project/$NAME.txt << EOF
#-----------------------------------------------------------------------------------------
# В этом файле записываем информацию о проекте.
#-----------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
Описание проекта:

#-----------------------------------------------------------------------------------------
Дополнительная информация:

#-----------------------------------------------------------------------------------------

EOF
}
echo -n "Введите название проекта включая .ru или другое .com .su  "
read NAME
echo $ARCHIVE/$NAME;

if [ -d "../$ARCHIVE/$NAME" ]
  then
   echo "Проект с таким именем уже есть в папке archive"
   exit;
  else
   echo "Проекта с таким именем нет в папке archive"
fi

if [ -d "$DIRECTORY_WWW/$NAME" ]
   then
     echo "Проект с таким именем уже есть в папке www"
   else
      echo "Проект с таким именем нет в папке www"
      echo "Создаем скрипт в archive_project"
      sleep 0.5s
      archive_project
      echo "Создаем скрипт в backup_project"
      sleep 0.5s
      backup_project
      echo "Создаем скрипт в delete_project"
      sleep 0.5s
      delete_project
      echo "Создаем скрипт в infa_project"
      sleep 0.5s
      infa_project
      echo "Создаем скрипт в run_project"
      sleep 0.5s
      run_project
      echo "Копируем шаблон проекта"
      cp -r ../system_folder/template/www_template $DIRECTORY_WWW
      sleep 0.5s
      echo "Переименовываем шаблоны"
      mv $DIRECTORY_WWW/www_template/name-project.ru $DIRECTORY_WWW/www_template/$NAME
      mv $DIRECTORY_WWW/www_template $DIRECTORY_WWW/$NAME
      echo "Проект создан"

fi




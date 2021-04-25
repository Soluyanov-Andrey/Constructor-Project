#----------------------------------------------------------
# Данный скрипт запускает распаковку, ранее созданного архива
# Скопируйте архив в папку system_folder/un_backup
# Укажите переменные
# PROJECT_NAME = "name_project" например name_project = "de.ru"
#
# BACKUP_NAME = "name_project" например name_project = "de.ru.tar.gz"
# и выполните данный скрипт.
#
#----------------------------------------------------------
PROJECT_NAME="test.ru"
BACKUP_NAME="test.ru.tar.gz"
read -p "Password Sudo: " -s szPassword
cd ..
cd backup
cd un_backup
pwd
tar -xvf $BACKUP_NAME

if [ -d "$PROJECT_NAME" ]
  then
    echo "$PROJECT_NAME папка есть"
  else
    echo "Ошибка неверная структура 01"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -d "$PROJECT_NAME/$PROJECT_NAME" ]
  then
    echo "$PROJECT_NAME/$PROJECT_NAME папка есть"
  else
    echo "Ошибка неверная структура 02"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -d "$PROJECT_NAME/script" ]
  then
    echo "$PROJECT_NAME/script папка есть"
  else
    echo "Ошибка неверная структура 03"
    sudo rm -R $PROJECT_NAME
    exit;
fi
#----------------------------------------------------------
# Проверяем папки внутри папки script
#----------------------------------------------------------

if [ -d "$PROJECT_NAME/script/archive_project" ]
  then
    echo "$PROJECT_NAME/script/archive_project папка есть"
  else
    echo "Ошибка неверная структура 04"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -d "$PROJECT_NAME/script/backup_project" ]
  then
    echo "$PROJECT_NAME/script/backup_project папка есть"
  else
    echo "Ошибка неверная структура 05"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -d "$PROJECT_NAME/script/delete_project" ]
  then
    echo "$PROJECT_NAME/script/delete_project папка есть"
  else
    echo "Ошибка неверная структура 06"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -d "$PROJECT_NAME/script/infa_project" ]
  then
    echo "$PROJECT_NAME/script/infa_project папка есть"
  else
    echo "Ошибка неверная структура 07"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -d "$PROJECT_NAME/script/run_project" ]
  then
    echo "$PROJECT_NAME/script/run_project папка есть"
  else
    echo "Ошибка неверная структура 08"
    sudo rm -R $PROJECT_NAME
    exit;
fi

#----------------------------------------------------------
# Проверяем наличие скриптов
#----------------------------------------------------------

if [ -f "$PROJECT_NAME/script/archive_project/$PROJECT_NAME.sh" ]
  then
    echo "$PROJECT_NAME/script/archive_project/$PROJECT_NAME.sh скрипт есть"
  else
    echo "Ошибка неверная структура 09"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -f "$PROJECT_NAME/script/backup_project/$PROJECT_NAME.sh" ]
  then
    echo "$PROJECT_NAME/script/backup_project/$PROJECT_NAME.sh скрипт есть"
  else
    echo "Ошибка неверная структура 10"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -f "$PROJECT_NAME/script/delete_project/$PROJECT_NAME.sh" ]
  then
    echo "$PROJECT_NAME/script/delete_project/$PROJECT_NAME.sh скрипт есть"
  else
    echo "Ошибка неверная структура 11"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -f "$PROJECT_NAME/script/infa_project/$PROJECT_NAME.txt" ]
  then
    echo "$PROJECT_NAME/script/infa_project/$PROJECT_NAME.txt скрипт есть"
  else
    echo "Ошибка неверная структура 12"
    sudo rm -R $PROJECT_NAME
    exit;
fi

if [ -f "$PROJECT_NAME/script/run_project/$PROJECT_NAME.sh" ]
  then
    echo "$PROJECT_NAME/script/run_project/$PROJECT_NAME.sh скрипт есть"
  else
    echo "Ошибка неверная структура 13"
    sudo rm -R $PROJECT_NAME
    exit;
fi

#----------------------------------------------------------
# Проверяем проект
#----------------------------------------------------------

if [ -d "$PROJECT_NAME/$PROJECT_NAME/data" ]
  then
    echo "$PROJECT_NAME/$PROJECT_NAME/data папка есть"
  else
    echo "Ошибка неверная структура 14"
    sudo rm -R $PROJECT_NAME
    exit;
fi


#----------------------------------------------------------
# Проверяем наличие проекта
#----------------------------------------------------------

if [ -d "../../archive/$PROJECT_NAME" ]
  then
    echo "Проект с таким именем уже есть в папке archive"
    echo "*************************************"
    echo "*     Решите вопрос конфликта       *"
    echo "*************************************"
    echo "Удаляем все файлы которые были распакованы во временные папки из архива"
    sudo rm -R $PROJECT_NAME
    exit;
  else
    echo "Развернутого проекта с таким именем в папке archive нет,идем дальше"
fi

if [ -d "../../www/$PROJECT_NAME" ]
  then
    echo "Проект с таким именем уже есть в папке www"
    echo "*************************************"
    echo "*     Решите вопрос конфликта       *"
    echo "*************************************"

    echo "Удаляем все файлы которые были распакованы во временные папки из архива"
    sudo rm -R $PROJECT_NAME
    exit;
  else
    echo "Развернутого проекта с таким именем в папке www нет,идем дальше"
fi

#----------------------------------------------------------
# Архив соответствует структуре, начинаем перемещение
#----------------------------------------------------------
echo "Проверка прошла успешно, начинаем копирование проекта в папку www"
sleep 1s
cp  -R $PROJECT_NAME/$PROJECT_NAME ../../www

sleep 1s

echo "Перемещение script файлов"
cp  -R $PROJECT_NAME/script/archive_project/$PROJECT_NAME.sh ../../script/archive_project
cp  -R $PROJECT_NAME/script/backup_project/$PROJECT_NAME.sh ../../script/backup_project
cp  -R $PROJECT_NAME/script/delete_project/$PROJECT_NAME.sh ../../script/delete_project
cp  -R $PROJECT_NAME/script/infa_project/$PROJECT_NAME.txt ../../script/infa_project
cp  -R $PROJECT_NAME/script/run_project/$PROJECT_NAME.sh ../../script/run_project

echo "Удаляем все файлы которые были распакованы во временные папки из архива"
sleep 1s
sudo rm -R $PROJECT_NAME
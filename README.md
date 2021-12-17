# Test app for Eclipse Digital Studio company

Проект подготовлен в рамках тестового задания от 16.12.2021

## О приложении
В директории doc сгенерирована документация.

Основано на паттерне проектирования BLoC с управлением состояниями.

Содержит следующие модули:
- Пользователи
- Посты
- Комментарии
- Альбомы

На основе SQFlite реализовано кэширование следующих данных:
- Список пользователей

## Использованы следующие пакеты

| Название пакета |     Версия    |    Описание   |
| --------------- | ------------- | ------------- |
| [http][http]  | ^0.13.4  | Работа с протоколом HTTP |
| [skeletons][skeletons]  | ^0.0.3  | Превью загрузки | 
| [cached_network_image][cached_network_image]  | ^3.2.0  | Виджет загрузки изображений |
| [photo_view][photo_view]  | ^0.13.0  | Виджет просмотра изображений |
| [sqflite][sqflite]  | ^2.0.1  | База данных |
| [path_provider][path_provider]  | ^2.0.8  | Получение местоположений директорий |



[http]: <https://pub.dev/packages/http>
[skeletons]: <https://pub.dev/packages/skeletons>
[cached_network_image]: <https://pub.dev/packages/cached_network_image>
[photo_view]: <https://pub.dev/packages/photo_view>
[sqflite]: <https://pub.dev/packages/sqflite>
[path_provider]: <https://pub.dev/packages/path_provider>


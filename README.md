# О тестовом
В тестовом я решил сделать UI совсем минималистичным, чтобы не тратить время на раздумья по верстке, так как без макета это всегда занимает намного больше времени.

Изначально хотел сделать что-то похожее по дизайну как у встроенного приложения эпл, но понял что это слишком долго и я не успею за отведенное время. И в итоге я просто взял массив данных о погоде на каждые 3 часа, не став разбивать это на дни, и вывел одним списком.

##  SPM
Был добавлен собственный SPM для логирования и удобной отладки приложения без использования print()

## Локализация
Не совсем понял по задаче что именно нужно локализовать, поэтому сделал только смену языка именно с помощью API. Полную локализацию приложения добавлять не стал, по причине сильно сжатых сроков, которые и так затянул. Но делать это умею. В своём пет проекте частично начал делать локализацию.

## Архитектура
Была выбрана архитектура MVP, так как достаточно часто работал с ней и это позволило писать код быстрее. А так же для текущего приложения её более чем достаточно.

## Трудности
Апи оказалось достаточно сложным и только на его изучение было потрачено около 2 часов, чтобы сделать всё красиво. И когда увидел сколько прошло времени, решил что не буду переусложнять, и сделаю UI/UX максимально простым.

Я не смог найти в документации, как получить список городов из запроса, для более корректного поиска нужного города. Поэтому пока что хорошо работает только ввод пользователем в ручную названия города России. Города других стран с ключом ru не ищет. Но если условно указать uk, то для поиска по России русский ввод перестаёт работать, и нужно дополнительно добавлять так: Moskow,RU. Подобное не работает для других стран. Если дать мне больше времени, я бы разобрался на примере других проектов с этим api, которые лежат на гитхабе Сейчас часть страниц документации открывается с ошибкой 404. К примеру смену локали пришлось смотреть на ранних проектах.

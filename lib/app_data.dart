import 'package:weathermonitoringapp/Classes/DataTypes.dart';
import 'package:weathermonitoringapp/Classes/Sensor.dart';

final SensorsTypes_list = [
  Sensor(
      id: '0',
      name: 'DHT11',
      description:
          'The DHT11 is a basic, ultra low-cost digital temperature and humidity sensor. It uses a capacitive humidity sensor and a thermistor to measure the surrounding air and spits out a digital signal on the data pin',
      imageUrl:
          'https://th.bing.com/th/id/R.46c057ffc8f20215baa39e470ef82e9d?rik=usxCVOhId6IAjw&pid=ImgRaw&r=0&sres=1&sresct=1'),
  Sensor(
      id: '1',
      name: 'Anemometer',
      description:
          'An anemometer is an instrument that measures the velocity of air, sometimes called a wind sensor. It can be used to measure the speed or velocity of gases either in a contained flow, such as airflow in a duct, or in unconfined flows, such as atmospheric wind',
      imageUrl:
          'https://th.bing.com/th/id/R.94641580336a14d759b0963f1480e5d3?rik=e2clWyNP7udEpQ&pid=ImgRaw&r=0'),
  Sensor(
      id: '2',
      name: 'RainDropsensor',
      description:
          'A raindrop sensor, also known as a rain detector sensor, is a device used to detect the presence of rain or measure the amount of rainfall. It is commonly used in various applications, including irrigation systems, automatic wipers, and weather monitoring.',
      imageUrl:
          'https://cdnx.jumpseller.com/mactornica/image/9803471/resize/570/765?1619047959'),
];

final DataTypes_list = [
  DataTypes(
    id: '0',
    name: 'temperature',
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/1684/1684426.png',
    backgroundImageUrl:
        'https://media.istockphoto.com/id/1777773387/photo/mountains-in-the-morning-on-a-foggy-day.webp?b=1&s=170667a&w=0&k=20&c=8IAtJxlgh9VKYN2xcWEDIbETwdhwykbLy8zQ-KVxXQc=',
  ),
  DataTypes(
    id: '1',
    name: 'humidity',
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/4148/4148460.png',
    backgroundImageUrl:
        'https://media.istockphoto.com/id/843702674/photo/window-with-condensate-or-steam-after-heavy-rain-large-texture-or-background.webp?b=1&s=170667a&w=0&k=20&c=1DZKzdg34F9xv2UR4YjdgY1mNIQAgXW2MILQFLUu0fM=',
  ),
  DataTypes(
    id: '2',
    name: 'Rain',
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/3351/3351979.png',
    backgroundImageUrl:
        'https://images.unsplash.com/photo-1641048350553-9d18d4fc78e7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cmFpbiUyMHdlYXRoZXJ8ZW58MHx8MHx8fDA%3D',
  ),
  DataTypes(
    id: '3',
    name: 'Wind',
    imageUrl: 'https://img.icons8.com/?size=80&id=a409gOURYfde&format=png',
    backgroundImageUrl:
        'https://media.istockphoto.com/id/627067972/photo/tropical-storm.jpg?s=612x612&w=0&k=20&c=cBJu4zD4aPf2-upJFB3kRaCx06hIJWk5UYcJby4o2DU=',
  ),
];

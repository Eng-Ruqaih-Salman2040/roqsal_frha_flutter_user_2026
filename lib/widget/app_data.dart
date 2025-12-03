// ignore: unused_import
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/level_sections.dart';
import '../models/sections_colleges.dart';
const Categories_data = const [
  Category(
    id: 'c1',
    title: 'كلية الهندسة وتقنية المعلومات  ',
    image:
        ('assets/images/1.jpg'),
  ),
  Category(
    id: 'c2',
    title: 'كلية العلوم الإدارية ',
    image:
        ('assets/images/2.jpg'),
  ),
  Category(
    id: 'c3',
    title: 'كلية الادأب والعلوم الانسانية  ',
    image:
        ('assets/images/3.jpg'),
  ),
  Category(
    id: 'c4',
    title: ' كلية الطب    ',
    image:
        ('assets/images/4.jpg'),
  ),
  
];
  // ignore: unnecessary_const
  const Sections_data = const [
  
  sections(
    id: 'm1',
    categories: [
      'c1',
    ],
    title: 'قسم شبكات الحاسوب',
  
    image:
      ('assets/images/5.jpg'),
  
  ),
  sections(
    id: 'm2',
    categories: [
      'c1',
    ],
    title: 'قسم تقنية المعلومات ',

    image:
      ('assets/images/1.jpg'),
  
  ),
  sections(
    id: 'm3',
    categories: [
      
      'c1',
    ],
    title: 'قسم هندسة مدنية ',
    image:
        ('assets/images/6.jpg'),

  ),
  sections(
    id: 'm4',
    categories: [
      'c2',
    ],
    title: 'قسم المحاسبة ',
    image:
      ('assets/images/2.jpg'),
  ),
  sections(
    id: 'm5',
    categories: [
      'c2',
    ],
    title: 'قسم إدارة الأعمال ',
    image:
        ('assets/images/5017027.jpg'),
  ),
  sections(
    id: 'm6',
    categories: [
      'c2',
    ],
    title: 'قسم نظم المعلومات ',
    image:
        ('assets/images/5914420.jpg'),
  ),

  sections(
    id: 'm7',
    categories: [
      'c2',
    ],
    title: 'قسم التسويق  ',
    image:
        ('assets/images/5017027.jpg'),
  ),
  sections(
    id: 'm8',
    categories: [
      'c3',
      
    ],
    title: 'قسم علوم القران  ',
    image:
        ('assets/images/3.jpg'),

  ),
  sections(
    id: 'm9',
    categories: [
      'c3',
    ],
    title: 'قسم اللغة العربية  ',

    image:
      ('assets/images/5914420.jpg'),
  ),
  sections(
    id: 'm10',
    categories: [
      'c3',
    ],
    title: 'قسم الدراسات الاسلامية  ',

    image:
      ('assets/images/8764.jpg'),

  ),
  sections(
    id: 'm11',
    categories: [
      'c3',
    ],
    title: 'قسم اللغة الإنجليزية ',
    image:
      ('assets/images/444.jpg'),
  ),
  sections(
    id: 'm12',
    categories: [
      'c3',
    ],
    title: 'قسم الإعلام',
    image:
      ('assets/images/333.jpg'),

  ),
  sections(
    id: 'm13',
    categories: [
      'c3',
    ],
    title: 'قسم الشريعة والقانون ',
    image:
      ('assets/images/222.jpg'),

  ),
    sections(
    id: 'm14',
    categories: [
      'c4',
    ],
    title: 'طب بشري ',
    image:
      ('assets/images/4.jpg'),

  ),
  sections(
    id: 'm15',
    categories: [
      'c4',
    ],
    title: 'فني اسنان',

    image:
      ('assets/images/7.jpg'),
  
  
  
  ),
];
  // ignore: unnecessary_const
  const Levels_data= const [
  
  level(
    id: 'l1',
    sections: [
      'm1',
    ],
    title: 'الاول ',
  
    image:
      ('assets/images/5.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm1',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm1',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    sections: [
      'm1',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), categories: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm2',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm2',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm2',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm2',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm3',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm3',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm3',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm3',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm4',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm4',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm4',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm4',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm5',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm5',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm5',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm5',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm6',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm6',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm6',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm6',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm7',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm7',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm7',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm7',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm8',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm8',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm8',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm8',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm9',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm9',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm9',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm9',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm10',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm10',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm10',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm10',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm11',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm11',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm11',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm11',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm12',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm12',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm12',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm12',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm13',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm13',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm13',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm13',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm14',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm14',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm14',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm14',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  level(
    id: 'l1',
    sections: [
      'm15',
    ],
    title: 'الاول  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l2',
    sections: [
      'm15',
    ],
    title: 'الثاني  ',

    image:
      ('assets/images/1.jpg'), categories: [],
  
  ),
  level(
    id: 'l3',
    sections: [
      
      'm15',
    ],
    title: 'الثالث ',
    image:
        ('assets/images/6.jpg'), categories: [],

  ),
  level(
    id: 'l4',
    categories: [
      'm15',
    ],
    title: 'الرابع ',
    image:
      ('assets/images/2.jpg'), sections: [],
  ),
  
];





class Note{
final int id;
final String title;
final String description;
const Note({required this.id,required this.description,required this.title});
factory Note.fromJson(Map<String,dynamic>json)=>Note(
  id: json['id'],
      title: json['title'],
  description: json['description']
);

Map<String,dynamic>toJson()=>{
  'id':id,
  "title":title,
  'description':description,};


}
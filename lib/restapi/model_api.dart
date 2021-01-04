

class ItemModel {

   final String name;
   final int amount;

   
   ItemModel(this.name, this.amount);
    
   factory ItemModel.fromMap(Map<String, dynamic> json) { 
      return ItemModel( 
         json['name'], 
         json['amount'], 
      );
   }
}
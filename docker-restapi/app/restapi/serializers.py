from rest_framework import serializers
from .models import Order, Product_Order, Product, Vendor, JobSite
from django.contrib.auth.models import User

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields ='__all__'

class ProductOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product_Order
        fields = '__all__'
        
class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'
 
class VendorSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Vendor
        fields = '__all__'
        
# class EquipmentSerializer(serializers.ModelSerializer):
#     class Meta: 
#         model = Equipment
#         fields = '__all__'

# class EquipmentStatusSerializer(serializers.ModelSerializer):
#     class Meta: 
#         model = EquipmentStatus
#         fields = '__all__'
 
 
class JobSiteSerializer(serializers.ModelSerializer):
    class Meta: 
        model = JobSite
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta: 
        model = User
        fields = ['first_name', 'last_name']


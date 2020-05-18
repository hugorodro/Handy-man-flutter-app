from rest_framework import serializers
from .models import Order, Product, Equipment, Vendor, JobSite, EquipmentStatus

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields ='__all__'
        
 
class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'
 
class VendorSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Vendor
        fields = '__all__'
        
class EquipmentSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Equipment
        fields = '__all__'

class EquipmentStatusSerializer(serializers.ModelSerializer):
    class Meta: 
        model = EquipmentStatus
        fields = '__all__'
 
 
class JobSiteSerializer(serializers.ModelSerializer):
    class Meta: 
        model = JobSite
        fields = '__all__'


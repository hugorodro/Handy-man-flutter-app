from django.contrib import admin
from .models import Order, Product, Equipment, JobSite,  Vendor
# Register your models here.
 
admin.site.register(Order)
admin.site.register(Product)
admin.site.register(Equipment)
admin.site.register(JobSite)
admin.site.register(Vendor)

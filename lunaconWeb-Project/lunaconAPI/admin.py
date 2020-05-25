from django.contrib import admin
from .models import Order, Product, Equipment, JobSite,  Vendor
# Register your models here.
 
admin.site.register(Product)
admin.site.register(Equipment)
admin.site.register(JobSite)
admin.site.register(Vendor)

def fulfill_orders(modeladmin, request, queryset):
    queryset.update(fulfilled='True')
    fulfill_orders.short_description = "Fulfill selected orders"

class OrderAdmin(admin.ModelAdmin):
  
    actions = [fulfill_orders]

admin.site.register(Order, OrderAdmin)

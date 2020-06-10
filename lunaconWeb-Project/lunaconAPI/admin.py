from django.contrib import admin
from .models import Order, Product_Order, Product, JobSite,  Vendor
# Register your models here.
 
# admin.site.register(Equipment)
admin.site.register(JobSite)
admin.site.register(Vendor)


def fulfill_orders(modeladmin, request, queryset):
    queryset.update(fulfilled='True')
    fulfill_orders.short_description = "Fulfill selected orders"

class ProductOrder_inLine(admin.TabularInline):
    model = Product_Order
    extra = 1

class OrderAdmin(admin.ModelAdmin):
  
    actions = [fulfill_orders]
    inlines = (ProductOrder_inLine,)

class ProductAdmin(admin.ModelAdmin):
    inlines = (ProductOrder_inLine,)

admin.site.register(Order, OrderAdmin)
admin.site.register(Product, ProductAdmin)
admin.site.register(Product_Order)




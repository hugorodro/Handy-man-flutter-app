from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Order, Product_Order, Product, JobSite,  Vendor

#site branding
admin.site.site_title = "Lunacon Construction"
admin.site.site_header = "Lunacon Construction"
admin.site.index_title = 'Lunacon Application Dashboard'

# admin.site.register(Equipment)
admin.site.register(JobSite)
admin.site.register(Vendor)

# For PO output
import io
from django.http import FileResponse
from reportlab.pdfgen import canvas
from reportlab.platypus import SimpleDocTemplate
from reportlab.rl_config import defaultPageSize
from reportlab.lib.pagesizes import letter
from django.views.generic.base import TemplateView
from django.shortcuts import render


def view_PO(modelAdmin, request, queryset):

    defaultPageSize = letter
    width = defaultPageSize[0]
    height = defaultPageSize[1]
    print(width, height)

    return render(request, 'restapi/purchaseOrder.html')
    
    # for val in queryset:
    #     buffer = io.BytesIO()
    #     p = canvas.Canvas(buffer)
    #     p.drawString(75,750, "Purchase Order")
    #     top = 750

    #     productOrderQuery = Product_Order.objects.filter(order = val.id)
    #     totalCost = 0

    #     top = top - 50
    #     p.drawString(75, top, "Item Number")
    #     p.drawString(175, top, "Product Name")
    #     p.drawString(375, top, "Quantity")
    #     p.drawString(425, top, "Purchase Price")
    #     p.drawString(475, top, "Total Cost")
        
    #     for productOrder in productOrderQuery:
    #         top = top - 50
    #         p.drawString(75, top, str(productOrder.product.itemNumber))
    #         p.drawString(175, top, productOrder.product.name)
    #         p.drawString(375, top, str(productOrder.quantity))
    #         p.drawString(425, top, str(productOrder.price_real))
    #         p.drawString(475, top, str(productOrder.price_real * productOrder.quantity))

    #         totalCost += productOrder.price_real * productOrder.quantity

    #     p.drawString(475, top, str(totalCost))

    #     p.showPage()
    #     p.save()
    #     buffer.seek(0)
        
    #     return FileResponse(buffer, buffer, as_attachment=True, filename = "P0_" + str(val.id) + "_" + str(val.jobSite.code)) 


    

def fulfill_orders(modeladmin, request, queryset):
    queryset.update(fulfilled='True')
    fulfill_orders.short_description = "Fulfill selected orders"

class ProductOrder_inLine(admin.TabularInline):
    model = Product_Order
    extra = 1

class OrderAdmin(admin.ModelAdmin):
    actions = [fulfill_orders, view_PO]
    inlines = (ProductOrder_inLine,)

# class ProductAdmin(admin.ModelAdmin):
#     inlines = (ProductOrder_inLine,)

admin.site.register(Order, OrderAdmin)
admin.site.register(Product)
# admin.site.register(Product_Order)




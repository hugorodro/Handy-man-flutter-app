from django.db import models
from django.conf import settings
from datetime import datetime
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from django.dispatch import receiver
from rest_framework.authtoken.models import Token
from django.db.models.signals import post_save


# Create your models here.

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)

class Vendor(models.Model):
    name = models.CharField(max_length=256)
    address = models.CharField(max_length =50)
    url = models.URLField()

    def __str__(self):
        return self.name

class JobSite(models.Model):
    name = models.CharField(max_length=256, default="")
    code = models.CharField(max_length=10)
    address = models.CharField(max_length = 256)
    def __str__(self): 
        return self.code + " - " + self.name


class Product(models.Model):
    name = models.CharField(max_length=256)
    price_estimate = models.DecimalField(decimal_places=2, max_digits=10)
    specs = models.CharField(max_length=50)
    numInPack = models.IntegerField()
    itemNumber = models.IntegerField(default=0)
    vendor = models.ForeignKey(
        Vendor,
        on_delete = models.CASCADE
    )
    def __str__(self): 
        return self.name

    def getPrice(self):
        return self.price_estimate


class Order(models.Model):
    date = models.DateField(auto_now=True)
    fulfilled = models.BooleanField(default=False)
    products = models.ManyToManyField(Product, through='Product_Order')
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
    jobSite = models.ForeignKey(
        JobSite,
        on_delete = models.CASCADE,
    )

    def __str__(self):
        
        return (str(self.date)  + ", "+ self.user.first_name + " " + self.user.last_name + ", " +
            self.jobSite.name )

class Product_Order(models.Model):
    product = models.ForeignKey(Product, on_delete= models.CASCADE)
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    price_real = models.DecimalField(default=0.00 ,decimal_places=2, max_digits=10 )
    quantity = models.IntegerField()
    time = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.product.name  + ", "+ str(self.quantity)


# class Equipment(models.Model):
#     name = models.CharField(max_length = 256)
    
#     def __str__(self):
#         return self.name



# class EquipmentStatus(models.Model):
#     date = models.DateTimeField(default=datetime.now)
#     equipment = models.ForeignKey(
#         Equipment,
#         on_delete=models.CASCADE
#     )
#     user = models.ForeignKey(
#         settings.AUTH_USER_MODEL,
#         on_delete=models.CASCADE
#     )
#     jobSite = models.ForeignKey(
#         JobSite,
#         on_delete =models.CASCADE
#     )
#     def __str__(self):
#         return self.equipment.name + ", "+ self.user.email + ", "+ self.jobSite.name + ", " +self.date

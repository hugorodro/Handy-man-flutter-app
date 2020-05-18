from django.db import models
from django.conf import settings
from datetime import datetime


# Create your models here.
class Vendor(models.Model):
    name = models.CharField(max_length=256)
    address = models.CharField(max_length =50)
    def __str__(self):
        return self.name



class Product(models.Model):
    name = models.CharField(max_length=256)
    price = models.DecimalField(decimal_places=2, max_digits=10)
    specs = models.CharField(max_length=50)
    numInPack = models.IntegerField()
    url = models.URLField()
    vendor = models.ForeignKey(
        Vendor,
        on_delete = models.CASCADE
    )
    def __str__(self): 
        return self.name



class JobSite(models.Model):
    name = models.CharField(max_length=256, default="")
    code = models.CharField(max_length=10)
    address = models.CharField(max_length = 256)
    def __str__(self): 
        return self.code + self.name + self.address



class Order(models.Model):
    quantity = models.IntegerField()
    date = models.DateTimeField(default=datetime.now)
    fulfilled = models.BooleanField(default=False)
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
    product = models.ForeignKey(
        Product,
        on_delete= models.CASCADE,
    )
    jobSite = models.ForeignKey(
        JobSite,
        on_delete = models.CASCADE,
        
    )
    def __str__(self):
        return self.user.first_name + ", " + self.jobSite.name + ", "+ str(self.date.date()) 



class Equipment(models.Model):
    name = models.CharField(max_length = 256)
    
    def __str__(self):
        return self.name



class EquipmentStatus(models.Model):
    date = models.DateTimeField(default=datetime.now)
    equipment = models.ForeignKey(
        Equipment,
        on_delete=models.CASCADE
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE
    )
    jobSite = models.ForeignKey(
        JobSite,
        on_delete =models.CASCADE
    )
    def __str__(self):
        return self.equipment.name + ", "+ self.user.email + ", "+ self.jobSite.name + ", " +self.date
"""lunaconWeb URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from lunaconAPI import views
from django.views.generic import RedirectView
from django.conf.urls import url


router = routers.DefaultRouter()
router.register(r'orders', views.OrderView)
router.register(r'equipment status', views.EquipmentStatusView)
router.register(r'products', views.ProductView)
router.register(r'jobsite', views.JobSiteView)

 
urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin.site.urls),
    # path('home/', views.home, name= 'home'),
    # path('placeorder', views.placeorder, name= 'placeorder'),
    # path('placeorder/placeorders', views.placeorders, name = 'placeorders'),
    # # url(r'^favicon\.ico$',RedirectView.as_view(url='/static/images/favicon.ico')),
    # path('', views.login_request, name="login"),
]

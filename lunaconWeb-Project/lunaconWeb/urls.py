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
from lunaconAPI.views import OrderView, CustomObtainAuthToken, ProductView, JobSiteView, VendorView, AuthorizedOrderView
from rest_framework.authtoken.views import obtain_auth_token
from django.views.generic import RedirectView
from django.conf.urls import url


router = routers.DefaultRouter()
router.register(r'authorizedOrders', AuthorizedOrderView)
router.register(r'orders', OrderView)
# router.register(r'equipment status', EquipmentStatusView)
router.register(r'products', ProductView)
router.register(r'jobsite',  JobSiteView)
router.register(r'vendor', VendorView)
# router.register(r'user_info', UserExistsView)

# router.register(r'user', UserExistsView)



 
urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin.site.urls),
    path('login/', CustomObtainAuthToken.as_view(), name='login')

    # path('home/', views.home, name= 'home'),
    # path('placeorder', views.placeorder, name= 'placeorder'),
    # path('placeorder/placeorders', views.placeorders, name = 'placeorders'),
    # # url(r'^favicon\.ico$',RedirectView.as_view(url='/static/images/favicon.ico')),
    # path('', views.login_request, name="login"),
]

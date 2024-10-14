from django.urls import path, include
from django.contrib import admin
from rest_framework.routers import DefaultRouter
from tes.views import (
    DosenViewSet, MahasiswaViewSet, AdminsViewSet, PenggunaViewSet,
    PerwalianListView, ListMahasiswaViewSet, perwalian_post, perwalian_delete,
    user_signup, user_login, user_logout
)
from django.views.generic import RedirectView

router = DefaultRouter()
router.register(r'dosen', DosenViewSet)
router.register(r'mahasiswa', MahasiswaViewSet)
router.register(r'admins', AdminsViewSet)
router.register(r'pengguna', PenggunaViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('signup/', user_signup, name='user_signup'),
    path('login/', user_login, name='user_login'),
    path('logout/', user_logout, name='user_logout'),
    path('', include(router.urls)),
    path('perwalian/<int:id_dosen>/', PerwalianListView.as_view(), name='perwalian-list'),
    path('perwalian/', perwalian_post, name='perwalian-post'),
    path('perwalian/<int:id_dosen>/<int:id_mahasiswa>/', perwalian_delete, name='perwalian_delete'),
    path('nonperwalian/', ListMahasiswaViewSet.as_view({'get': 'list'}), name='mahasiswa-nonperwalian'),
    path('', RedirectView.as_view(url='/api/')),
]

# Generated by Django 5.0.4 on 2024-04-22 13:39

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Admin',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama_admin', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'admin',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthGroup',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=150, unique=True)),
            ],
            options={
                'db_table': 'auth_group',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthGroupPermissions',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'auth_group_permissions',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthPermission',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('codename', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'auth_permission',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthUser',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128)),
                ('last_login', models.DateTimeField(blank=True, null=True)),
                ('is_superuser', models.IntegerField()),
                ('username', models.CharField(max_length=150, unique=True)),
                ('first_name', models.CharField(max_length=150)),
                ('last_name', models.CharField(max_length=150)),
                ('email', models.CharField(max_length=254)),
                ('is_staff', models.IntegerField()),
                ('is_active', models.IntegerField()),
                ('date_joined', models.DateTimeField()),
            ],
            options={
                'db_table': 'auth_user',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthUserGroups',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'auth_user_groups',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthUserUserPermissions',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'auth_user_user_permissions',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Bobot',
            fields=[
                ('id_bobot', models.AutoField(primary_key=True, serialize=False)),
                ('bobot_ipk', models.FloatField(blank=True, db_column='bobot_IPK', null=True)),
                ('bobot_sk2pm', models.FloatField(blank=True, db_column='bobot_SK2PM', null=True)),
                ('bobot_ukt', models.FloatField(blank=True, db_column='bobot_UKT', null=True)),
                ('bobot_semester', models.FloatField(blank=True, null=True)),
                ('bobot_ips', models.FloatField(blank=True, db_column='bobot_IPS', null=True)),
            ],
            options={
                'db_table': 'bobot',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoAdminLog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('action_time', models.DateTimeField()),
                ('object_id', models.TextField(blank=True, null=True)),
                ('object_repr', models.CharField(max_length=200)),
                ('action_flag', models.PositiveSmallIntegerField()),
                ('change_message', models.TextField()),
            ],
            options={
                'db_table': 'django_admin_log',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoContentType',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('app_label', models.CharField(max_length=100)),
                ('model', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'django_content_type',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoMigrations',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('app', models.CharField(max_length=255)),
                ('name', models.CharField(max_length=255)),
                ('applied', models.DateTimeField()),
            ],
            options={
                'db_table': 'django_migrations',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoSession',
            fields=[
                ('session_key', models.CharField(max_length=40, primary_key=True, serialize=False)),
                ('session_data', models.TextField()),
                ('expire_date', models.DateTimeField()),
            ],
            options={
                'db_table': 'django_session',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Dosen',
            fields=[
                ('id_dosen', models.AutoField(primary_key=True, serialize=False)),
                ('nama_dosen', models.CharField(blank=True, max_length=50, null=True)),
                ('nip', models.CharField(blank=True, max_length=50, null=True)),
                ('foto_dosen', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'dosen',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Mahasiswa',
            fields=[
                ('id_mahasiswa', models.AutoField(primary_key=True, serialize=False)),
                ('nama', models.CharField(blank=True, max_length=50, null=True)),
                ('nim', models.CharField(blank=True, max_length=50, null=True)),
                ('ips', models.FloatField(blank=True, db_column='IPS', null=True)),
                ('ipk', models.FloatField(blank=True, db_column='IPK', null=True)),
                ('sk2pm', models.IntegerField(blank=True, db_column='SK2PM', null=True)),
                ('pembayaran_ukt', models.CharField(blank=True, db_column='Pembayaran_UKT', max_length=11, null=True)),
                ('semester', models.IntegerField(blank=True, null=True)),
                ('foto_mahasiswa', models.CharField(blank=True, max_length=50, null=True)),
                ('status', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'mahasiswa',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id_user', models.AutoField(primary_key=True, serialize=False)),
                ('username', models.CharField(blank=True, max_length=50, null=True)),
                ('password', models.CharField(blank=True, max_length=50, null=True)),
                ('role', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'user',
                'managed': False,
            },
        ),
    ]
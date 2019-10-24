Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31683 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392913AbfJXDbr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Oct 2019 23:31:47 -0400
Subject: Re: [PATCH V5 2/6] modpost: add support for mdev class id
References: <20191023130752.18980-1-jasowang@redhat.com>
 <20191023130752.18980-3-jasowang@redhat.com>
 <20191023154245.32e4fa49@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <555a101e-0ed1-2e9d-c1a4-e3b37d76bd18@redhat.com>
Date: Thu, 24 Oct 2019 11:31:04 +0800
MIME-Version: 1.0
In-Reply-To: <20191023154245.32e4fa49@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/10/24 =E4=B8=8A=E5=8D=885:42, Alex Williamson wrote:
> On Wed, 23 Oct 2019 21:07:48 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> Add support to parse mdev class id table.
>>
>> Reviewed-by: Parav Pandit <parav@mellanox.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vfio/mdev/vfio_mdev.c     |  2 ++
>>   scripts/mod/devicetable-offsets.c |  3 +++
>>   scripts/mod/file2alias.c          | 10 ++++++++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev=
.c
>> index 7b24ee9cb8dd..cb701cd646f0 100644
>> --- a/drivers/vfio/mdev/vfio_mdev.c
>> +++ b/drivers/vfio/mdev/vfio_mdev.c
>> @@ -125,6 +125,8 @@ static const struct mdev_class_id id_table[] =3D {
>>   =09{ 0 },
>>   };
>>  =20
>> +MODULE_DEVICE_TABLE(mdev, id_table);
>> +
> Two questions, first we have:
>
> #define MODULE_DEVICE_TABLE(type, name)                                 \
> extern typeof(name) __mod_##type##__##name##_device_table               \
>    __attribute__ ((unused, alias(__stringify(name))))
>
> Therefore we're defining __mod_mdev__id_table_device_table with alias
> id_table.  When the virtio mdev bus driver is added in 5/6 it uses the
> same name value.  I see virtio types all register this way (virtio,
> id_table), so I assume there's no conflict, but pci types mostly (not
> entirely) seem to use unique names.  Is there a preference to one way
> or the other or it simply doesn't matter?


It looks to me that those symbol were local, so it doesn't matter. But=20
if you wish I can switch to use unique name.


>
>>   static struct mdev_driver vfio_mdev_driver =3D {
>>   =09.name=09=3D "vfio_mdev",
>>   =09.probe=09=3D vfio_mdev_probe,
>> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable=
-offsets.c
>> index 054405b90ba4..6cbb1062488a 100644
>> --- a/scripts/mod/devicetable-offsets.c
>> +++ b/scripts/mod/devicetable-offsets.c
>> @@ -231,5 +231,8 @@ int main(void)
>>   =09DEVID(wmi_device_id);
>>   =09DEVID_FIELD(wmi_device_id, guid_string);
>>  =20
>> +=09DEVID(mdev_class_id);
>> +=09DEVID_FIELD(mdev_class_id, id);
>> +
>>   =09return 0;
>>   }
>> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
>> index c91eba751804..d365dfe7c718 100644
>> --- a/scripts/mod/file2alias.c
>> +++ b/scripts/mod/file2alias.c
>> @@ -1335,6 +1335,15 @@ static int do_wmi_entry(const char *filename, voi=
d *symval, char *alias)
>>   =09return 1;
>>   }
>>  =20
>> +/* looks like: "mdev:cN" */
>> +static int do_mdev_entry(const char *filename, void *symval, char *alia=
s)
>> +{
>> +=09DEF_FIELD(symval, mdev_class_id, id);
>> +
>> +=09sprintf(alias, "mdev:c%02X", id);
> A lot of entries call add_wildcard() here, should we?  Sorry for the
> basic questions, I haven't played in this code.  Thanks,


It's really good question. My understanding is we won't have a module=20
that can deal with all kinds of classes like CLASS_ID_ANY. So there's=20
probably no need for the wildcard.

Thanks


>
> Alex
>
>> +=09return 1;
>> +}
>> +
>>   /* Does namelen bytes of name exactly match the symbol? */
>>   static bool sym_is(const char *name, unsigned namelen, const char *sym=
bol)
>>   {
>> @@ -1407,6 +1416,7 @@ static const struct devtable devtable[] =3D {
>>   =09{"typec", SIZE_typec_device_id, do_typec_entry},
>>   =09{"tee", SIZE_tee_client_device_id, do_tee_entry},
>>   =09{"wmi", SIZE_wmi_device_id, do_wmi_entry},
>> +=09{"mdev", SIZE_mdev_class_id, do_mdev_entry},
>>   };
>>  =20
>>   /* Create MODULE_ALIAS() statements.

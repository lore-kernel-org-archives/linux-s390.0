Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730160AbfKEDSO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 22:18:14 -0500
Subject: Re: [PATCH V7 1/6] mdev: class id support
References: <20191104123952.17276-1-jasowang@redhat.com>
 <20191104123952.17276-2-jasowang@redhat.com>
 <20191104145002.4dfed0c4@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <faaa43d8-662e-9b1e-a25a-5f242341a974@redhat.com>
Date: Tue, 5 Nov 2019 11:16:21 +0800
MIME-Version: 1.0
In-Reply-To: <20191104145002.4dfed0c4@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/11/5 =E4=B8=8A=E5=8D=885:50, Alex Williamson wrote:
> On Mon,  4 Nov 2019 20:39:47 +0800
> Jason Wang<jasowang@redhat.com>  wrote:
>
>> Mdev bus only supports vfio driver right now, so it doesn't implement
>> match method. But in the future, we may add drivers other than vfio,
>> the first driver could be virtio-mdev. This means we need to add
>> device class id support in bus match method to pair the mdev device
>> and mdev driver correctly.
>>
>> So this patch adds id_table to mdev_driver and class_id for mdev
>> device with the match method for mdev bus.
>>
>> Reviewed-by: Parav Pandit<parav@mellanox.com>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   .../driver-api/vfio-mediated-device.rst       |  5 ++++
>>   drivers/gpu/drm/i915/gvt/kvmgt.c              |  1 +
>>   drivers/s390/cio/vfio_ccw_ops.c               |  1 +
>>   drivers/s390/crypto/vfio_ap_ops.c             |  1 +
>>   drivers/vfio/mdev/mdev_core.c                 | 16 ++++++++++++
>>   drivers/vfio/mdev/mdev_driver.c               | 25 +++++++++++++++++++
>>   drivers/vfio/mdev/mdev_private.h              |  1 +
>>   drivers/vfio/mdev/vfio_mdev.c                 |  6 +++++
>>   include/linux/mdev.h                          |  8 ++++++
>>   include/linux/mod_devicetable.h               |  8 ++++++
>>   samples/vfio-mdev/mbochs.c                    |  1 +
>>   samples/vfio-mdev/mdpy.c                      |  1 +
>>   samples/vfio-mdev/mtty.c                      |  1 +
>>   13 files changed, 75 insertions(+)
>>
>> diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documen=
tation/driver-api/vfio-mediated-device.rst
>> index 25eb7d5b834b..6709413bee29 100644
>> --- a/Documentation/driver-api/vfio-mediated-device.rst
>> +++ b/Documentation/driver-api/vfio-mediated-device.rst
>> @@ -102,12 +102,14 @@ structure to represent a mediated device's driver:=
:
>>         * @probe: called when new device created
>>         * @remove: called when device removed
>>         * @driver: device driver structure
>> +      * @id_table: the ids serviced by this driver
>>         */
>>        struct mdev_driver {
>>   =09     const char *name;
>>   =09     int  (*probe)  (struct device *dev);
>>   =09     void (*remove) (struct device *dev);
>>   =09     struct device_driver    driver;
>> +=09     const struct mdev_class_id *id_table;
>>        };
>>  =20
>>   A mediated bus driver for mdev should use this structure in the functi=
on calls
>> @@ -170,6 +172,9 @@ that a driver should use to unregister itself with t=
he mdev core driver::
>>  =20
>>   =09extern void mdev_unregister_device(struct device *dev);
>>  =20
>> +It is also required to specify the class_id in create() callback throug=
h::
>> +
>> +=09int mdev_set_class(struct mdev_device *mdev, u16 id);
>>  =20
>>   Mediated Device Management Interface Through sysfs
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt=
/kvmgt.c
>> index 343d79c1cb7e..6420f0dbd31b 100644
>> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
>> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
>> @@ -678,6 +678,7 @@ static int intel_vgpu_create(struct kobject *kobj, s=
truct mdev_device *mdev)
>>   =09=09     dev_name(mdev_dev(mdev)));
>>   =09ret =3D 0;
>>  =20
>> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>>   out:
>>   =09return ret;
>>   }
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw=
_ops.c
>> index f0d71ab77c50..cf2c013ae32f 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -129,6 +129,7 @@ static int vfio_ccw_mdev_create(struct kobject *kobj=
, struct mdev_device *mdev)
>>   =09=09=09   private->sch->schid.ssid,
>>   =09=09=09   private->sch->schid.sch_no);
>>  =20
>> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>>   =09return 0;
>>   }
>>  =20
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfi=
o_ap_ops.c
>> index 5c0f53c6dde7..07c31070afeb 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -343,6 +343,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj,=
 struct mdev_device *mdev)
>>   =09list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>>   =09mutex_unlock(&matrix_dev->lock);
>>  =20
>> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>>   =09return 0;
>>   }
>>  =20
>> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core=
.c
>> index b558d4cfd082..d23ca39e3be6 100644
>> --- a/drivers/vfio/mdev/mdev_core.c
>> +++ b/drivers/vfio/mdev/mdev_core.c
>> @@ -45,6 +45,16 @@ void mdev_set_drvdata(struct mdev_device *mdev, void =
*data)
>>   }
>>   EXPORT_SYMBOL(mdev_set_drvdata);
>>  =20
>> +/* Specify the class for the mdev device, this must be called during
>> + * create() callback.
>> + */
> Standard non-networking multi-line comment style please, ie.
>
> /*
>   * Multi-
>   * line
>   * comment
>   */
>
> Thanks,
> Alex
>

Will fix.

Thanks

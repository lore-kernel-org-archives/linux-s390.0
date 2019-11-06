Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: [PATCH V8 3/6] mdev: introduce device specific ops
References: <20191105093240.5135-1-jasowang@redhat.com>
 <20191105093240.5135-4-jasowang@redhat.com>
 <20191105175025.1a620844.cohuck@redhat.com> <20191105104418.1735d800@x1.home>
 <20191105192851.40548978.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42afbc46-ac7d-b4d7-9b4a-343b1400d2a8@redhat.com>
Date: Wed, 6 Nov 2019 11:48:25 +0800
MIME-Version: 1.0
In-Reply-To: <20191105192851.40548978.cohuck@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/11/6 =E4=B8=8A=E5=8D=882:28, Cornelia Huck wrote:
> On Tue, 5 Nov 2019 10:44:18 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
>
>> On Tue, 5 Nov 2019 17:50:25 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> On Tue,  5 Nov 2019 17:32:37 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>   =20
>>>> Currently, except for the create and remove, the rest of
>>>> mdev_parent_ops is designed for vfio-mdev driver only and may not help
>>>> for kernel mdev driver. With the help of class id, this patch
>>>> introduces device specific callbacks inside mdev_device
>>>> structure. This allows different set of callback to be used by
>>>> vfio-mdev and virtio-mdev.
>>>>
>>>> Reviewed-by: Parav Pandit <parav@mellanox.com>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>   .../driver-api/vfio-mediated-device.rst       | 35 +++++++++----
>>>>   MAINTAINERS                                   |  1 +
>>>>   drivers/gpu/drm/i915/gvt/kvmgt.c              | 18 ++++---
>>>>   drivers/s390/cio/vfio_ccw_ops.c               | 18 ++++---
>>>>   drivers/s390/crypto/vfio_ap_ops.c             | 14 +++--
>>>>   drivers/vfio/mdev/mdev_core.c                 | 24 ++++++++-
>>>>   drivers/vfio/mdev/mdev_private.h              |  5 ++
>>>>   drivers/vfio/mdev/vfio_mdev.c                 | 37 ++++++-------
>>>>   include/linux/mdev.h                          | 43 ++++-----------
>>>>   include/linux/mdev_vfio_ops.h                 | 52 +++++++++++++++++=
++
>>>>   samples/vfio-mdev/mbochs.c                    | 20 ++++---
>>>>   samples/vfio-mdev/mdpy.c                      | 20 ++++---
>>>>   samples/vfio-mdev/mtty.c                      | 18 ++++---
>>>>   13 files changed, 206 insertions(+), 99 deletions(-)
>>>>   create mode 100644 include/linux/mdev_vfio_ops.h
>>>>     =20
>>> (...)
>>>   =20
>>>> @@ -172,10 +163,34 @@ that a driver should use to unregister itself wi=
th the mdev core driver::
>>>>  =20
>>>>   =09extern void mdev_unregister_device(struct device *dev);
>>>>  =20
>>>> -It is also required to specify the class_id in create() callback thro=
ugh::
>>>> +As multiple types of mediated devices may be supported, class id need=
s
>>>> +to be specified in the create callback(). This could be done
>>> The brackets should probably go behind 'create'?
>>>   =20
>>>> +explicitly for the device that does not use on mdev bus for its
>>> "for devices that do not use the mdev bus" ?
>>>
>>> But why wouldn't they? I feel like I've missed some discussion here :/
>> The device ops provide a route through mdev-core for known callbacks,
>> which is primarily useful when we have 1:N relation between mdev bus
>> driver and vendor drivers.  The obvious example here is vfio-mdev,
>> where we have GVT-g, vfio-ap, vfio-ccw, NVIDIA GRID, and various sample
>> drivers all advertising vfio-mdev support via their class id.  However,
>> if we have a tightly coupled vendor driver and mdev bus driver, as the
>> mlx5 support that Parav is developing, the claim is that they prefer
>> not to expose any device ops and intend to interact directly with the
>> mdev device.  At least that's my understanding.  Thanks,
>>
>> Alex
> Ah, ok.
>
> So maybe use the phrasing "devices that interact with the mdev device
> directly" vs "devices that use device-specific ops" instead?
>
> Not a strong critique, though.


Will use what you suggest here.

Thanks


>
>>>> +operation through:
>>>>  =20
>>>>   =09int mdev_set_class(struct mdev_device *mdev, u16 id);
>>>>  =20
>>>> +For the device that uses on the mdev bus for its operation, the
>>>> class
>>> "For devices that use the mdev bus..."
>>>
>>> But same comment as above.
>>>   =20
>>>> +should provide helper function to set class id and device
>>>> specific +ops. E.g for vfio-mdev devices, the function to be
>>>> called is:: +
>>>> +=09int mdev_set_vfio_ops(struct mdev_device *mdev,
>>>> +                              const struct mdev_vfio_device_ops
>>>> *vfio_ops); +
>>>> +The class id (set by this function to MDEV_CLASS_ID_VFIO) is
>>>> used to +match a device with an mdev driver via its id table. The
>>>> device +specific callbacks (specified in *vfio_ops) are
>>>> obtainable via +mdev_get_vfio_ops() (for use by the mdev bus
>>>> driver). A vfio-mdev +device (class id MDEV_CLASS_ID_VFIO) uses
>>>> the following +device-specific ops:
>>>> +
>>>> +* open: open callback of vfio mediated device
>>>> +* close: close callback of vfio mediated device
>>>> +* ioctl: ioctl callback of vfio mediated device
>>>> +* read : read emulation callback
>>>> +* write: write emulation callback
>>>> +* mmap: mmap emulation callback
>>>> +
>>>>   Mediated Device Management Interface Through sysfs
>>>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>> Otherwise, looks good.

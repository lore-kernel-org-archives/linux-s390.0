Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34393 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730176AbfKEDTX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 22:19:23 -0500
Subject: Re: [PATCH V7 3/6] mdev: introduce device specific ops
References: <20191104123952.17276-1-jasowang@redhat.com>
 <20191104123952.17276-4-jasowang@redhat.com>
 <20191104145008.4b6839f0@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <47ecfe09-0954-9517-3ac5-68db8522826d@redhat.com>
Date: Tue, 5 Nov 2019 11:17:28 +0800
MIME-Version: 1.0
In-Reply-To: <20191104145008.4b6839f0@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/11/5 =E4=B8=8A=E5=8D=885:50, Alex Williamson wrote:
>>   EXPORT_SYMBOL(mdev_set_drvdata);
>>  =20
>> +
> Extra whitespace
>
>>   /* Specify the class for the mdev device, this must be called during
>> - * create() callback.
>> - */
>> + * create() callback explicitly or implicity through the helpers
> s/implicity/implicitly/
>
>> + * provided by each class. */
>>   void mdev_set_class(struct mdev_device *mdev, u16 id)
>>   {
>>   =09WARN_ON(mdev->class_id);
>> @@ -55,6 +56,26 @@ void mdev_set_class(struct mdev_device *mdev, u16 id)
>>   }
>>   EXPORT_SYMBOL(mdev_set_class);
>>  =20
>> +/* Specify the mdev device to be a VFIO mdev device, and set VFIO
>> + * device ops for it. This must be called from the create() callback
>> + * for VFIO mdev device.
>> + */
> Comment style.  Thanks,


Will fix them all.

Thanks


>
> Alex
>

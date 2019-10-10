Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733144AbfJJJSc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 05:18:32 -0400
Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
References: <20190924135332.14160-1-jasowang@redhat.com>
 <20190924135332.14160-7-jasowang@redhat.com>
 <20190924170640.1da03bae@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42b17911-7e40-3762-8f70-709c5ce7e0d0@redhat.com>
Date: Thu, 10 Oct 2019 17:18:03 +0800
MIME-Version: 1.0
In-Reply-To: <20190924170640.1da03bae@x1.home>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com


On 2019/9/25 上午7:06, Alex Williamson wrote:
> On Tue, 24 Sep 2019 21:53:30 +0800
> Jason Wang<jasowang@redhat.com>  wrote:
>
>> This patch implements basic support for mdev driver that supports
>> virtio transport for kernel virtio driver.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   include/linux/mdev.h        |   2 +
>>   include/linux/virtio_mdev.h | 145 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 147 insertions(+)
>>   create mode 100644 include/linux/virtio_mdev.h
>>
>> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
>> index 3414307311f1..73ac27b3b868 100644
>> --- a/include/linux/mdev.h
>> +++ b/include/linux/mdev.h
>> @@ -126,6 +126,8 @@ struct mdev_device *mdev_from_dev(struct device *dev);
>>   
>>   enum {
>>   	MDEV_ID_VFIO = 1,
>> +	MDEV_ID_VIRTIO = 2,
>> +	MDEV_ID_VHOST = 3,
> MDEV_ID_VHOST isn't used yet here.  Also, given the strong
> interdependence between the class_id and the ops structure, we might
> wand to define them in the same place.  Thanks,
>
> Alex
>

Rethink about this, consider we may have more types of devices supported 
in the future, moving all device_ops to mdev.h seems unnecessary. I 
prefer to keep the device_ops into their own headers.

Thanks

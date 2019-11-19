Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58514 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727014AbfKSDF3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 22:05:29 -0500
Subject: Re: [PATCH V13 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
References: <20191118105923.7991-1-jasowang@redhat.com>
 <20191118105923.7991-7-jasowang@redhat.com>
 <20191118164510.549c097b.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a4e504d-abb9-44f1-73ea-e337f596bf75@redhat.com>
Date: Tue, 19 Nov 2019 11:04:51 +0800
MIME-Version: 1.0
In-Reply-To: <20191118164510.549c097b.cohuck@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, gregkh@linuxfoundation.org, jgg@mellanox.com, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com


On 2019/11/18 =E4=B8=8B=E5=8D=8811:45, Cornelia Huck wrote:
> On Mon, 18 Nov 2019 18:59:23 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> [Note: I have not looked into the reworked architecture of this *at all*
> so far; just something that I noted...]
>
>> This sample driver creates mdev device that simulate virtio net device
>> over virtio mdev transport. The device is implemented through vringh
>> and workqueue. A device specific dma ops is to make sure HVA is used
>> directly as the IOVA. This should be sufficient for kernel virtio
>> driver to work.
>>
>> Only 'virtio' type is supported right now. I plan to add 'vhost' type
>> on top which requires some virtual IOMMU implemented in this sample
>> driver.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   MAINTAINERS                        |   1 +
>>   samples/Kconfig                    |  10 +
>>   samples/vfio-mdev/Makefile         |   1 +
>>   samples/vfio-mdev/mvnet_loopback.c | 690 +++++++++++++++++++++++++++++
>>   4 files changed, 702 insertions(+)
>>   create mode 100644 samples/vfio-mdev/mvnet_loopback.c
>>
>> +static struct mvnet_dev {
>> +=09struct class=09*vd_class;
>> +=09struct idr=09vd_idr;
>> +=09struct device=09dev;
>> +} mvnet_dev;
> This structure embeds a struct device (a reference-counted structure),
> yet it is a static variable. This is giving a bad example to potential
> implementers; just allocate it dynamically.


Yes, as spotted by Greg.


>
>> +static void mvnet_device_release(struct device *dev)
>> +{
>> +=09dev_dbg(dev, "mvnet: released\n");
> And that also means you need a proper release function here, of
> course.


Right.

Thanks


>
>> +}

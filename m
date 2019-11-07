Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33634 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726033AbfKGObR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Nov 2019 09:31:17 -0500
Subject: Re: [PATCH V9 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
References: <20191106070548.18980-1-jasowang@redhat.com>
 <20191106070548.18980-7-jasowang@redhat.com>
 <88efad07-70aa-3879-31e7-ace4d2ad63a1@infradead.org>
 <20191106155800.0b8418ec@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b26d298-0223-c5cc-9dd6-c4005139e32a@redhat.com>
Date: Thu, 7 Nov 2019 22:30:37 +0800
MIME-Version: 1.0
In-Reply-To: <20191106155800.0b8418ec@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/11/7 =E4=B8=8A=E5=8D=886:58, Alex Williamson wrote:
> On Wed, 6 Nov 2019 14:50:30 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> On 11/5/19 11:05 PM, Jason Wang wrote:
>>> diff --git a/samples/Kconfig b/samples/Kconfig
>>> index c8dacb4dda80..13a2443e18e0 100644
>>> --- a/samples/Kconfig
>>> +++ b/samples/Kconfig
>>> @@ -131,6 +131,16 @@ config SAMPLE_VFIO_MDEV_MDPY
>>>   =09  mediated device.  It is a simple framebuffer and supports
>>>   =09  the region display interface (VFIO_GFX_PLANE_TYPE_REGION).
>>>  =20
>>> +config SAMPLE_VIRTIO_MDEV_NET
>>> +=09tristate "Build VIRTIO net example mediated device sample code -- l=
oadable modules only"
>>> +=09depends on VIRTIO_MDEV && VHOST_RING && m
>>> +=09help
>>> +=09  Build a networking sample device for use as a virtio
>>> +=09  mediated device. The device coopreates with virtio-mdev bus
>> typo here:
>> =09                              cooperates
>>
> I can fix this on commit relative to V10 if there are no other issues
> raised:
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 13a2443e18e0..b7116d97cbbe 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -136,7 +136,7 @@ config SAMPLE_VIRTIO_MDEV_NET
>          depends on VIRTIO_MDEV && VHOST_RING && m
>          help
>            Build a networking sample device for use as a virtio
> -         mediated device. The device coopreates with virtio-mdev bus
> +         mediated device. The device cooperates with virtio-mdev bus
>            driver to present an virtio ethernet driver for
>            kernel. It simply loopbacks all packets from its TX
>            virtqueue to its RX virtqueue.
>
> Thanks,
> Alex


Thanks, per Michael request, I would rename mvnet and include this fix=20
in V11.


>

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26156 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387518AbfKGEMJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 23:12:09 -0500
Subject: Re: [PATCH V8 0/6] mdev based hardware virtio offloading support
References: <20191105093240.5135-1-jasowang@redhat.com>
 <20191105105834.469675f0@x1.home>
 <393f2dc9-8c67-d3c9-6553-640b80c15aaf@redhat.com>
 <20191106120312.77a6a318@x1.home>
 <20191106142449-mutt-send-email-mst@kernel.org>
 <20191106141318.150f3b9b@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1c1126ec-94b8-5d1a-8ef6-616604e5a93f@redhat.com>
Date: Thu, 7 Nov 2019 12:11:30 +0800
MIME-Version: 1.0
In-Reply-To: <20191106141318.150f3b9b@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/11/7 =E4=B8=8A=E5=8D=885:13, Alex Williamson wrote:
> On Wed, 6 Nov 2019 14:25:23 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Wed, Nov 06, 2019 at 12:03:12PM -0700, Alex Williamson wrote:
>>> On Wed, 6 Nov 2019 11:56:46 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>   =20
>>>> On 2019/11/6 =E4=B8=8A=E5=8D=881:58, Alex Williamson wrote:
>>>>> On Tue,  5 Nov 2019 17:32:34 +0800
>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>    =20
>>>>>> Hi all:
>>>>>>
>>>>>> There are hardwares that can do virtio datapath offloading while
>>>>>> having its own control path. This path tries to implement a mdev bas=
ed
>>>>>> unified API to support using kernel virtio driver to drive those
>>>>>> devices. This is done by introducing a new mdev transport for virtio
>>>>>> (virtio_mdev) and register itself as a new kind of mdev driver. Then
>>>>>> it provides a unified way for kernel virtio driver to talk with mdev
>>>>>> device implementation.
>>>>>>
>>>>>> Though the series only contains kernel driver support, the goal is t=
o
>>>>>> make the transport generic enough to support userspace drivers. This
>>>>>> means vhost-mdev[1] could be built on top as well by resuing the
>>>>>> transport.
>>>>>>
>>>>>> A sample driver is also implemented which simulate a virito-net
>>>>>> loopback ethernet device on top of vringh + workqueue. This could be
>>>>>> used as a reference implementation for real hardware driver.
>>>>>>
>>>>>> Also a real ICF VF driver was also posted here[2] which is a good
>>>>>> reference for vendors who is interested in their own virtio datapath
>>>>>> offloading product.
>>>>>>
>>>>>> Consider mdev framework only support VFIO device and driver right no=
w,
>>>>>> this series also extend it to support other types. This is done
>>>>>> through introducing class id to the device and pairing it with
>>>>>> id_talbe claimed by the driver. On top, this seris also decouple
>>>>>> device specific parents ops out of the common ones.
>>>>>>
>>>>>> Pktgen test was done with virito-net + mvnet loop back device.
>>>>>>
>>>>>> Please review.
>>>>>>
>>>>>> [1] https://lkml.org/lkml/2019/10/31/440
>>>>>> [2] https://lkml.org/lkml/2019/10/15/1226
>>>>>>
>>>>>> Changes from V7:
>>>>>> - drop {set|get}_mdev_features for virtio
>>>>>> - typo and comment style fixes
>>>>> Seems we're nearly there, all the remaining comments are relatively
>>>>> superficial, though I would appreciate a v9 addressing them as well a=
s
>>>>> the checkpatch warnings:
>>>>>
>>>>> https://patchwork.freedesktop.org/series/68977/
>>>>
>>>> Will do.
>>>>
>>>> Btw, do you plan to merge vhost-mdev patch on top? Or you prefer it to
>>>> go through Michael's vhost tree?
>>> I can include it if you wish.  The mdev changes are isolated enough in
>>> that patch that I wouldn't presume it, but clearly it would require
>>> less merge coordination to drop it in my tree.  Let me know.  Thanks,
>>>
>>> Alex
>> I'm fine with merging through your tree. If you do, feel free to
>> include
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> AFAICT, it looks like we're expecting at least one more version of
> Tiwei's patch after V5, so it'd probably be best to provide the ack and
> go-ahead on that next version so there's no confusion.  Thanks,
>
> Alex


Yes, it's probably need a V6. Will give ack there.

Thanks

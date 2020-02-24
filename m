Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26562 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726673AbgBXJ0l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 04:26:41 -0500
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
 <20200224024641-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
Date: Mon, 24 Feb 2020 17:26:20 +0800
MIME-Version: 1.0
In-Reply-To: <20200224024641-mutt-send-email-mst@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------BDFD2BED5C3364D3CE35012F"
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

This is a multi-part message in MIME format.
--------------BDFD2BED5C3364D3CE35012F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/2/24 =E4=B8=8B=E5=8D=883:48, Michael S. Tsirkin wrote:
> On Mon, Feb 24, 2020 at 02:45:03PM +0800, Jason Wang wrote:
>> On 2020/2/24 =E4=B8=8B=E5=8D=882:06, Michael S. Tsirkin wrote:
>>> On Mon, Feb 24, 2020 at 12:01:57PM +0800, Jason Wang wrote:
>>>> On 2020/2/21 =E4=B8=8B=E5=8D=8810:56, Halil Pasic wrote:
>>>>> On Fri, 21 Feb 2020 14:22:26 +0800
>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>>> On 2020/2/21 =E4=B8=8A=E5=8D=8812:06, Halil Pasic wrote:
>>>>>>> Currently if one intends to run a memory protection enabled VM wi=
th
>>>>>>> virtio devices and linux as the guest OS, one needs to specify th=
e
>>>>>>> VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the g=
uest
>>>>>>> linux use the DMA API, which in turn handles the memory
>>>>>>> encryption/protection stuff if the guest decides to turn itself i=
nto
>>>>>>> a protected one. This however makes no sense due to multiple reas=
ons:
>>>>>>> * The device is not changed by the fact that the guest RAM is
>>>>>>> protected. The so called IOMMU bypass quirk is not affected.
>>>>>>> * This usage is not congruent with  standardised semantics of
>>>>>>> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal =
reason
>>>>>>> for using DMA API in virtio (orthogonal with respect to what is
>>>>>>> expressed by VIRTIO_F_IOMMU_PLATFORM).
>>>>>>>
>>>>>>> This series aims to decouple 'have to use DMA API because my (gue=
st) RAM
>>>>>>> is protected' and 'have to use DMA API because the device told me
>>>>>>> VIRTIO_F_IOMMU_PLATFORM'.
>>>>>>>
>>>>>>> Please find more detailed explanations about the conceptual aspec=
ts in
>>>>>>> the individual patches. There is however also a very practical pr=
oblem
>>>>>>> that is addressed by this series.
>>>>>>>
>>>>>>> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the followi=
ng side
>>>>>>> effect The vhost code assumes it the addresses on the virtio desc=
riptor
>>>>>>> ring are not guest physical addresses but iova's, and insists on =
doing a
>>>>>>> translation of these regardless of what transport is used (e.g. w=
hether
>>>>>>> we emulate a PCI or a CCW device). (For details see commit 6b1e6c=
c7855b
>>>>>>> "vhost: new device IOTLB API".) On s390 this results in severe
>>>>>>> performance degradation (c.a. factor 10).
>>>>>> Do you see a consistent degradation on the performance, or it only
>>>>>> happen when for during the beginning of the test?
>>>>>>
>>>>> AFAIK the degradation is consistent.
>>>>>
>>>>>>> BTW with ccw I/O there is
>>>>>>> (architecturally) no IOMMU, so the whole address translation make=
s no
>>>>>>> sense in the context of virtio-ccw.
>>>>>> I suspect we can do optimization in qemu side.
>>>>>>
>>>>>> E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
>>>>>>
>>>>>> If this makes sense, I can draft patch to see if there's any diffe=
rence.
>>>>> Frankly I would prefer to avoid IOVAs on the descriptor ring (and t=
he
>>>>> then necessary translation) for virtio-ccw altogether. But Michael
>>>>> voiced his opinion that we should mandate F_IOMMU_PLATFORM for devi=
ces
>>>>> that could be used with guests running in protected mode. I don't s=
hare
>>>>> his opinion, but that's an ongoing discussion.
>>>>>
>>>>> Should we end up having to do translation from IOVA in vhost, we ar=
e
>>>>> very interested in that translation being fast and efficient.
>>>>>
>>>>> In that sense we would be very happy to test any optimization that =
aim
>>>>> into that direction.
>>>>>
>>>>> Thank you very much for your input!
>>>> Using IOTLB API on platform without IOMMU support is not intended. P=
lease
>>>> try the attached patch to see if it helps.
>>>>
>>>> Thanks
>>>>
>>>>
>>>>> Regards,
>>>>> Halil
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>>> Halil Pasic (2):
>>>>>>>       mm: move force_dma_unencrypted() to mem_encrypt.h
>>>>>>>       virtio: let virtio use DMA API when guest RAM is protected
>>>>>>>
>>>>>>>      drivers/virtio/virtio_ring.c |  3 +++
>>>>>>>      include/linux/dma-direct.h   |  9 ---------
>>>>>>>      include/linux/mem_encrypt.h  | 10 ++++++++++
>>>>>>>      3 files changed, 13 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>>
>>>>>>> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
>>>> >From 66fa730460875ac99e81d7db2334cd16bb1d2b27 Mon Sep 17 00:00:00 2=
001
>>>> From: Jason Wang <jasowang@redhat.com>
>>>> Date: Mon, 24 Feb 2020 12:00:10 +0800
>>>> Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly
>>>>
>>>> When transport does not support IOMMU, we should clear IOMMU_PLATFOR=
M
>>>> even if the device and vhost claims to support that. This help to
>>>> avoid the performance overhead caused by unnecessary IOTLB miss/upda=
te
>>>> transactions on such platform.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>    hw/virtio/virtio-bus.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>>>> index d6332d45c3..2741b9fdd2 100644
>>>> --- a/hw/virtio/virtio-bus.c
>>>> +++ b/hw/virtio/virtio-bus.c
>>>> @@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev,=
 Error **errp)
>>>>        VirtioBusState *bus =3D VIRTIO_BUS(qbus);
>>>>        VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
>>>>        VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>>>> -    bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU=
_PLATFORM);
>>>>        Error *local_err =3D NULL;
>>>>        DPRINTF("%s: plug device.\n", qbus->name);
>>>> @@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vde=
v, Error **errp)
>>>>            return;
>>>>        }
>>>> -    if (klass->get_dma_as !=3D NULL && has_iommu) {
>>>> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLA=
TFORM);
>>>> +    if (false && klass->get_dma_as !=3D NULL &&
>>>> +        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>>            vdev->dma_as =3D klass->get_dma_as(qbus->parent);
>>>>        } else {
>>>> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_P=
LATFORM);
>>>>            vdev->dma_as =3D &address_space_memory;
>>>>        }
>>>>    }
>>> This seems to clear it unconditionally. I guess it's just a debugging
>>> patch, the real one will come later?
>>
>> My bad, here's the correct one.
>>
>> Thanks
>>
>>
>>>> --=20
>>>> 2.19.1
>>>>
>> >From b8a8b582f46bb86c7a745b272db7b744779e5cc7 Mon Sep 17 00:00:00 200=
1
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Mon, 24 Feb 2020 12:00:10 +0800
>> Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly
>>
>> When transport does not support IOMMU, we should clear IOMMU_PLATFORM
>> even if the device and vhost claims to support that. This help to
>> avoid the performance overhead caused by unnecessary IOTLB miss/update
>> transactions on such platform.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/virtio/virtio-bus.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index d6332d45c3..4be64e193e 100644
>> --- a/hw/virtio/virtio-bus.c
>> +++ b/hw/virtio/virtio-bus.c
>> @@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, E=
rror **errp)
>>       VirtioBusState *bus =3D VIRTIO_BUS(qbus);
>>       VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
>>       VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>> -    bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_P=
LATFORM);
>>       Error *local_err =3D NULL;
>>  =20
>>       DPRINTF("%s: plug device.\n", qbus->name);
>> @@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vdev,=
 Error **errp)
>>           return;
>>       }
>>  =20
>> -    if (klass->get_dma_as !=3D NULL && has_iommu) {
>> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATF=
ORM);
> So it looks like this line is unnecessary, but it's an unrelated
> cleanup, right?


Yes.


>
>> +    if (klass->get_dma_as !=3D NULL &&
>> +        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>>           vdev->dma_as =3D klass->get_dma_as(qbus->parent);
>>       } else {
>> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLA=
TFORM);
>
> Of course any change like that will have to affect migration compat, et=
c.
> Can't we clear the bit when we are sending the features to vhost
> instead?


That's better.

How about attached?

Thanks


>
>
>>           vdev->dma_as =3D &address_space_memory;
>>       }
>>   }
>> --=20
>> 2.19.1
>>

--------------BDFD2BED5C3364D3CE35012F
Content-Type: text/x-patch;
 name="0001-vhost-do-not-set-VIRTIO_F_IOMMU_PLATFORM-when-IOMMU-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-vhost-do-not-set-VIRTIO_F_IOMMU_PLATFORM-when-IOMMU-.pa";
 filename*1="tch"

From 3177c5194c729f3056b84c67664c59b9b949bb76 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2020 17:24:14 +0800
Subject: [PATCH] vhost: do not set VIRTIO_F_IOMMU_PLATFORM when IOMMU is not
 used

We enable device IOTLB unconditionally when VIRTIO_F_IOMMU_PLATFORM is
negotiated. This lead unnecessary IOTLB miss/update transactions when
IOMMU is used. This patch fixes this.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 3 +++
 hw/virtio/vhost.c   | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3627bb1717..0d50e8bd34 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -879,6 +879,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         virtio_net_apply_guest_offloads(n);
     }
 
+    if (vdev->dma_as == &address_space_memory)
+        features &= ~(1ULL << VIRTIO_F_IOMMU_PLATFORM);
+
     for (i = 0;  i < n->max_queues; i++) {
         NetClientState *nc = qemu_get_subqueue(n->nic, i);
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9edfadc81d..711b1136f6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -288,9 +288,7 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 
 static int vhost_dev_has_iommu(struct vhost_dev *dev)
 {
-    VirtIODevice *vdev = dev->vdev;
-
-    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+    return virtio_has_feature(dev->acked_features, VIRTIO_F_IOMMU_PLATFORM);
 }
 
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
-- 
2.19.1


--------------BDFD2BED5C3364D3CE35012F--

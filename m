Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727210AbgBXECV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 23 Feb 2020 23:02:21 -0500
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
Date: Mon, 24 Feb 2020 12:01:57 +0800
MIME-Version: 1.0
In-Reply-To: <20200221155602.4de41fa7.pasic@linux.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------323EAFF568B452B8B5C3BA24"
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

This is a multi-part message in MIME format.
--------------323EAFF568B452B8B5C3BA24
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/2/21 =E4=B8=8B=E5=8D=8810:56, Halil Pasic wrote:
> On Fri, 21 Feb 2020 14:22:26 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2020/2/21 =E4=B8=8A=E5=8D=8812:06, Halil Pasic wrote:
>>> Currently if one intends to run a memory protection enabled VM with
>>> virtio devices and linux as the guest OS, one needs to specify the
>>> VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
>>> linux use the DMA API, which in turn handles the memory
>>> encryption/protection stuff if the guest decides to turn itself into
>>> a protected one. This however makes no sense due to multiple reasons:
>>> * The device is not changed by the fact that the guest RAM is
>>> protected. The so called IOMMU bypass quirk is not affected.
>>> * This usage is not congruent with  standardised semantics of
>>> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reas=
on
>>> for using DMA API in virtio (orthogonal with respect to what is
>>> expressed by VIRTIO_F_IOMMU_PLATFORM).
>>>
>>> This series aims to decouple 'have to use DMA API because my (guest) =
RAM
>>> is protected' and 'have to use DMA API because the device told me
>>> VIRTIO_F_IOMMU_PLATFORM'.
>>>
>>> Please find more detailed explanations about the conceptual aspects i=
n
>>> the individual patches. There is however also a very practical proble=
m
>>> that is addressed by this series.
>>>
>>> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following s=
ide
>>> effect The vhost code assumes it the addresses on the virtio descript=
or
>>> ring are not guest physical addresses but iova's, and insists on doin=
g a
>>> translation of these regardless of what transport is used (e.g. wheth=
er
>>> we emulate a PCI or a CCW device). (For details see commit 6b1e6cc785=
5b
>>> "vhost: new device IOTLB API".) On s390 this results in severe
>>> performance degradation (c.a. factor 10).
>>
>> Do you see a consistent degradation on the performance, or it only
>> happen when for during the beginning of the test?
>>
> AFAIK the degradation is consistent.
>
>>> BTW with ccw I/O there is
>>> (architecturally) no IOMMU, so the whole address translation makes no
>>> sense in the context of virtio-ccw.
>>
>> I suspect we can do optimization in qemu side.
>>
>> E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
>>
>> If this makes sense, I can draft patch to see if there's any differenc=
e.
> Frankly I would prefer to avoid IOVAs on the descriptor ring (and the
> then necessary translation) for virtio-ccw altogether. But Michael
> voiced his opinion that we should mandate F_IOMMU_PLATFORM for devices
> that could be used with guests running in protected mode. I don't share
> his opinion, but that's an ongoing discussion.
>
> Should we end up having to do translation from IOVA in vhost, we are
> very interested in that translation being fast and efficient.
>
> In that sense we would be very happy to test any optimization that aim
> into that direction.
>
> Thank you very much for your input!


Using IOTLB API on platform without IOMMU support is not intended.=20
Please try the attached patch to see if it helps.

Thanks


>
> Regards,
> Halil
>
>> Thanks
>>
>>
>>> Halil Pasic (2):
>>>     mm: move force_dma_unencrypted() to mem_encrypt.h
>>>     virtio: let virtio use DMA API when guest RAM is protected
>>>
>>>    drivers/virtio/virtio_ring.c |  3 +++
>>>    include/linux/dma-direct.h   |  9 ---------
>>>    include/linux/mem_encrypt.h  | 10 ++++++++++
>>>    3 files changed, 13 insertions(+), 9 deletions(-)
>>>
>>>
>>> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2

--------------323EAFF568B452B8B5C3BA24
Content-Type: text/x-patch;
 name="0001-virtio-turn-on-IOMMU_PLATFORM-properly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-virtio-turn-on-IOMMU_PLATFORM-properly.patch"

From 66fa730460875ac99e81d7db2334cd16bb1d2b27 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2020 12:00:10 +0800
Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly

When transport does not support IOMMU, we should clear IOMMU_PLATFORM
even if the device and vhost claims to support that. This help to
avoid the performance overhead caused by unnecessary IOTLB miss/update
transactions on such platform.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index d6332d45c3..2741b9fdd2 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     VirtioBusState *bus = VIRTIO_BUS(qbus);
     VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
     Error *local_err = NULL;
 
     DPRINTF("%s: plug device.\n", qbus->name);
@@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
         return;
     }
 
-    if (klass->get_dma_as != NULL && has_iommu) {
-        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
+    if (false && klass->get_dma_as != NULL &&
+        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
         vdev->dma_as = klass->get_dma_as(qbus->parent);
     } else {
+        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
         vdev->dma_as = &address_space_memory;
     }
 }
-- 
2.19.1


--------------323EAFF568B452B8B5C3BA24--

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42903 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727944AbgBUDmQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 22:42:16 -0500
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com> <20200220161309.GB12709@lst.de>
 <20200221025915.GB2298@umbus.fritz.box>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8194d502-07d8-b798-a2b5-606a8c05b895@redhat.com>
Date: Fri, 21 Feb 2020 11:41:57 +0800
MIME-Version: 1.0
In-Reply-To: <20200221025915.GB2298@umbus.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Gibson <david@gibson.dropbear.id.au>, Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


On 2020/2/21 =E4=B8=8A=E5=8D=8810:59, David Gibson wrote:
> On Thu, Feb 20, 2020 at 05:13:09PM +0100, Christoph Hellwig wrote:
>> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
>>> index 867c7ebd3f10..fafc8f924955 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_devic=
e *vdev)
>>>   	if (!virtio_has_iommu_quirk(vdev))
>>>   		return true;
>>>  =20
>>> +	if (force_dma_unencrypted(&vdev->dev))
>>> +		return true;
>> Hell no.  This is a detail of the platform DMA direct implementation.
>> Drivers have no business looking at this flag, and virtio finally need=
s
>> to be fixed to use the DMA API properly for everything but legacy devi=
ces.
> So, this patch definitely isn't right as it stands, but I'm struggling
> to understand what it is you're saying is the right way.
>
> By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
> lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
> see how being a legacy device or not relates to use of the DMA API.
>
> I *think* what you are suggesting here is that virtio devices that
> have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
> DMA API treats IOVA=3D=3DPA, which will satisfy what the device expects=
.


Can this work for swiotlb?

Thanks


> Then the virtio driver can use the DMA API the same way for both
> F_IOMMU_PLATFORM and !F_IOMMU_PLATFORM devices.
>
> But if that works for !F_IOMMU_PLATFORM_DEVICES+F_VERSION_1 devices,
> then AFAICT it will work equally well for legacy devices.
>
> Using the DMA API for *everything* in virtio, legacy or not, seems
> like a reasonable approach to me.  But, AFAICT, that does require the
> DMA layer to have some kind of explicit call to turn on this
> behaviour, which the virtio driver would call during initializsation.
> I don't think we can do it 100% within the DMA layer, because only the
> driver can reasonably know when a device has this weird non-standard
> DMA behaviour.
>

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:15041
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbgBUPjq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 10:39:46 -0500
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
 <20200221141230.13eebc35.pasic@linux.ibm.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <bf0c87a2-adc6-a05a-835f-f98e7cd0cd3b@amd.com>
Date: Fri, 21 Feb 2020 09:39:38 -0600
In-Reply-To: <20200221141230.13eebc35.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Michael Mueller <mimu@linux.ibm.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "Huang, Wei" <wei.huang2@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

On 2/21/20 7:12 AM, Halil Pasic wrote:
> On Thu, 20 Feb 2020 15:55:14 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
>>> Currently the advanced guest memory protection technologies (AMD SEV,
>>> powerpc secure guest technology and s390 Protected VMs) abuse the
>>> VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
>>> is in turn necessary, to make IO work with guest memory protection.
>>>
>>> But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
>>> different beast: with virtio devices whose implementation runs on an SMP
>>> CPU we are still fine with doing all the usual optimizations, it is just
>>> that we need to make sure that the memory protection mechanism does not
>>> get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
>>> side of the guest (and possibly he host side as well) than we actually
>>> need.
>>>
>>> An additional benefit of teaching the guest to make the right decision
>>> (and use DMA API) on it's own is: removing the need, to mandate special
>>> VM configuration for guests that may run with protection. This is
>>> especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
>>> the virtio control structures into the first 2G of guest memory:
>>> something we don't necessarily want to do per-default.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Ram Pai <linuxram@us.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>
>> This might work for you but it's fragile, since without
>> VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
>> GPA's, not DMA addresses.
>>
> 
> Thanks for your constructive approach. I do want the hypervisor to
> assume it gets GPA's. My train of thought was that the guys that need
> to use IOVA's that are not GPA's when force_dma_unencrypted() will have
> to to specify VIRTIO_F_ACCESS_PLATFORM (at the device) anyway, because
> otherwise it won't work. But I see your point: in case of a
> mis-configuration and provided the DMA API returns IOVA's one could end
> up trying to touch wrong memory locations. But this should be similar to
> what would happen if DMA ops are not used, and memory is not made accessible.
> 
>>
>>
>> IOW this looks like another iteration of:
>>
>> 	virtio: Support encrypted memory on powerpc secure guests
>>
>> which I was under the impression was abandoned as unnecessary.
> 
> Unnecessary for powerpc because they do normal PCI. In the context of
> CCW there are only guest physical addresses (CCW I/O has no concept of
> IOMMU or IOVAs).
> 
>>
>>
>> To summarize, the necessary conditions for a hack along these lines
>> (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
>>
>>   - secure guest mode is enabled - so we know that since we don't share
>>     most memory regular virtio code won't
>>     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
> 
> force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.
> 
>>   - DMA API is giving us addresses that are actually also physical
>>     addresses
> 
> In case of s390 this is given. I talked with the power people before
> posting this, and they ensured me they can are willing to deal with
> this. I was hoping to talk abut this with the AMD SEV people here (hence
> the cc).

Yes, physical addresses are fine for SEV - the key is that the DMA API is
used so that an address for unencrypted, or shared, memory is returned.
E.g. for a dma_alloc_coherent() call this is an allocation that has had
set_memory_decrypted() called or for a dma_map_page() call this is an
address from SWIOTLB, which was mapped shared during boot, where the data
will be bounce-buffered.

We don't currently support an emulated IOMMU in our SEV guest because that
would require a lot of support in the driver to make IOMMU data available
to the hypervisor (I/O page tables, etc.). We would need hardware support
to really make this work easily in the guest.

Thanks,
Tom

> 
>>   - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
>>
> 
> I don't get this point. The argument where the hypervisor is buggy is a
> bit hard to follow for me. If hypervisor is buggy we have already lost
> anyway most of the time, or?
>  
>> I don't see how this patch does this.
> 
> I do get your point. I don't know of a good way to check that DMA API
> is giving us addresses that are actually physical addresses, and the
> situation you describe definitely has some risk to it.
> 
> Let me comment on other ideas that came up. I would be very happy to go
> with the best one. Thank you very much.
> 
> Regards,
> Halil
> 
>>
>>
>>> ---
>>>  drivers/virtio/virtio_ring.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index 867c7ebd3f10..fafc8f924955 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>>>  	if (!virtio_has_iommu_quirk(vdev))
>>>  		return true;
>>>  
>>> +	if (force_dma_unencrypted(&vdev->dev))
>>> +		return true;
>>> +
>>>  	/* Otherwise, we are left to guess. */
>>>  	/*
>>>  	 * In theory, it's possible to have a buggy QEMU-supposed
>>> -- 
>>> 2.17.1
>>
> 

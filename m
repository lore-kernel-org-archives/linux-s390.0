Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B27C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 15:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbiETPvZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351201AbiETPvX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 11:51:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 821CD5B3F4
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 08:51:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35C421477;
        Fri, 20 May 2022 08:51:21 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 942EF3F73D;
        Fri, 20 May 2022 08:51:17 -0700 (PDT)
Message-ID: <db3ebceb-6a1b-1986-c774-45b425923467@arm.com>
Date:   Fri, 20 May 2022 16:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: s390-iommu.c default domain conversion
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com
References: <20220509233552.GT49344@nvidia.com>
 <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
 <20220510160911.GH49344@nvidia.com>
 <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
 <20220520134414.GH1343366@nvidia.com>
 <6271dd24bfcf82b0c1b911a163ae9549c24691a4.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <6271dd24bfcf82b0c1b911a163ae9549c24691a4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2022-05-20 16:17, Niklas Schnelle wrote:
> On Fri, 2022-05-20 at 10:44 -0300, Jason Gunthorpe wrote:
>> On Fri, May 20, 2022 at 03:05:46PM +0200, Niklas Schnelle wrote:
>>
>>> I did some testing and created a prototype that gets rid of
>>> arch/s390/pci_dma.c and works soley via dma-iommu on top of our IOMMU
>>> driver. It looks like the existing dma-iommu code allows us to do this
>>> with relatively simple changes to the IOMMU driver only, mostly just
>>> implementing iotlb_sync(), iotlb_sync_map() and flush_iotlb_all() so
>>> that's great. They also do seem to map quite well to our RPCIT I/O TLB
>>> flush so that's great. For now the prototype still uses 4k pages only.
>>
>> You are going to want to improve that page sizes in the iommu driver
>> anyhow for VFIO.
> 
> Ok, we'll look into this.
> 
>>   
>>> With that the performance on the LPAR machine hypervisor (no paging) is
>>> on par with our existing code. On paging hypervisors (z/VM and KVM)
>>> i.e. with the hypervisor shadowing the I/O translation tables, it's
>>> still slower than our existing code and interestingly strict mode seems
>>> to be better than lazy here. One thing I haven't done yet is implement
>>> the map_pages() operation or adding larger page sizes.
>>
>> map_pages() speeds thiings up if there is contiguous memory, I'm not
>> sure what work load you are testing with so hard to guess if that is
>> interesting or not.
> 
> Our most important driver is mlx5 with both IP and RDMA traffic on
> ConnectX-4/5/6 but we also support NVMes.

Since you already have the loop in s390_iommu_update_trans(), updating 
to map/unmap_pages should be trivial, and well worth it.

>>> Maybe you have some tips what you'd expect to be most beneficial?
>>> Either way we're optimistic this can be solved and this conversion
>>> will be a high ranking item on my backlog going forward.
>>
>> I'm not really sure I understand the differences, do you have a sense
>> what is making it slower? Maybe there is some small feature that can
>> be added to the core code? It is very strange that strict is faster,
>> that should not be, strict requires synchronous flush in the unmap
>> cas, lazy does not. Are you sure you are getting the lazy flushes
>> enabled?
> 
> The lazy flushes are the timer triggered flush_iotlb_all() in
> fq_flush_iotlb(), right? I definitely see that when tracing my
> flush_iotlb_all() implementation via that path. That flush_iotlb_all()
> in my prototype is basically the same as the global RPCIT we did once
> we wrapped around our IOVA address space. I suspect that this just
> happens much more often with the timer than our wrap around and
> flushing the entire aperture is somewhat slow because it causes the
> hypervisor to re-examine the entire I/O translation table. On the other
> hand in strict mode the iommu_iotlb_sync() call in __iommu_unmap()
> always flushes a relatively small contiguous range as I'm using the
> following construct to extend gather:
> 
> 	if (iommu_iotlb_gather_is_disjoint(gather, iova, size))
> 		iommu_iotlb_sync(domain, gather);
> 
> 	iommu_iotlb_gather_add_range(gather, iova, size);
> 
> Maybe the smaller contiguous ranges just help with locality/caching
> because the flushed range in the guests I/O tables was just updated.

That's entirely believable - both the AMD and Intel drivers force strict 
mode when virtualised for similar reasons, so feel free to do the same.

Robin.

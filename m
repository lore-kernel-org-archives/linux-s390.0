Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727895AbgLHIj7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 03:39:59 -0500
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
 <20201202203233.GB11274@osiris>
 <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com> <20201203115133.GB9994@osiris>
 <4d6c9ec4-f1be-46b9-5d67-5c53f5afedc5@redhat.com>
 <62c60c9e-20d6-25bd-94d0-78bfed0f2476@arm.com>
 <02dfe6f5-efb6-c04d-c34a-a1e7393625cf@redhat.com>
 <9e80ad53-d203-d7d2-3fc8-92fa860bc869@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ec49e677-7992-40d5-ea5b-709e311d76fe@redhat.com>
Date: Tue, 8 Dec 2020 09:38:13 +0100
MIME-Version: 1.0
In-Reply-To: <9e80ad53-d203-d7d2-3fc8-92fa860bc869@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>

>>
>> Both changes only make sense with an in-tree user. I'm planning on using
>> this functionality in virtio-mem code. I can pickup your patches, drop
>> the superfluous checks, and use it from virtio-mem code. Makese sense
>> (BTW, looks like we'll see aarch64 support for virtio-mem soon)?
> 
> I have not been following virtio-mem closely. But is there something pending
> on arm64 platform which prevents virtio-mem enablement ?

Regarding enablement, I expect things to be working out of the box
mostly. Jonathan is currently doing some testing and wants to send a
simple unlock patch once done. [1]


Now, there are some things to improve in the future. virtio-mem
adds/removes individual Linux memory blocks and logically plugs/unplugs
MAX_ORDER - 1/pageblock_order pages inside Linux memory blocks.

1. memblock

On arm64 and powerpc, we create/delete memblocks when adding/removing
memory, which is suboptimal (and the code is quite fragile as we don't
handle errors ...). Hotplugged memory never has holes, so we can tweak
relevant code to not check via the memblock api.

For example, pfn_valid() only has to check for memblock_is_map_memory()
in case of !early_section() - otherwise it can just fallback to our
generic pfn_valid() function.

2. MAX_ORDER - 1 / pageblock_order

With 64k base pages, virtio-mem can only logically plug/unplug in 512MB
granularity, which is sub-optimal and inflexible. 4/2MB would be much
better - however this would require always using 2MB THP on arm64 (IIRC
via "cont" bits). Luckily, only some distributions use 64k base pages as
default nowadays ... :)

3. Section size

virtio-mem benefits from small section sizes. Currently, we have 1G.
With 4k base pages we could easily reduce it to something what x86 has
(128 MB) - and I remember discussions regarding that already in other
(IIRC NVDIMM / DIMM) context. Again, with 64k base pages we cannot go
below 512 MB right now.

[1] https://lkml.kernel.org/r/20201125145659.00004b3e@Huawei.com

-- 
Thanks,

David / dhildenb

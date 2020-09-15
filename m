Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbgIOHfo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 03:35:44 -0400
Subject: Re: [PATCH v2 1/7] kernel/resource: make
 release_mem_region_adjustable() never fail
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-2-david@redhat.com>
 <20200915021012.GC2007@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <927904b1-1909-f11f-483e-8012bda8ad0c@redhat.com>
Date: Tue, 15 Sep 2020 09:35:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200915021012.GC2007@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>


>> static int __ref try_remove_memory(int nid, u64 start, u64 size)
>> {
>> 	int rc = 0;
>> @@ -1777,7 +1757,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>> 		memblock_remove(start, size);
>> 	}
>>
>> -	__release_memory_resource(start, size);
>> +	release_mem_region_adjustable(&iomem_resource, start, size);
>>
> 
> Seems the only user of release_mem_region_adjustable() is here, can we move
> iomem_resource into the function body? Actually, we don't iterate the resource
> tree from any level. We always start from the root.

You mean, making iomem_resource implicit? I can spot that something
similar was done for

#define devm_release_mem_region(dev, start, n) \
	__devm_release_region(dev, &iomem_resource, (start), (n))

I'll send an addon patch for that, ok? - thanks.

-- 
Thanks,

David / dhildenb

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbgD3P2q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:28:46 -0400
Subject: Re: [PATCH v2 3/3] device-dax: Add system ram (add_memory()) with
 MHP_NO_FIRMWARE_MEMMAP
References: <20200430102908.10107-1-david@redhat.com>
 <20200430102908.10107-4-david@redhat.com>
 <20b86ced-7c47-02ca-0e0e-1bd5d6cc95c1@intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0e30697f-a5f7-e272-6aa5-8c7197c15818@redhat.com>
Date: Thu, 30 Apr 2020 17:28:29 +0200
MIME-Version: 1.0
In-Reply-To: <20b86ced-7c47-02ca-0e0e-1bd5d6cc95c1@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

On 30.04.20 13:23, Dave Hansen wrote:
> On 4/30/20 3:29 AM, David Hildenbrand wrote:
>> Currently, when adding memory, we create entries in /sys/firmware/memmap/
>> as "System RAM". This does not reflect the reality and will lead to
>> kexec-tools to add that memory to the fixed-up initial memmap for a
>> kexec kernel (loaded via kexec_load()). The memory will be considered
>> initial System RAM by the kexec kernel.
>>
>> We should let the kexec kernel decide how to use that memory - just as
>> we do during an ordinary reboot.
> ...
>> -	rc = add_memory(numa_node, new_res->start, resource_size(new_res), 0);
>> +	rc = add_memory(numa_node, new_res->start, resource_size(new_res),
>> +			MHP_NO_FIRMWARE_MEMMAP);
> 
> Looks fine.  But, if you send another revision, could you add a comment
> about the actual goal of MHP_NO_FIRMWARE_MEMMAP?  Maybe:
> 
> 	/*
> 	 * MHP_NO_FIRMWARE_MEMMAP ensures that future
> 	 * kexec'd kernels will not treat this as RAM.
> 	 */
> 
> Not a biggie, though.

Sure, maybe Andrew can fixup when applying (if no resend is necessary).

Thanks Dave!

> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 


-- 
Thanks,

David / dhildenb

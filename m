Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgIOHZm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 03:25:42 -0400
Subject: Re: [PATCH v4 5/8] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify
 merging of System RAM resources
References: <20200911103459.10306-1-david@redhat.com>
 <20200911103459.10306-6-david@redhat.com>
 <20200915024348.GA2685@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e807e983-b10a-a731-4eaa-da208fabda84@redhat.com>
Date: Tue, 15 Sep 2020 09:25:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200915024348.GA2685@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>

On 15.09.20 04:43, Wei Yang wrote:
> On Fri, Sep 11, 2020 at 12:34:56PM +0200, David Hildenbrand wrote:
>> Some add_memory*() users add memory in small, contiguous memory blocks.
>> Examples include virtio-mem, hyper-v balloon, and the XEN balloon.
>>
>> This can quickly result in a lot of memory resources, whereby the actual
>> resource boundaries are not of interest (e.g., it might be relevant for
>> DIMMs, exposed via /proc/iomem to user space). We really want to merge
>> added resources in this scenario where possible.
>>
>> Let's provide a flag (MEMHP_MERGE_RESOURCE) to specify that a resource
>> either created within add_memory*() or passed via add_memory_resource()
>> shall be marked mergeable and merged with applicable siblings.
>>
>> To implement that, we need a kernel/resource interface to mark selected
>> System RAM resources mergeable (IORESOURCE_SYSRAM_MERGEABLE) and trigger
>> merging.
>>
>> Note: We really want to merge after the whole operation succeeded, not
>> directly when adding a resource to the resource tree (it would break
>> add_memory_resource() and require splitting resources again when the
>> operation failed - e.g., due to -ENOMEM).
> 
> Oops, the latest version is here.

Yeah, sorry, I dropped the "mm" prefix on the subject of the cover
letter by mistake.

> 
> BTW, I don't see patch 4. Not sure it is junked by my mail system?

At least you're in the CC list below with your old mail address (I
assume you monitor that).

I'll try to use your new address in the future.


-- 
Thanks,

David / dhildenb

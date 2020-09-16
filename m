Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727396AbgIPRqT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 13:46:19 -0400
Subject: Re: [PATCH] kernel/resource: make iomem_resource implicit in
 release_mem_region_adjustable()
References: <20200911103459.10306-1-david@redhat.com>
 <20200916073041.10355-1-david@redhat.com>
 <20200916100223.GA46154@L-31X9LVDL-1304.local>
 <d11eba75-71c0-4153-944b-56e22044e0eb@redhat.com>
 <20200916121051.GA46809@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0ee45d30-daa4-190a-2932-fb710d9496db@redhat.com>
Date: Wed, 16 Sep 2020 14:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200916121051.GA46809@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>

On 16.09.20 14:10, Wei Yang wrote:
> On Wed, Sep 16, 2020 at 12:03:20PM +0200, David Hildenbrand wrote:
>> On 16.09.20 12:02, Wei Yang wrote:
>>> On Wed, Sep 16, 2020 at 09:30:41AM +0200, David Hildenbrand wrote:
>>>> "mem" in the name already indicates the root, similar to
>>>> release_mem_region() and devm_request_mem_region(). Make it implicit.
>>>> The only single caller always passes iomem_resource, other parents are
>>>> not applicable.
>>>>
>>>
>>> Looks good to me.
>>>
>>> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>
>>
>> Thanks for the review!
>>
> 
> Would you send another version? I didn't take a look into the following
> patches, since the 4th is missed.

Not planning to send another one as long as there are no further
comments. Seems to be an issue on your side because all patches arrived
on linux-mm (see
https://lore.kernel.org/linux-mm/20200911103459.10306-1-david@redhat.com/)

You can find patch #4 at
https://lore.kernel.org/linux-mm/20200911103459.10306-5-david@redhat.com/

(which has CC "Wei Yang <richardw.yang@linux.intel.com>")

-- 
Thanks,

David / dhildenb

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726764AbgIPKDa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 06:03:30 -0400
Subject: Re: [PATCH] kernel/resource: make iomem_resource implicit in
 release_mem_region_adjustable()
References: <20200911103459.10306-1-david@redhat.com>
 <20200916073041.10355-1-david@redhat.com>
 <20200916100223.GA46154@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d11eba75-71c0-4153-944b-56e22044e0eb@redhat.com>
Date: Wed, 16 Sep 2020 12:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200916100223.GA46154@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>

On 16.09.20 12:02, Wei Yang wrote:
> On Wed, Sep 16, 2020 at 09:30:41AM +0200, David Hildenbrand wrote:
>> "mem" in the name already indicates the root, similar to
>> release_mem_region() and devm_request_mem_region(). Make it implicit.
>> The only single caller always passes iomem_resource, other parents are
>> not applicable.
>>
> 
> Looks good to me.
> 
> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>

Thanks for the review!

-- 
Thanks,

David / dhildenb

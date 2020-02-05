Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40657 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbgBEI7x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 03:59:53 -0500
Subject: Re: [PATCH v6 07/10] mm/memory_hotplug: We always have a zone in
 find_(smallest|biggest)_section_pfn
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-8-david@redhat.com> <20200205085709.GA24162@richard>
From: David Hildenbrand <david@redhat.com>
Message-ID: <80d3baea-2076-ed07-1216-27d8aa8c8734@redhat.com>
Date: Wed, 5 Feb 2020 09:59:41 +0100
MIME-Version: 1.0
In-Reply-To: <20200205085709.GA24162@richard>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

On 05.02.20 09:57, Wei Yang wrote:
> On Sun, Oct 06, 2019 at 10:56:43AM +0200, David Hildenbrand wrote:
>> With shrink_pgdat_span() out of the way, we now always have a valid
>> zone.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

Just FYI, the patches are now upstream, so the rb's can no longer be
applied. (but we can send fixes if we find that something is broken ;)
). Thanks!

-- 
Thanks,

David / dhildenb

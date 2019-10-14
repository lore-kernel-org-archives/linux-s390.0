Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbfJNJbS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 05:31:18 -0400
Subject: Re: [PATCH v6 03/10] mm/memory_hotplug: Don't access uninitialized
 memmaps in shrink_pgdat_span()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-4-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3d8be627-bfd6-1336-689d-345a2ed67118@redhat.com>
Date: Mon, 14 Oct 2019 11:31:14 +0200
MIME-Version: 1.0
In-Reply-To: <20191006085646.5768-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>

On 06.10.19 10:56, David Hildenbrand wrote:
> We might use the nid of memmaps that were never initialized. For
> example, if the memmap was poisoned, we will crash the kernel in
> pfn_to_nid() right now. Let's use the calculated boundaries of the separate
> zones instead. This now also avoids having to iterate over a whole bunch of
> subsections again, after shrinking one zone.
> 
> Before commit d0dc12e86b31 ("mm/memory_hotplug: optimize memory
> hotplug"), the memmap was initialized to 0 and the node was set to the
> right value. After that commit, the node might be garbage.
> 
> We'll have to fix shrink_zone_span() next.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")

@Andrew, can you convert that to

Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319

and add

Cc: stable@vger.kernel.org # v4.13+

-- 

Thanks,

David / dhildenb

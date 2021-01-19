Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <691872bb-b251-83e0-126e-afd54683c83e@redhat.com>
Date: Tue, 19 Jan 2021 13:21:53 +0100
MIME-Version: 1.0
In-Reply-To: <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 18.01.21 14:12, Anshuman Khandual wrote:
> This introduces memhp_range_allowed() which can be called in various memory
> hotplug paths to prevalidate the address range which is being added, with
> the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
> which provides applicable address range depending on whether linear mapping
> is required or not. For ranges that require linear mapping, it calls a new
> arch callback arch_get_mappable_range() which the platform can override. So
> the new callback, in turn provides the platform an opportunity to configure
> acceptable memory hotplug address ranges in case there are constraints.
> 
> This mechanism will help prevent platform specific errors deep down during
> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
> check in __add_pages() but instead adds a VM_BUG_ON() check which would

In this patch, you keep the __add_pages() checks. But as discussed, we
could perform it in mm/memremap.c:pagemap_range() insted and convert it
to a VM_BUG_ON().

Apart from that looks good to me.

-- 
Thanks,

David / dhildenb

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbhAYJXg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Jan 2021 04:23:36 -0500
Subject: Re: [PATCH V4 1/4] mm/memory_hotplug: Prevalidate the address range
 being added with platform
References: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
 <1611543532-18698-2-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a07711a8-f24b-be8d-8570-6447e66768d9@redhat.com>
Date: Mon, 25 Jan 2021 10:21:41 +0100
MIME-Version: 1.0
In-Reply-To: <1611543532-18698-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 25.01.21 03:58, Anshuman Khandual wrote:
> This introduces mhp_range_allowed() which can be called in various memory
> hotplug paths to prevalidate the address range which is being added, with
> the platform. Then mhp_range_allowed() calls mhp_get_pluggable_range()
> which provides applicable address range depending on whether linear mapping
> is required or not. For ranges that require linear mapping, it calls a new
> arch callback arch_get_mappable_range() which the platform can override. So
> the new callback, in turn provides the platform an opportunity to configure
> acceptable memory hotplug address ranges in case there are constraints.
> 
> This mechanism will help prevent platform specific errors deep down during
> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
> check in __add_pages() but instead adds a VM_BUG_ON() check which would
> ensure that the range has been validated with mhp_range_allowed() earlier
> in the call chain. Besides mhp_get_pluggable_range() also can be used by
> potential memory hotplug callers to avail the allowed physical range which
> would go through on a given platform.
> 
> This does not really add any new range check in generic memory hotplug but
> instead compensates for lost checks in arch_add_memory() where applicable
> and check_hotplug_memory_addressable(), with unified mhp_range_allowed().
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

[...]

> +
> +struct range mhp_get_pluggable_range(bool need_mapping)
> +{
> +	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
> +	struct range mhp_range;
> +
> +	if (need_mapping) {
> +		mhp_range = arch_get_mappable_range();
> +		if (mhp_range.start > max_phys) {
> +			mhp_range.start = 0;
> +			mhp_range.end = 0;
> +		}
> +		mhp_range.end = min_t(u64, mhp_range.end, max_phys);
> +	} else {
> +		mhp_range.start = 0;
> +		mhp_range.end = max_phys;
> +	}
> +	return mhp_range;
> +}
> +EXPORT_SYMBOL_GPL(mhp_get_pluggable_range);


Some people might prefer the EXPORT_SYMBOL_GPL() going to the actual
user (patch #4), I don't care :) Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

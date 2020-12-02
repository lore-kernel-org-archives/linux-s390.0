Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgLBGo6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Dec 2020 01:44:58 -0500
Subject: Re: [RFC V2 0/3] mm/hotplug: Pre-validate the address range with
 platform
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7ffb5199-1b39-3f35-32cd-b59f71cc00c5@arm.com>
Date: Wed, 2 Dec 2020 12:14:04 +0530
MIME-Version: 1.0
In-Reply-To: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc: linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>



On 11/30/20 8:59 AM, Anshuman Khandual wrote:
> This series adds a mechanism allowing platforms to weigh in and prevalidate
> incoming address range before proceeding further with the memory hotplug.
> This helps prevent potential platform errors for the given address range,
> down the hotplug call chain, which inevitably fails the hotplug itself.
> 
> This mechanism was suggested by David Hildenbrand during another discussion
> with respect to a memory hotplug fix on arm64 platform.
> 
> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> This mechanism focuses on the addressibility aspect and not [sub] section
> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
> have been left unchanged. Wondering if all these can still be unified in
> an expanded memhp_range_allowed() check, that can be called from multiple
> memory hot add and remove paths.
> 
> This series applies on v5.10-rc6 and has been slightly tested on arm64.
> But looking for some early feedback here.
> 
> Changes in RFC V2:
> 
> Incorporated all review feedbacks from David.
> 
> - Added additional range check in __segment_load() on s390 which was lost
> - Changed is_private init in pagemap_range()
> - Moved the framework into mm/memory_hotplug.c
> - Made arch_get_addressable_range() a __weak function
> - Renamed arch_get_addressable_range() as arch_get_mappable_range()
> - Callback arch_get_mappable_range() only handles range requiring linear mapping
> - Merged multiple memhp_range_allowed() checks in register_memory_resource()
> - Replaced WARN() with pr_warn() in memhp_range_allowed()
> - Replaced error return code ERANGE with E2BIG

There is one build failure with MEMORY_HOTPLUG=y and MEMORY_HOTREMOVE=n.
There are warnings on arm64 and s390 platforms when built with W=1 due
to lack of prototypes required with -Wmissing-prototypes. I have fixed
all these problems for the next iteration when there is broad agreement
on the overall approach.

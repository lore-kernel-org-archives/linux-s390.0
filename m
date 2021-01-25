Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbhAYKYN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Jan 2021 05:24:13 -0500
Subject: Re: [PATCH V4 0/4] mm/memory_hotplug: Pre-validate the address range
 with platform
References: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
 <c60ecbed-9073-83f9-e9e2-1f79a80cfe44@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8260d6fe-7df5-c667-2514-0d94cf87d31c@arm.com>
Date: Mon, 25 Jan 2021 15:22:08 +0530
MIME-Version: 1.0
In-Reply-To: <c60ecbed-9073-83f9-e9e2-1f79a80cfe44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 1/25/21 2:55 PM, David Hildenbrand wrote:
> On 25.01.21 03:58, Anshuman Khandual wrote:
>> This series adds a mechanism allowing platforms to weigh in and prevalidate
>> incoming address range before proceeding further with the memory hotplug.
>> This helps prevent potential platform errors for the given address range,
>> down the hotplug call chain, which inevitably fails the hotplug itself.
>>
>> This mechanism was suggested by David Hildenbrand during another discussion
>> with respect to a memory hotplug fix on arm64 platform.
>>
>> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
>>
>> This mechanism focuses on the addressibility aspect and not [sub] section
>> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
>> have been left unchanged. Wondering if all these can still be unified in
>> an expanded memhp_range_allowed() check, that can be called from multiple
>> memory hot add and remove paths.
>>
>> This series applies on v5.11-rc5 and has been tested on arm64. But only
>> build tested on s390.
>>
> 
> Note that this fails to apply right now to both, -next and Linus' tree.
> Do you have a branch with he patches on top I can use for a quick test?
> Thanks
> 

Applied all four patches on v5.11-rc5.

https://gitlab.arm.com/linux-arm/linux-anshuman/-/tree/mm/hotplug_callback/v4/

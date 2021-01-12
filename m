Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:39640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbhALDvs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Jan 2021 22:51:48 -0500
Subject: Re: [PATCH V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <1608218912-28932-2-git-send-email-anshuman.khandual@arm.com>
 <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
 <20210111134303.GA3031@linux>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e2b53f0a-482d-2045-6162-6de2510c9690@arm.com>
Date: Tue, 12 Jan 2021 09:21:18 +0530
MIME-Version: 1.0
In-Reply-To: <20210111134303.GA3031@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>



On 1/11/21 7:13 PM, Oscar Salvador wrote:
> On Mon, Jan 11, 2021 at 11:51:47AM +0100, David Hildenbrand wrote:
>> AFAIKs, all memhp_get_pluggable_range() users pass "1".
>>
>> What about the "add_pages()-only" path?
> 
> I guess you refer to memremap_pages(), right?

Right, via pagemap_range().

> If so, moving the added memhp_range_allowed() check above the if-else might do
> the trick
> 
We had that code in the earlier version. But dropped it, as we did
not want to add any new checks in the generic code. Can add it back
if that is preferred.

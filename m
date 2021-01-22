Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726997AbhAVIg0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 03:36:26 -0500
Subject: Re: [PATCH V3 0/3] mm/memory_hotplug: Pre-validate the address range
 with platform
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <d57036a1-de12-2d32-be65-daaa3dc5b772@redhat.com>
 <20210119134016.GA23408@linux> <8df4e1e1-1ddd-398e-c9a6-17a67d8a95bc@arm.com>
 <1c8c204d-1f96-d3aa-1b7b-ec4cc7b1b79b@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com>
Date: Fri, 22 Jan 2021 09:34:50 +0100
MIME-Version: 1.0
In-Reply-To: <1c8c204d-1f96-d3aa-1b7b-ec4cc7b1b79b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 22.01.21 07:04, Anshuman Khandual wrote:
> 
> On 1/20/21 2:07 PM, Anshuman Khandual wrote:
>>
>>
>> On 1/19/21 7:10 PM, Oscar Salvador wrote:
>>> On Tue, Jan 19, 2021 at 02:33:03PM +0100, David Hildenbrand wrote:
>>>> Minor thing, we should make up our mind if we want to call stuff
>>>> internally "memhp_" or "mhp". I prefer the latter, because it is shorter.
>>>
>>> I would rather use the latter as well. I used that in [1].
>>
>> Okay, will change all that is 'memhp' as 'mhp' instead.
>>
>>> MEMHP_MERGE_RESOURCE should be renamed if we agree on that.
>>>
>>> [1] https://patchwork.kernel.org/project/linux-mm/cover/20201217130758.11565-1-osalvador@suse.de/
>>>
> 
> While replacing 'memhp' as 'mhp' in this series, noticed there are
> some more 'memhp' scattered around the code from earlier. A mix of
> both 'memhp' and 'mhp' might not be a good idea. Hence should we
> just change these remaining 'memhp' as 'mhp' as well and possibly
> also MEMHP_MERGE_RESOURCE as suggested earlier, in a subsequent

As mentioned in another thread to Oscar, I already have a cleanup patch
for that one lying around, part of a bigger series. Might just send that
one out separately earlier.

> clean up patch ? Would there be a problem with memhp_default_state
> being a command line parameter ?

Yes, that one we should not change, to not break existing cmdlines
without good reason. We could change the
memhp_default_online_type/memhp_online_type_from_str/... thingies, though.

Feel free to send a patch, thanks!

-- 
Thanks,

David / dhildenb

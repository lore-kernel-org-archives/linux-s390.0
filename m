Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbfGOK63 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 06:58:29 -0400
Subject: Re: [PATCH v3 09/11] mm/memory_hotplug: Remove memory block devices
 before arch_remove_memory()
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-10-david@redhat.com>
 <20190701084129.GI6376@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <54a2f873-374e-b132-ae0f-4924a7e332c0@redhat.com>
Date: Mon, 15 Jul 2019 12:58:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190701084129.GI6376@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Andrew Banman <andrew.banman@hpe.com>, Ingo Molnar <mingo@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Oscar Salvador <osalvador@suse.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Arun KS <arunks@codeaurora.org>, Mathieu Malaterre <malat@debian.org>

On 01.07.19 10:41, Michal Hocko wrote:
> On Mon 27-05-19 13:11:50, David Hildenbrand wrote:
>> Let's factor out removing of memory block devices, which is only
>> necessary for memory added via add_memory() and friends that created
>> memory block devices. Remove the devices before calling
>> arch_remove_memory().
>>
>> This finishes factoring out memory block device handling from
>> arch_add_memory() and arch_remove_memory().
> 
> OK, this makes sense again. Just a nit. Calling find_memory_block_by_id
> for each memory block looks a bit suboptimal, especially when we are
> removing consequent physical memblocks. I have to confess that I do not
> know how expensive is the search and I also expect that there won't be
> that many memblocks in the removed range anyway as large setups have
> large memblocks.
> 

The devices are not allocated sequentially, so there is no easy way to
look them up.

There is a comment for find_memory_block():

"For now, we have a linear search to go find the appropriate
memory_block corresponding to a particular phys_index. If this gets to
be a real problem, we can always use a radix tree or something here."

So if this becomes a problem, we need a separate data structure to speed
up the lookup. (IOW, this was already the same in the old code)

Thanks!

-- 

Thanks,

David / dhildenb

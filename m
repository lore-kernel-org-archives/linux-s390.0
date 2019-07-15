Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbfGOLKj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 07:10:39 -0400
Subject: Re: [PATCH v3 10/11] mm/memory_hotplug: Make
 unregister_memory_block_under_nodes() never fail
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-11-david@redhat.com>
 <20190701085144.GJ6376@dhcp22.suse.cz> <20190701093640.GA17349@linux>
 <20190701102756.GO6376@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d450488d-7a82-f7a9-c8d3-b69a0bca48c6@redhat.com>
Date: Mon, 15 Jul 2019 13:10:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190701102756.GO6376@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>

On 01.07.19 12:27, Michal Hocko wrote:
> On Mon 01-07-19 11:36:44, Oscar Salvador wrote:
>> On Mon, Jul 01, 2019 at 10:51:44AM +0200, Michal Hocko wrote:
>>> Yeah, we do not allow to offline multi zone (node) ranges so the current
>>> code seems to be over engineered.
>>>
>>> Anyway, I am wondering why do we have to strictly check for already
>>> removed nodes links. Is the sysfs code going to complain we we try to
>>> remove again?
>>
>> No, sysfs will silently "fail" if the symlink has already been removed.
>> At least that is what I saw last time I played with it.
>>
>> I guess the question is what if sysfs handling changes in the future
>> and starts dropping warnings when trying to remove a symlink is not there.
>> Maybe that is unlikely to happen?
> 
> And maybe we handle it then rather than have a static allocation that
> everybody with hotremove configured has to pay for.
> 

So what's the suggestion? Dropping the nodemask_t completely and calling
sysfs_remove_link() on already potentially removed links?

Of course, we can also just use mem_blk->nid and rest assured that it
will never be called for memory blocks belonging to multiple nodes.

-- 

Thanks,

David / dhildenb

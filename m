Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfGOKvc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 06:51:32 -0400
Subject: Re: [PATCH v3 02/11] s390x/mm: Fail when an altmap is used for
 arch_add_memory()
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-3-david@redhat.com>
 <20190701074306.GC6376@dhcp22.suse.cz> <20190701124628.GT6376@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <86f3ff3d-d035-a806-88b7-b8c7b77c206e@redhat.com>
Date: Mon, 15 Jul 2019 12:51:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190701124628.GT6376@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>

On 01.07.19 14:46, Michal Hocko wrote:
> On Mon 01-07-19 09:43:06, Michal Hocko wrote:
>> On Mon 27-05-19 13:11:43, David Hildenbrand wrote:
>>> ZONE_DEVICE is not yet supported, fail if an altmap is passed, so we
>>> don't forget arch_add_memory()/arch_remove_memory() when unlocking
>>> support.
>>
>> Why do we need this? Sure ZONE_DEVICE is not supported for s390 and so
>> might be the case for other arches which support hotplug. I do not see
>> much point in adding warning to each of them.
> 
> I would drop this one. If there is a strong reason to have something
> like that it should come with a better explanation and it can be done on
> top.
> 

This was requested by Dan and I agree it is the right thing to do. In
the context of paravirtualized devices (e.g., virtio-pmem), it makes
sense to block functionality an arch does not support.

I'll leave the decision to Andrew.

-- 

Thanks,

David / dhildenb

Return-Path: <SRS0=OmxZ=TI=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v2 7/8] mm/memory_hotplug: Make
 unregister_memory_block_under_nodes() never fail
References: <20190507183804.5512-1-david@redhat.com>
 <20190507183804.5512-8-david@redhat.com>
 <CAPcyv4h2PgzQZrD0UU=4Qz_yH2C_hiYQyqV9U7CCkjpmHZ5xjQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1d369ae4-7183-b455-646a-65bbbe697281@redhat.com>
Date: Wed, 8 May 2019 09:21:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h2PgzQZrD0UU=4Qz_yH2C_hiYQyqV9U7CCkjpmHZ5xjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Oscar Salvador <osalvador@suse.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-ID: <linux-s390.vger.kernel.org>


>>  drivers/base/node.c  | 18 +++++-------------
>>  include/linux/node.h |  5 ++---
>>  2 files changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 04fdfa99b8bc..9be88fd05147 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -803,20 +803,14 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
>>
>>  /*
>>   * Unregister memory block device under all nodes that it spans.
>> + * Has to be called with mem_sysfs_mutex held (due to unlinked_nodes).
> 
> Given this comment can bitrot relative to the implementation lets
> instead add an explicit:
> 
>     lockdep_assert_held(&mem_sysfs_mutex);

That would require to make the mutex non-static. Is that what you
suggest, or any other alternative?

Thanks Dan!

> 
> With that you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 


-- 

Thanks,

David / dhildenb

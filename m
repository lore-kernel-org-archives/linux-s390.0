Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727609AbgBJSjL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:39:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AId9K2162129
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:39:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9pa378-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:39:09 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 18:39:02 -0000
Subject: Re: [PATCH 02/35] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-3-borntraeger@de.ibm.com>
 <2cf62b84-8eb6-18d5-437b-7e86401b9c45@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 19:38:53 +0100
MIME-Version: 1.0
In-Reply-To: <2cf62b84-8eb6-18d5-437b-7e86401b9c45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <083a3fd0-7b56-e92b-bf15-3383b7f5488b@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>



On 10.02.20 13:26, David Hildenbrand wrote:
> On 07.02.20 12:39, Christian Borntraeger wrote:
>> From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>>
>> The adapter interrupt page containing the indicator bits is currently
>> pinned. That means that a guest with many devices can pin a lot of
>> memory pages in the host. This also complicates the reference tracking
>> which is needed for memory management handling of protected virtual
>> machines.
>> We can reuse the pte notifiers to "cache" the page without pinning it.
>>
>> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
> 
> So, instead of pinning explicitly, look up the page address, cache it,
> and glue its lifetime to the gmap table entry. When that entry is
> changed, invalidate the cached page. On re-access, look up the page
> again and register the gmap notifier for the table entry again.

I think I might want to split this into two parts.
part 1: a naive approach that always does get_user_pages_remote/put_page
part 2: do the complex caching

Ulrich mentioned that this actually could make the map/unmap a no-op as we
have the address and bit already in the irq route. In the end this might be
as fast as todays pinning as we replace a list walk with a page table walk. 
Plus it would simplify the code. Will have a look if that is the case.

> 
> [...]
> 
>>  #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index c06c89d370a7..4bfb2f8fe57c 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -28,6 +28,7 @@
>>  #include <asm/switch_to.h>
>>  #include <asm/nmi.h>
>>  #include <asm/airq.h>
>> +#include <linux/pagemap.h>
>>  #include "kvm-s390.h"
>>  #include "gaccess.h"
>>  #include "trace-s390.h"
>> @@ -2328,8 +2329,8 @@ static int register_io_adapter(struct kvm_device *dev,
>>  		return -ENOMEM;
>>  
>>  	INIT_LIST_HEAD(&adapter->maps);
>> -	init_rwsem(&adapter->maps_lock);
>> -	atomic_set(&adapter->nr_maps, 0);
>> +	spin_lock_init(&adapter->maps_lock);
>> +	adapter->nr_maps = 0;
>>  	adapter->id = adapter_info.id;
>>  	adapter->isc = adapter_info.isc;
>>  	adapter->maskable = adapter_info.maskable;
>> @@ -2375,19 +2376,15 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>>  		ret = -EFAULT;
>>  		goto out;
>>  	}
>> -	ret = get_user_pages_fast(map->addr, 1, FOLL_WRITE, &map->page);
>> -	if (ret < 0)
>> -		goto out;
>> -	BUG_ON(ret != 1);
>> -	down_write(&adapter->maps_lock);
>> -	if (atomic_inc_return(&adapter->nr_maps) < MAX_S390_ADAPTER_MAPS) {
>> +	spin_lock(&adapter->maps_lock);
>> +	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
>> +		adapter->nr_maps++;
>>  		list_add_tail(&map->list, &adapter->maps);
> 
> I do wonder if we should check for duplicates. The unmap path will only
> remove exactly one entry. But maybe this can never happen or is already
> handled on a a higher layer.


This would be a broken userspace, but I also do not see a what would break
in the host if this happens.


> 
>>  }
>> @@ -2430,7 +2426,6 @@ void kvm_s390_destroy_adapters(struct kvm *kvm)
>>  		list_for_each_entry_safe(map, tmp,
>>  					 &kvm->arch.adapters[i]->maps, list) {
>>  			list_del(&map->list);
>> -			put_page(map->page);
>>  			kfree(map);
>>  		}
>>  		kfree(kvm->arch.adapters[i]);
> 
> Between the gmap being removed in kvm_arch_vcpu_destroy() and
> kvm_s390_destroy_adapters(), the entries would no longer properly get
> invalidated. AFAIK, removing/freeing the gmap will not trigger any
> notifiers.
> 
> Not sure if that's an issue (IOW, if we can have some very weird race).
> But I guess we would have similar races already :)

This is only called when all file descriptors are closed and this also closes
all irq routes. So I guess no I/O should be going on any more. 

> 
>> @@ -2690,6 +2685,31 @@ struct kvm_device_ops kvm_flic_ops = {
>>  	.destroy = flic_destroy,
>>  };
>>  
>> +void kvm_s390_adapter_gmap_notifier(struct gmap *gmap, unsigned long start,
>> +				    unsigned long end)
>> +{
>> +	struct kvm *kvm = gmap->private;
>> +	struct s390_map_info *map, *tmp;
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
>> +		struct s390_io_adapter *adapter = kvm->arch.adapters[i];
>> +
>> +		if (!adapter)
>> +			continue;
> 
> I have to ask very dumb: How is kvm->arch.adapters[] protected?

We only add new ones and this is removed at guest teardown it seems.
[...]

Let me have a look if we can simplify this.

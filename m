Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbgBTNbk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 08:31:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KDSqra069226
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 08:31:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubpshfc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 08:31:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 20 Feb 2020 13:31:36 -0000
Subject: Re: [PATCH v2 02/42] KVM: s390/interrupt: do not pin adapter
 interrupt pages
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-3-borntraeger@de.ibm.com>
 <073d3666-480e-5ba5-a46b-4cbd615f4174@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Feb 2020 14:31:30 +0100
MIME-Version: 1.0
In-Reply-To: <073d3666-480e-5ba5-a46b-4cbd615f4174@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <45954200-ccfe-cfac-200d-d1b903d9fc39@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 17.02.20 10:43, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>>
>> The adapter interrupt page containing the indicator bits is currently
>> pinned. That means that a guest with many devices can pin a lot of
>> memory pages in the host. This also complicates the reference tracking
>> which is needed for memory management handling of protected virtual
>> machines. It might also have some strange side effects for madvise
>> MADV_DONTNEED and other things.
>>
>> We can simply try to get the userspace page set the bits and free the
>> page. By storing the userspace address in the irq routing entry instead
>> of the guest address we can actually avoid many lookups and list walks
>> so that this variant is very likely not slower.
>>
>> If userspace messes around with the memory slots the worst thing that
>> can happen is that we write to some other memory within that process.
>> As we get the the page with FOLL_WRITE this can also not be used to
>> write to shared read-only pages.
>>
>> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>> [borntraeger@de.ibm.com: patch simplification]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/devices/s390_flic.rst |  11 +-
>>  arch/s390/include/asm/kvm_host.h             |   3 -
>>  arch/s390/kvm/interrupt.c                    | 170 ++++++-------------
>>  3 files changed, 53 insertions(+), 131 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/devices/s390_flic.rst b/Documentation/virt/kvm/devices/s390_flic.rst
>> index 954190da7d04..ea96559ba501 100644
>> --- a/Documentation/virt/kvm/devices/s390_flic.rst
>> +++ b/Documentation/virt/kvm/devices/s390_flic.rst
>> @@ -108,16 +108,9 @@ Groups:
>>        mask or unmask the adapter, as specified in mask
>>  
>>      KVM_S390_IO_ADAPTER_MAP
>> -      perform a gmap translation for the guest address provided in addr,
>> -      pin a userspace page for the translated address and add it to the
>> -      list of mappings
>> -
>> -      .. note:: A new mapping will be created unconditionally; therefore,
>> -	        the calling code should avoid making duplicate mappings.
>> -
>> +      This is now a no-op. The mapping is purely done by the irq route.
>>      KVM_S390_IO_ADAPTER_UNMAP
>> -      release a userspace page for the translated address specified in addr
>> -      from the list of mappings
>> +      This is now a no-op. The mapping is purely done by the irq route.
>>  
> 
> The interface should have accepted a hva from the very start and not
> guest addresses ...

right, but that is history. 

> 
> [...]

>> +	/*
>> +	 * We resolve the gpa to hva when setting the IRQ routing. the set_irq
>> +	 * code uses get_user_pages_remote to do the actual write.
> 
> nit: "get_user_pages_remote()"

ack.

> 
>> +	 */
>>  	case KVM_S390_IO_ADAPTER_MAP:
>> -		ret = kvm_s390_adapter_map(dev->kvm, req.id, req.addr);
>> -		break;
>>  	case KVM_S390_IO_ADAPTER_UNMAP:
>> -		ret = kvm_s390_adapter_unmap(dev->kvm, req.id, req.addr);
>> -		break;
>> +		return 0;
>>  	default:
>>  		ret = -EINVAL;
>>  	}
>> @@ -2699,19 +2622,21 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
>>  	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
>>  }
>>  
>> -static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
>> -					  u64 addr)
>> +static struct page *get_map_page(struct kvm *kvm,
>> +				 struct s390_io_adapter *adapter,
>> +				 u64 uaddr)
>>  {
>> -	struct s390_map_info *map;
>> +	struct page *page = NULL;
>>  
>>  	if (!adapter)
>>  		return NULL;
> 
> AFAIKs, this check is not necessary.

Right otherwise we would crash earlier.


> 
>> -
>> -	list_for_each_entry(map, &adapter->maps, list) {
>> -		if (map->guest_addr == addr)
>> -			return map;
>> -	}
>> -	return NULL;
>> +	if (!uaddr)
>> +		return NULL;
> 
> I do wonder if that check is necessary. I don't think so but might be
> missing something.

Nothing should break when we remove this check. get_user_pages_remote will
also return NULL (as newer kernels usually forbid mapping things at 0).

Will remove. 

[...]

>> @@ -2818,23 +2746,27 @@ int kvm_set_routing_entry(struct kvm *kvm,
>>  			  struct kvm_kernel_irq_routing_entry *e,
>>  			  const struct kvm_irq_routing_entry *ue)
>>  {
>> -	int ret;
>> +	u64 uaddr;
>>  
>>  	switch (ue->type) {
>> +	/* we store the userspace addresses instead of the guest addresses */
>>  	case KVM_IRQ_ROUTING_S390_ADAPTER:
>>  		e->set = set_adapter_int;
>> -		e->adapter.summary_addr = ue->u.adapter.summary_addr;
>> -		e->adapter.ind_addr = ue->u.adapter.ind_addr;
>> +		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.summary_addr);
>> +		if (uaddr == -EFAULT)
>> +			return -EFAULT;
>> +		e->adapter.summary_addr = uaddr;
>> +		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.ind_addr);
>> +		if (uaddr == -EFAULT)
>> +			return -EFAULT;
> 
> AFAIK, leaving e->adapter.summary_addr set is not an issue.
> 
> Interesting, in kvm_s390_adapter_map(), we didn't synchronize again slot
> updates when doing the gmap_translate(), which looks wrong to me ...
> 
> It seems to be the same thing here. I do wonder if it is safe to do a
> gmap_translate() here, looks like this can race with
> kvm_arch_commit_memory_region().
> 
> I would have assumed we need e.g., the slots_lock while doing the
> gmap_translate() - or a srcu_read_lock(&vcpu->kvm->srcu) or similar ...

gmap_translate does this via the gmap and it holds the mm sem. gmap_unmap_segment
takes the same lock. So I think we are ok here.
 
> 
> Apart from that, looks good to me.
> 

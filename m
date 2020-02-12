Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbgBLMXB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 07:23:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CCJdEp089841
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 07:23:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u2g8gv2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 07:23:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 12 Feb 2020 12:22:57 -0000
Subject: Re: [PATCH v2 RFC] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <567B980B-BDA5-4EF3-A96E-1542D11F2BD4@redhat.com>
 <20200211092341.3965-1-borntraeger@de.ibm.com>
 <01d1c188-38fb-e405-83d7-6184adccba5a@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Feb 2020 13:22:52 +0100
MIME-Version: 1.0
In-Reply-To: <01d1c188-38fb-e405-83d7-6184adccba5a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b72359a7-fb4b-6862-33e2-5cba9d48ab56@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, cohuck@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com, "dgilbert@redhat.com" <dgilbert@redhat.com>



On 12.02.20 13:16, David Hildenbrand wrote:
> 
>> +	/*
>> +	 * We resolve the gpa to hva when setting the IRQ routing. If userspace
>> +	 * decides to mess with the memslots it better also updates the irq
>> +	 * routing. Otherwise we will write to the wrong userspace address.
>> +	 */
> 
> I guess this is just as old handling, where a page was pinned. But
> slightly better :) So the pages are definitely part of guest memory.
> 
> Fun stuff: If (a nasty) guest (in current code) zappes this page using
> balloon inflation and the page is re-accessed (e.g., by the guest or by
> the host), a new page will be faulted in, and there will be an
> inconsistency between what the guest/user space sees and what this code
> sees. Going via the user space address looks cleaner.
> 
> Now, with postcopy live migration, we will also zap all guest memory
> before starting the guest, I do wonder if that produces a similar
> inconsistency ... usually, when pages are pinned in the kernel, we
> inhibit the balloon and implicitly also postcopy.
> 
> If so, this actually fixes an issue. But might depend on the order
> things are initialized in user space. Or I am messing up things :)

Yes, the current code has some corner cases where a guest can shoot himself
in the foot. This variant could actually be safer. 
> 
> [...]
> 
>>  static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
>>  {
>> -	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
>> -	struct s390_map_info *map, *tmp;
>> -	int found = 0;
>> -
>> -	if (!adapter || !addr)
>> -		return -EINVAL;
>> -
>> -	down_write(&adapter->maps_lock);
>> -	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
>> -		if (map->guest_addr == addr) {
>> -			found = 1;
>> -			atomic_dec(&adapter->nr_maps);
>> -			list_del(&map->list);
>> -			put_page(map->page);
>> -			kfree(map);
>> -			break;
>> -		}
>> -	}
>> -	up_write(&adapter->maps_lock);
>> -
>> -	return found ? 0 : -EINVAL;
>> +	return 0;
> 
> Can we get rid of this function?

And do a return in the handler? maybe yes. Will have a look.
> 
>>  }
> 
>> +static struct page *get_map_page(struct kvm *kvm,
>> +				 struct s390_io_adapter *adapter,
>> +				 u64 uaddr)
>>  {
>> -	struct s390_map_info *map;
>> +	struct page *page;
>> +	int ret;
>>  
>>  	if (!adapter)
>>  		return NULL;
>> -
>> -	list_for_each_entry(map, &adapter->maps, list) {
>> -		if (map->guest_addr == addr)
>> -			return map;
>> -	}
>> -	return NULL;
>> +	page = NULL;
> 
> struct page *page = NULL;
> 
>> +	if (!uaddr)
>> +		return NULL;
>> +	down_read(&kvm->mm->mmap_sem);
>> +	ret = get_user_pages_remote(NULL, kvm->mm, uaddr, 1, FOLL_WRITE,
>> +				    &page, NULL, NULL);
>> +	if (ret < 1)
>> +		page = NULL;
> 
> Is that really necessary? According to the doc, pinned pages are stored
> to the array.  ret < 1 means "no pages" were pinned, so nothing should
> be stored.

Probably. Will have a look.

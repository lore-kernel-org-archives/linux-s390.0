Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgBULFi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 06:05:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LB5KN6123556
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 06:05:37 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8uc0p58j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 06:05:37 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 21 Feb 2020 11:05:35 -0000
Subject: Re: [PATCH v3.1 02/37] KVM: s390/interrupt: do not pin adapter
 interrupt pages
References: <20200220104020.5343-3-borntraeger@de.ibm.com>
 <20200221080942.10334-1-borntraeger@de.ibm.com>
 <20200221114158.2eeca512.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Feb 2020 12:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200221114158.2eeca512.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <83b4d4e6-3143-a7bb-84b8-bd0feced0d6f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Ulrich.Weigand@de.ibm.com, david@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 21.02.20 11:41, Cornelia Huck wrote:
> On Fri, 21 Feb 2020 03:09:42 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
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
>>  arch/s390/kvm/interrupt.c                    | 172 ++++++-------------
>>  3 files changed, 52 insertions(+), 134 deletions(-)
> 
> (...)
> 
>> @@ -2456,12 +2378,13 @@ static int modify_io_adapter(struct kvm_device *dev,
>>  		if (ret > 0)
>>  			ret = 0;
>>  		break;
>> +	/*
>> +	 * We resolve the gpa to hva when setting the IRQ routing. the set_irq
>> +	 * code uses get_user_pages_remote() to do the actual write.
>> +	 */
> 
> What about:
> 
> "The following operations are no longer needed and therefore no-ops.
> The gpa to hva translation is done when an IRQ route is set up. The
> set_irq code uses get_user_pages_remote() to do the actual write."

ack, reads better.

> 
>>  	case KVM_S390_IO_ADAPTER_MAP:
>> -		ret = kvm_s390_adapter_map(dev->kvm, req.id, req.addr);
>> -		break;
>>  	case KVM_S390_IO_ADAPTER_UNMAP:
>> -		ret = kvm_s390_adapter_unmap(dev->kvm, req.id, req.addr);
>> -		break;
>> +		return 0;
> 
> I think
> 		ret = 0;
> 		break;
> would be better, as the other cases do not do a direct return, either.

fine with me. ack
> 
>>  	default:
>>  		ret = -EINVAL;
>>  	}
>> @@ -2699,19 +2622,17 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
>>  	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
>>  }
>>  
>> -static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
>> -					  u64 addr)
>> +static struct page *get_map_page(struct kvm *kvm,
>> +				 struct s390_io_adapter *adapter,
> 
> adapter seems to be unused in this function now? Should we remove it from the parameter list?

yep, thanks. removed.

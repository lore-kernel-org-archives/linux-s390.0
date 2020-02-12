Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgBLMpG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 07:45:06 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CCewXc076238
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 07:45:05 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y3wxspt6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 07:45:05 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 12 Feb 2020 12:45:03 -0000
Subject: Re: [PATCH v2 RFC] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <567B980B-BDA5-4EF3-A96E-1542D11F2BD4@redhat.com>
 <20200211092341.3965-1-borntraeger@de.ibm.com>
 <20200212133908.6c6c9072.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Feb 2020 13:44:53 +0100
MIME-Version: 1.0
In-Reply-To: <20200212133908.6c6c9072.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ba5862cd-c0ff-c0f1-bf00-8220fa407d52@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: david@redhat.com, Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 12.02.20 13:39, Cornelia Huck wrote:
[...]

>> +	 */
>> +	return 0;
> 
> Given that this function now always returns 0, we basically get a
> completely useless roundtrip into the kernel when userspace is trying
> to setup the mappings.
> 
> Can we define a new IO_ADAPTER_MAPPING_NOT_NEEDED or so capability that
> userspace can check?

Nack. This is one system call per initial indicator ccw. This is so seldom
and cheap that I do not see a point in optimizing this. 


> This change in behaviour probably wants a change in the documentation
> as well.

Yep. 
[...]

>> @@ -2951,12 +2900,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
>>  			  const struct kvm_irq_routing_entry *ue)
>>  {
>>  	int ret;
>> +	u64 uaddr;
>>  
>>  	switch (ue->type) {
>>  	case KVM_IRQ_ROUTING_S390_ADAPTER:
>>  		e->set = set_adapter_int;
>> -		e->adapter.summary_addr = ue->u.adapter.summary_addr;
>> -		e->adapter.ind_addr = ue->u.adapter.ind_addr;
>> +		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.summary_addr);
> 
> Can gmap_translate() return -EFAULT here? The code above only seems to
> check for 0... do we want to return an error here?

Yes.

> 
>> +		e->adapter.summary_addr = uaddr;
>> +		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.ind_addr);
>> +		e->adapter.ind_addr = uaddr;
>>  		e->adapter.summary_offset = ue->u.adapter.summary_offset;
>>  		e->adapter.ind_offset = ue->u.adapter.ind_offset;
>>  		e->adapter.adapter_id = ue->u.adapter.adapter_id;
> 

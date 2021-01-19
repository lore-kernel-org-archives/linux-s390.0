Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389772AbhASTwH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 14:52:07 -0500
Subject: Re: [PATCH 1/1] KVM: s390: diag9c forwarding
References: <20210118131739.7272-1-borntraeger@de.ibm.com>
 <20210118131739.7272-2-borntraeger@de.ibm.com>
 <20210119175359.1a5ea5be.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ee6fef19-78b5-c897-0210-fedc52984369@linux.ibm.com>
Date: Tue, 19 Jan 2021 20:51:17 +0100
MIME-Version: 1.0
In-Reply-To: <20210119175359.1a5ea5be.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>



On 1/19/21 5:53 PM, Cornelia Huck wrote:
> On Mon, 18 Jan 2021 14:17:39 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> When we receive intercept a DIAG_9C from the guest we verify
>> that the target real CPU associated with the virtual CPU
>> designated by the guest is running and if not we forward the
>> DIAG_9C to the target real CPU.
>>
>> To avoid a diag9c storm we allow a maximal rate of diag9c forwarding.
>>
>> The rate is calculated as a count per second defined as a
>> new parameter of the s390 kvm module: diag9c_forwarding_hz .
>>
>> The default value is to not forward diag9c.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  1 +
>>   arch/s390/include/asm/smp.h      |  1 +
>>   arch/s390/kernel/smp.c           |  1 +
>>   arch/s390/kvm/diag.c             | 31 ++++++++++++++++++++++++++++---
>>   arch/s390/kvm/kvm-s390.c         |  6 ++++++
>>   arch/s390/kvm/kvm-s390.h         |  8 ++++++++
>>   6 files changed, 45 insertions(+), 3 deletions(-)
>>
> 
> (...)
> 
>> @@ -167,9 +180,21 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>>   	if (!tcpu)
>>   		goto no_yield;
>>   
>> -	/* target already running */
>> -	if (READ_ONCE(tcpu->cpu) >= 0)
>> -		goto no_yield;
>> +	/* target VCPU already running */
> 
> Maybe make this /* target guest VPCU already running */...
> 
>> +	if (READ_ONCE(tcpu->cpu) >= 0) {
>> +		if (!diag9c_forwarding_hz || diag9c_forwarding_overrun())
>> +			goto no_yield;
>> +
>> +		/* target CPU already running */
> 
> ...and this /* target host CPU already running */? I just read this
> several times and was confused before I spotted the difference :)

I can only agree then :) .

...


-- 
Pierre Morel
IBM Lab Boeblingen

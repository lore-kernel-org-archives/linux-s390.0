Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbfJJK27 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 06:28:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9AACbRI041693
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 06:28:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vj2pmrg61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 06:28:57 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 10 Oct 2019 11:28:55 +0100
Subject: Re: [PATCH] KVM: s390: filter and count invalid yields
References: <20191010102131.109736-1-borntraeger@de.ibm.com>
 <4323a6bb-35b7-bd23-8fb8-abb7c589d7fc@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 10 Oct 2019 12:28:50 +0200
MIME-Version: 1.0
In-Reply-To: <4323a6bb-35b7-bd23-8fb8-abb7c589d7fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8c17bc83-c572-7284-3cf7-c3bbd5f63ff9@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>



On 10.10.19 12:25, David Hildenbrand wrote:
> On 10.10.19 12:21, Christian Borntraeger wrote:
>> To analyze some performance issues with lock contention and scheduling
>> it is nice to know when diag9c did not result in any action.
>> At the same time avoid calling the scheduler (which can be expensive)
>> if we know that it does not make sense.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  2 ++
>>  arch/s390/kvm/diag.c             | 23 +++++++++++++++++++----
>>  arch/s390/kvm/kvm-s390.c         |  2 ++
>>  3 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index abe60268335d..743cd5a63b37 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -392,6 +392,8 @@ struct kvm_vcpu_stat {
>>  	u64 diagnose_10;
>>  	u64 diagnose_44;
>>  	u64 diagnose_9c;
>> +	u64 diagnose_9c_success;
>> +	u64 diagnose_9c_ignored;
> 
> Can't you derive the one from the other with diagnose_9c? Just sayin,
> one would be sufficient.

You mean diagnose9c = diagnose_9c_success + diagnose_9c_ignored anyway so this is redundant?
Could just do diagnose_9c  and diagnose_9c_ignored if you prefer that.


> 
>>  	u64 diagnose_258;
>>  	u64 diagnose_308;
>>  	u64 diagnose_500;
>> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
>> index 45634b3d2e0a..2c729f020585 100644
>> --- a/arch/s390/kvm/diag.c
>> +++ b/arch/s390/kvm/diag.c
>> @@ -158,14 +158,29 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>>  
>>  	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
>>  	vcpu->stat.diagnose_9c++;
>> -	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d", tid);
>>  
>> +	/* yield to self */
>>  	if (tid == vcpu->vcpu_id)
>> -		return 0;
>> +		goto no_yield;
>>  
>> +	/* yield to invalid */
>>  	tcpu = kvm_get_vcpu_by_id(vcpu->kvm, tid);
>> -	if (tcpu)
>> -		kvm_vcpu_yield_to(tcpu);
>> +	if (!tcpu)
>> +		goto no_yield;
>> +
>> +	/* target already running */
>> +	if (tcpu->cpu >= 0)
>> +		goto no_yield;
> 
> Wonder if it's wort moving this optimization to a separate patch.

Could do if you prefer that. 


> 
>> +
>> +	if (kvm_vcpu_yield_to(tcpu) <= 0)
>> +		goto no_yield;
>> +
>> +	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: done", tid);
>> +	vcpu->stat.diagnose_9c_success++;
>> +	return 0;
>> +no_yield:
>> +	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: ignored", tid);
>> +	vcpu->stat.diagnose_9c_ignored++;
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 4a3bc40ca1a4..b368e835f2f7 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -155,6 +155,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>>  	{ "instruction_diag_10", VCPU_STAT(diagnose_10) },
>>  	{ "instruction_diag_44", VCPU_STAT(diagnose_44) },
>>  	{ "instruction_diag_9c", VCPU_STAT(diagnose_9c) },
>> +	{ "diag_9c_success", VCPU_STAT(diagnose_9c_success) },
>> +	{ "diag_9c_ignored", VCPU_STAT(diagnose_9c_ignored) },
>>  	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
>>  	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
>>  	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
>>
> 
> 

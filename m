Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgBRKFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 05:05:54 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IA4Q7N027692
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 05:05:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2f8pc0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 05:05:53 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 18 Feb 2020 10:05:51 -0000
Subject: Re: [PATCH v2 33/42] KVM: s390: protvirt: Mask PSW interrupt bits for
 interception 104 and 112
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-34-borntraeger@de.ibm.com>
 <70f30f71-f7f2-8286-aafb-ea5ca5fb86e9@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Feb 2020 11:05:43 +0100
MIME-Version: 1.0
In-Reply-To: <70f30f71-f7f2-8286-aafb-ea5ca5fb86e9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6206d179-f9c4-be76-25cd-0cd9cefa2c2c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>


On 18.02.20 10:53, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> We're not allowed to inject interrupts on intercepts that leave the
>> guest state in an "in-between" state where the next SIE entry will do a
>> continuation, namely secure instruction interception (104) and secure
>> prefix interception (112).
>> As our PSW is just a copy of the real one that will be replaced on the
>> next exit, we can mask out the interrupt bits in the PSW to make sure
>> that we do not inject anything.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index b6113285f47f..1b6963bbc96f 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4025,6 +4025,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>>  	return vcpu_post_run_fault_in_sie(vcpu);
>>  }
>>  
>> +#define PSW_INT_MASK (PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_MCHECK)
>>  static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  {
>>  	int rc, exit_reason;
>> @@ -4061,6 +4062,16 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  			memcpy(vcpu->run->s.regs.gprs,
>>  			       sie_page->pv_grregs,
>>  			       sizeof(sie_page->pv_grregs));
>> +			/*
>> +			 * We're not allowed to inject interrupts on intercepts
>> +			 * that leave the guest state in an "in-between" state
>> +			 * where the next SIE entry will do a continuation.
>> +			 * Fence interrupts in our "internal" PSW.
>> +			 */
>> +			if (vcpu->arch.sie_block->icptcode == ICPT_PV_INSTR ||
>> +			    vcpu->arch.sie_block->icptcode == ICPT_PV_PREF) {
>> +				vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;
>> +			}
> 
> Is this actually the right approach? I mean, you lose PSW masks, but you
> only want to teach the interrupt delivery code to skip delivering
> interrupts until the intercept has been handled. Does not look clean to
> me TBH.

The only purpose of the PSW mask in PV is to tell the hypervisor what interrupts
are deliverable or if we are in wait state.  In fact those bits are the only
ones that we see. So I think its fair to use those.

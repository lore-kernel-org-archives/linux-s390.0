Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42083 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgBRKCp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 05:02:45 -0500
Subject: Re: [PATCH v2 33/42] KVM: s390: protvirt: Mask PSW interrupt bits for
 interception 104 and 112
From: David Hildenbrand <david@redhat.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-34-borntraeger@de.ibm.com>
 <70f30f71-f7f2-8286-aafb-ea5ca5fb86e9@redhat.com>
Message-ID: <b9220515-6d9e-a338-e4f8-4c11c795315a@redhat.com>
Date: Tue, 18 Feb 2020 11:02:37 +0100
MIME-Version: 1.0
In-Reply-To: <70f30f71-f7f2-8286-aafb-ea5ca5fb86e9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
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

After reading the patch description again :)

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

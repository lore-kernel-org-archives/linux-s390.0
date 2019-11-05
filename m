Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726594AbfKEMBk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 07:01:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5BxmNw119375
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 07:01:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w37vgt782-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 07:01:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 5 Nov 2019 12:01:35 -0000
Subject: Re: [RFC 19/37] KVM: s390: protvirt: Add new gprs location handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-20-frankja@linux.ibm.com>
 <2eba24a5-063d-1e93-acf0-1153963facfe@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Nov 2019 13:01:29 +0100
MIME-Version: 1.0
In-Reply-To: <2eba24a5-063d-1e93-acf0-1153963facfe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8f7a9da4-2a49-9e3f-573e-199cd71fc99c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 04.11.19 12:25, David Hildenbrand wrote:
> On 24.10.19 13:40, Janosch Frank wrote:
>> Guest registers for protected guests are stored at offset 0x380.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  4 +++-
>>   arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 0ab309b7bf4c..5deabf9734d9 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -336,7 +336,9 @@ struct kvm_s390_itdb {
>>   struct sie_page {
>>       struct kvm_s390_sie_block sie_block;
>>       struct mcck_volatile_info mcck_info;    /* 0x0200 */
>> -    __u8 reserved218[1000];        /* 0x0218 */
>> +    __u8 reserved218[360];        /* 0x0218 */
>> +    __u64 pv_grregs[16];        /* 0x380 */
>> +    __u8 reserved400[512];
>>       struct kvm_s390_itdb itdb;    /* 0x0600 */
>>       __u8 reserved700[2304];        /* 0x0700 */
>>   };
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 490fde080107..97d3a81e5074 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3965,6 +3965,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>>   static int __vcpu_run(struct kvm_vcpu *vcpu)
>>   {
>>       int rc, exit_reason;
>> +    struct sie_page *sie_page = (struct sie_page *)vcpu->arch.sie_block;
>>         /*
>>        * We try to hold kvm->srcu during most of vcpu_run (except when run-
>> @@ -3986,8 +3987,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>           guest_enter_irqoff();
>>           __disable_cpu_timer_accounting(vcpu);
>>           local_irq_enable();
>> +        if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +            memcpy(sie_page->pv_grregs,
>> +                   vcpu->run->s.regs.gprs,
>> +                   sizeof(sie_page->pv_grregs));
>> +        }
>>           exit_reason = sie64a(vcpu->arch.sie_block,
>>                        vcpu->run->s.regs.gprs);
>> +        if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +            memcpy(vcpu->run->s.regs.gprs,
>> +                   sie_page->pv_grregs,
>> +                   sizeof(sie_page->pv_grregs));
>> +        }
> 
> sie64a will load/save gprs 0-13 from to vcpu->run->s.regs.gprs.
> 
> I would have assume that this is not required for prot virt, because the HW has direct access via the sie block?

Yes, that is correct. The load/save in sie64a is not necessary for pv guests.

> 
> 
> 1. Would it make sense to have a specialized sie64a() (or a parameter, e.g., if you pass in NULL in r3), that optimizes this loading/saving? Eventually we can also optimize which host registers to save/restore then.

Having 2 kinds of sie64a seems not very nice for just saving a small number of cycles.

> 
> 2. Avoid this copying here. We have to store the state to vcpu->run->s.regs.gprs when returning to user space and restore the state when coming from user space.

I like this proposal better than the first one and
> 
> Also, we access the GPRS from interception handlers, there we might use wrappers like
> 
> kvm_s390_set_gprs()
> kvm_s390_get_gprs()

having register accessors might be useful anyway.
But I would like to defer that to a later point in time to keep the changes in here
minimal?

We can add a "TODO" comment in here so that we do not forget about this
for a future patch. Makes sense?

> 
> to route to the right location. There are multiple options to optimize this.

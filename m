Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbgBJNsO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 08:48:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADeEv9129800
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:48:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ubqdxb7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:48:12 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 13:48:10 -0000
Subject: Re: [PATCH 32/35] KVM: s390: protvirt: Mask PSW interrupt bits for
 interception 104 and 112
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-33-borntraeger@de.ibm.com>
 <20200210142845.2188b008.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 14:48:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200210142845.2188b008.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <305c63ba-b9f1-aa88-7006-709c85006cda@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 10.02.20 14:28, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:55 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> We're not allowed to inject interrupts on intercepts that leave the
>> guest state in an "in-beetween" state where the next SIE entry will do a
> 
> s/beetween/between/

ack
> 
>> continuation.  Namely secure instruction interception and secure prefix
> 
> s/continuation. Namely/continuation, namely,/

ack.
> 
> Add which one is 104 and which one is 112, so you can match up the
> description with the subject?

ack.
> 
> 
>> interception.
>> As our PSW is just a copy of the real one that will be replaced on the
>> next exit, we can mask out the interrupt bits in the PSW to make sure
>> that we do not inject anything.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index ced2bac251a6..8c7b27287b91 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4052,6 +4052,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>>  	return vcpu_post_run_fault_in_sie(vcpu);
>>  }
>>  
>> +#define PSW_INT_MASK (PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_MCHECK)
>>  static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  {
>>  	int rc, exit_reason;
>> @@ -4088,6 +4089,10 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  			memcpy(vcpu->run->s.regs.gprs,
>>  			       sie_page->pv_grregs,
>>  			       sizeof(sie_page->pv_grregs));
> 
> Add a comment, as suggested by Thomas last time?


diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b53cabc15d9d..52a5196fe975 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4089,6 +4089,12 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
                        memcpy(vcpu->run->s.regs.gprs,
                               sie_page->pv_grregs,
                               sizeof(sie_page->pv_grregs));
+                       /*
+                        * We're not allowed to inject interrupts on intercepts
+                        * that leave the guest state in an "in-beetween" state
+                        * where the next SIE entry will do a continuation.
+                        * Fence interrupts in our "internal" PSW.
+                        */
                        if (vcpu->arch.sie_block->icptcode == ICPT_PV_INSTR ||
                            vcpu->arch.sie_block->icptcode == ICPT_PV_PREF) {
                                vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;



> 
>> +			if (vcpu->arch.sie_block->icptcode == ICPT_PV_INSTR ||
>> +			    vcpu->arch.sie_block->icptcode == ICPT_PV_PREF) {
>> +				vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;
>> +			}
>>  		}
>>  		local_irq_disable();
>>  		__enable_cpu_timer_accounting(vcpu);
> 

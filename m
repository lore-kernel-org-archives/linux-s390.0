Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726967AbgA3LOs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 06:14:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UBEG17103435
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:14:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xubct9hnd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:14:46 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Jan 2020 11:14:45 -0000
Subject: Re: [PATCH/FIXUP FOR STABLE BEFORE THIS SERIES] KVM: s390: do not
 clobber user space fpc during guest reset
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200129200312.3200-2-frankja@linux.ibm.com>
 <1580374500-31247-1-git-send-email-borntraeger@de.ibm.com>
 <7b40856d-8153-ad3f-bea8-110fa6e1aea6@redhat.com>
 <7711b8a0-f126-aedd-f22b-748fa62cd437@de.ibm.com>
Date: Thu, 30 Jan 2020 12:14:40 +0100
MIME-Version: 1.0
In-Reply-To: <7711b8a0-f126-aedd-f22b-748fa62cd437@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1620d717-b7c3-09d6-8986-a11804c12a41@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, frankja@linux.ibm.com
Cc: cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, stable@kernel.org



On 30.01.20 12:01, Christian Borntraeger wrote:
> 
> 
> On 30.01.20 10:49, David Hildenbrand wrote:
>> On 30.01.20 09:55, Christian Borntraeger wrote:
>>> The initial CPU reset currently clobbers the userspace fpc. This was an
>>> oversight during a fixup for the lazy fpu reloading rework.  The reset
>>> calls are only done from userspace ioctls. No CPU context is loaded, so
>>> we can (and must) act directly on the sync regs, not on the thread
>>> context. Otherwise the fpu restore call will restore the zeroes fpc to
>>> userspace.
>>>
>>> Cc: stable@kernel.org
>>> Fixes: 9abc2a08a7d6 ("KVM: s390: fix memory overwrites when vx is disabled")
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  arch/s390/kvm/kvm-s390.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index c059b86..eb789cd 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -2824,8 +2824,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>>>  	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
>>>  					CR14_UNUSED_33 |
>>>  					CR14_EXTERNAL_DAMAGE_SUBMASK;
>>> -	/* make sure the new fpc will be lazily loaded */
>>> -	save_fpu_regs();
>>> +	vcpu->run->s.regs.fpc = 0;
>>>  	current->thread.fpu.fpc = 0;
>>>  	vcpu->arch.sie_block->gbea = 1;
>>>  	vcpu->arch.sie_block->pp = 0;
>>>
>>
>> kvm_arch_vcpu_ioctl() does a vcpu_load(vcpu), followed by the call to
>> kvm_arch_vcpu_ioctl_initial_reset(), followed by a vcpu_put().
>>
>> What am I missing?
> 
> vcpu_load/put does no longer reload the registers lazily. We moved that out into the
> vcpu_run ioctl itself. (this avoids register reloading during schedule).

see
e1788bb KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load
31d8b8d KVM: s390: handle access registers in the run ioctl not in vcpu_put/load

so maybe we want to change the Fixes tag to this patch.

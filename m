Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726893AbgA3LHy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 06:07:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UB6QQG030061
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:07:52 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xtrmce6pm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:07:52 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Jan 2020 11:07:50 -0000
Subject: Re: [PATCH/FIXUP FOR STABLE BEFORE THIS SERIES] KVM: s390: do not
 clobber user space fpc during guest reset
References: <20200129200312.3200-2-frankja@linux.ibm.com>
 <1580374500-31247-1-git-send-email-borntraeger@de.ibm.com>
 <7b40856d-8153-ad3f-bea8-110fa6e1aea6@redhat.com>
 <20200130113941.78e4bf2e.cohuck@redhat.com>
 <336905ea-dc59-3118-9329-fc29c8386c52@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 30 Jan 2020 12:07:46 +0100
MIME-Version: 1.0
In-Reply-To: <336905ea-dc59-3118-9329-fc29c8386c52@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5231e3da-e705-66f8-7426-fdf51cd4600e@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@kernel.org



On 30.01.20 11:56, Thomas Huth wrote:
> On 30/01/2020 11.39, Cornelia Huck wrote:
>> On Thu, 30 Jan 2020 10:49:35 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 30.01.20 09:55, Christian Borntraeger wrote:
>>>> The initial CPU reset currently clobbers the userspace fpc. This was an
>>>> oversight during a fixup for the lazy fpu reloading rework.  The reset
>>>> calls are only done from userspace ioctls. No CPU context is loaded, so
>>>> we can (and must) act directly on the sync regs, not on the thread
>>>> context. Otherwise the fpu restore call will restore the zeroes fpc to
>>>> userspace.
>>>>
>>>> Cc: stable@kernel.org
>>>> Fixes: 9abc2a08a7d6 ("KVM: s390: fix memory overwrites when vx is disabled")
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>  arch/s390/kvm/kvm-s390.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index c059b86..eb789cd 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -2824,8 +2824,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>>>>  	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
>>>>  					CR14_UNUSED_33 |
>>>>  					CR14_EXTERNAL_DAMAGE_SUBMASK;
>>>> -	/* make sure the new fpc will be lazily loaded */
>>>> -	save_fpu_regs();
>>>> +	vcpu->run->s.regs.fpc = 0;
>>>>  	current->thread.fpu.fpc = 0;
>>>>  	vcpu->arch.sie_block->gbea = 1;
>>>>  	vcpu->arch.sie_block->pp = 0;
>>>>   
>>>
>>> kvm_arch_vcpu_ioctl() does a vcpu_load(vcpu), followed by the call to
>>> kvm_arch_vcpu_ioctl_initial_reset(), followed by a vcpu_put().
>>>
>>> What am I missing?
>>
>> I have been staring at this patch for some time now, and I fear I'm
>> missing something as well. Can we please get more explanation?
> 
> Could we please get a test for this issue in the kvm selftests, too?
> I.e. host sets a value in its FPC, then calls the INITIAL_RESET ioctl
> and then checks that the value in its FPC is still there?

Yes, that will come as a later addon patch. (But I am still going to apply
this series soon and do not wait for that. I have a private hack in qemu that
does this checking, but this test code is too ugly to see the world).

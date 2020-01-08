Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726699AbgAHOiZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 09:38:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008EbQh7102718
        for <linux-s390@vger.kernel.org>; Wed, 8 Jan 2020 09:38:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xd0wk6a8k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2020 09:38:24 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 8 Jan 2020 14:38:22 -0000
Subject: Re: [PATCH v3] KVM: s390: Add new reset vcpu API
References: <20191205120956.50930-1-frankja@linux.ibm.com>
 <dd724da0-9bba-079e-6b6f-756762dbc942@de.ibm.com>
 <d0db08ef-ade9-93d4-105f-ace6fef50c81@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 8 Jan 2020 15:38:18 +0100
MIME-Version: 1.0
In-Reply-To: <d0db08ef-ade9-93d4-105f-ace6fef50c81@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3ddb7aa6-96d4-246f-a8ba-fdf2408a4ff0@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 08.01.20 15:35, Janosch Frank wrote:
> On 1/8/20 3:28 PM, Christian Borntraeger wrote:
>>
>>
>> On 05.12.19 13:09, Janosch Frank wrote:
>> [...]
>>> +4.123 KVM_S390_CLEAR_RESET
>>> +
>>> +Capability: KVM_CAP_S390_VCPU_RESETS
>>> +Architectures: s390
>>> +Type: vcpu ioctl
>>> +Parameters: none
>>> +Returns: 0
>>> +
>>> +This ioctl resets VCPU registers and control structures that QEMU
>>> +can't access via the kvm_run structure. The clear reset is a superset
>>> +of the initial reset and additionally clears general, access, floating
>>> +and vector registers.
>>
>> As Thomas outlined, make it more obvious that userspace does the remaining
>> parts. I do not think that we want the kernel to do the things (unless it
>> helps you in some way for the ultravisor guests)
> 
> Ok, will do

I changed my mind (see my other mail) but I would like Thomas, Conny or David
to ack/nack.

> 
>>
>> [...]
>>>  
>>> +static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
>>> +{
>>> +	kvm_clear_async_pf_completion_queue(vcpu);
>>> +	kvm_s390_clear_local_irqs(vcpu);
>>> +	return 0;
>>
>> Shouldnt we also do 
>>         if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>>                 kvm_s390_vcpu_stop(vcpu);
>>
>> here?
> 
> Isn't userspace cpu state ctrl basically a prereq anyway for getting
> those new ioctls?

I do not see a reason why we should mandate userspace cpu state for the normal
reset. Using this if also enables the fallthrough below - which I like.

> 
>>
>>
>>> +}
>>> +
>>>  static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>>  {
>>>  	kvm_s390_vcpu_initial_reset(vcpu);
>>> @@ -4363,9 +4371,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>>  		r = kvm_arch_vcpu_ioctl_set_initial_psw(vcpu, psw);
>>>  		break;
>>>  	}
>>> +
>>> +	case KVM_S390_CLEAR_RESET:
>>> +		/* fallthrough */
>>>  	case KVM_S390_INITIAL_RESET:
>>>  		r = kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>>  		break;
>>
>> Then we could also do a fallthrough here and do:
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d9e6bf3..c715ae3 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2867,10 +2867,6 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>>         vcpu->arch.sie_block->pp = 0;
>>         vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>>         vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
>> -       kvm_clear_async_pf_completion_queue(vcpu);
>> -       if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
>> -               kvm_s390_vcpu_stop(vcpu);
>> -       kvm_s390_clear_local_irqs(vcpu);
>>  }
>>  
>>  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>>
>>
>>
>>
>>> +	case KVM_S390_NORMAL_RESET:
>>> +		r = kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>>> +		break;
>>>  	case KVM_SET_ONE_REG:
>>>  	case KVM_GET_ONE_REG: {
> 
> 

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389861AbgFSRSH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Jun 2020 13:18:07 -0400
Subject: Re: [PATCH v8 2/2] s390/kvm: diagnose 0x318 sync and reset
References: <20200618222222.23175-1-walling@linux.ibm.com>
 <20200618222222.23175-3-walling@linux.ibm.com>
 <eb41cdd1-9bdf-eb0c-1296-254ade66397a@redhat.com>
 <e080cf6d-c8cb-a363-1fd1-cbbc4cbda7fe@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <09821617-3f21-f61e-4e6e-6c992a43d787@redhat.com>
Date: Fri, 19 Jun 2020 19:17:58 +0200
MIME-Version: 1.0
In-Reply-To: <e080cf6d-c8cb-a363-1fd1-cbbc4cbda7fe@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 19.06.20 17:47, Collin Walling wrote:
> On 6/19/20 10:52 AM, David Hildenbrand wrote:
>> On 19.06.20 00:22, Collin Walling wrote:
>>> DIAGNOSE 0x318 (diag318) sets information regarding the environment
>>> the VM is running in (Linux, z/VM, etc) and is observed via
>>> firmware/service events.
>>>
>>> This is a privileged s390x instruction that must be intercepted by
>>> SIE. Userspace handles the instruction as well as migration. Data
>>> is communicated via VCPU register synchronization.
>>>
>>> The Control Program Name Code (CPNC) is stored in the SIE block. The
>>> CPNC along with the Control Program Version Code (CPVC) are stored
>>> in the kvm_vcpu_arch struct.
>>>
>>> The CPNC is shadowed/unshadowed in VSIE.
>>>
>>
>> [...]
>>
>>>  
>>>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>>> @@ -4194,6 +4198,10 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>>  		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
>>>  			kvm_clear_async_pf_completion_queue(vcpu);
>>>  	}
>>> +	if (kvm_run->kvm_dirty_regs & KVM_SYNC_DIAG318) {
>>> +		vcpu->arch.diag318_info.val = kvm_run->s.regs.diag318;
>>> +		vcpu->arch.sie_block->cpnc = vcpu->arch.diag318_info.cpnc;
>>> +	}
>>>  	/*
>>>  	 * If userspace sets the riccb (e.g. after migration) to a valid state,
>>>  	 * we should enable RI here instead of doing the lazy enablement.
>>> @@ -4295,6 +4303,7 @@ static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>>  	kvm_run->s.regs.pp = vcpu->arch.sie_block->pp;
>>>  	kvm_run->s.regs.gbea = vcpu->arch.sie_block->gbea;
>>>  	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
>>> +	kvm_run->s.regs.diag318 = vcpu->arch.diag318_info.val;
>>>  	if (MACHINE_HAS_GS) {
>>>  		__ctl_set_bit(2, 4);
>>>  		if (vcpu->arch.gs_enabled)
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index 9e9056cebfcf..ba83d0568bc7 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -423,6 +423,8 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>  		break;
>>>  	}
>>>  
>>> +	scb_o->cpnc = scb_s->cpnc;
>>
>> "This is a privileged s390x instruction that must be intercepted", how
>> can the cpnc change, then, while in SIE?
>>
>> Apart from that LGTM.
>>
> 
> I thought shadow/unshadow was a load/store (respectively) when executing
> in SIE for a level 3+ guest (where LPAR is level 1)?
> 
> * Shadow SCB (load shadow VSIE page; originally CPNC is 0)

1. Here, you copy the cpnc from the pinned (original) SCB to the shadow SCB.

> 
> * Execute diag318 (under SIE)

2. Here the SIE runs using the shadow SCB.

> 
> * Unshadow SCB (store in original VSIE page; CPNC is whatever code the
> guest decided to set)

3. Here you copy back the cpnc from the shadow SCB to the pinned
(original) SCB.


If 2. cannot modify the cpnc residing in the shadow SCB, 3. can be
dropped, because the values will always match.


If guest3 tries to modify the cpnc (via diag 318), we exit the SIE
(intercept) in 2., return to our guest 2. guest 2 will perform the
change and adapt the original SCB.

(yep, it's confusing)

Or did I miss anything?

-- 
Thanks,

David / dhildenb

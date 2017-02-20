From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: add kvm_arch_cpu_kick
Date: Mon, 20 Feb 2017 21:59:42 +0100
Message-ID: <20170220205941.GA3744@potion>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
 <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
 <20170217151227.GA27770@potion>
 <e55d4aba-6c0b-f188-1632-d7293c857deb@de.ibm.com>
 <b1df82b4-dc77-d152-ca0a-c97741df20dd@redhat.com>
 <6f3d1415-b337-ecff-e56a-02017ea44658@de.ibm.com>
 <71af37f1-c465-f2aa-ad78-ed0acf103c13@redhat.com>
 <f76e2e51-aca0-b95d-9c80-5354d63a270a@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f76e2e51-aca0-b95d-9c80-5354d63a270a@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2017-02-20 12:12+0100, Christian Borntraeger:
> On 02/17/2017 06:10 PM, David Hildenbrand wrote:
>> 
>>>> Yes, it would.  There's some parallel with QEMU's qemu_cpu_kick, where
>>>> the signal would be processed immediately after entering KVM_RUN.
>>>
>>> Something like 
>>>
>>> ---snip-----
>>>         struct kvm_s390_sie_block *scb = READ_ONCE(vcpu->arch.vsie_block);
>>>
>>> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
>>>         if (scb)
>>> 		atomic_or(CPUSTAT_STOP_INT, &scb->cpuflags);
>>> ---snip-----
>>>
>>> or 
>>> ---snip-----
>>> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
>>> 	kvm_s390_vsie_kick(vcpu);
>>> ---snip-----
>> 
>> I'd go for the latter one. Keep the vsie stuff isolated. Please note
> 
> Yes makes sense.
> 
> Radim, if you go with this patch something like this can be used as the
> s390 variant of kvm_arch_cpu_kick:
> 
> ---snip---
> 	/*
> 	 * The stop indication is reset in the interrupt code. As the CPU
> 	 * loop handles requests after interrupts, we will
> 	 * a: miss the request handler and enter the guest, but then the
> 	 * stop request will exit the CPU and handle the request in the next
> 	 * round or
> 	 * b: handle the request directly before entering the guest
> 	 */
> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
> 	kvm_s390_vsie_kick(vcpu);
> 
> ---snip---
> feel free to add that to your patch. I can also send a fixup patch later
> on if you prefer that.

I'll probably use it.  Just looking at the hunk made me realize that the
interface will need to pass the vcpu as well, so I'd be best to have the
whole picture.

Thanks.

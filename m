From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: add kvm_arch_cpu_kick
Date: Fri, 17 Feb 2017 18:10:12 +0100
Message-ID: <71af37f1-c465-f2aa-ad78-ed0acf103c13@redhat.com>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
 <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
 <20170217151227.GA27770@potion>
 <e55d4aba-6c0b-f188-1632-d7293c857deb@de.ibm.com>
 <b1df82b4-dc77-d152-ca0a-c97741df20dd@redhat.com>
 <6f3d1415-b337-ecff-e56a-02017ea44658@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <6f3d1415-b337-ecff-e56a-02017ea44658@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


>> Yes, it would.  There's some parallel with QEMU's qemu_cpu_kick, where
>> the signal would be processed immediately after entering KVM_RUN.
> 
> Something like 
> 
> ---snip-----
>         struct kvm_s390_sie_block *scb = READ_ONCE(vcpu->arch.vsie_block);
> 
> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
>         if (scb)
> 		atomic_or(CPUSTAT_STOP_INT, &scb->cpuflags);
> ---snip-----
> 
> or 
> ---snip-----
> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
> 	kvm_s390_vsie_kick(vcpu);
> ---snip-----

I'd go for the latter one. Keep the vsie stuff isolated. Please note
that the vsie loop currently doesn't look for vcpu->requests yet. (I
left it out because its just racy either way and all current requests
don't require to be processes immediately - and it doesn't harm).

> 
> should be enough then. The code will either delete that stop request when
> processing interrupts, but then the requests will be handled afterwards,
> or we enter the guest once, exit and process then the requests in the next
> loop iteration.

-- 
Thanks,

David

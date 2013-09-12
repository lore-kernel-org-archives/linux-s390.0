From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/8] KVM: s390: Split up __vcpu_run into three parts
Date: Thu, 12 Sep 2013 11:09:45 +0200
Message-ID: <523184D9.5070304@de.ibm.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com> <1378974829-46578-3-git-send-email-borntraeger@de.ibm.com> <52318277.6010200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52318277.6010200@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 12/09/13 10:59, Paolo Bonzini wrote:
> Il 12/09/2013 10:33, Christian Borntraeger ha scritto:
>>  
>>  	vcpu->arch.sie_block->icptcode = 0;
>> -	VCPU_EVENT(vcpu, 6, "entering sie flags %x",
>> -		   atomic_read(&vcpu->arch.sie_block->cpuflags));
>> -	trace_kvm_s390_sie_enter(vcpu,
>> -				 atomic_read(&vcpu->arch.sie_block->cpuflags));
>> +	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
>> +	VCPU_EVENT(vcpu, 6, "entering sie flags %x", cpuflags);
>> +	trace_kvm_s390_sie_enter(vcpu, cpuflags);
> 
> I don't have this VCPU_EVENT in kvm/queue, it is after preempt_enable:

Huh? This was moved with

commit 2b29a9fdcb92bfc6b6f4c412d71505869de61a56
Author: Dominik Dingel <dingel@linux.vnet.ibm.com>
Date:   Fri Jul 26 15:04:00 2013 +0200

    KVM: s390: move kvm_guest_enter,exit closer to sie


which is clearly in kvm/qeue:

https://git.kernel.org/cgit/virt/kvm/kvm.git/tree/arch/s390/kvm/kvm-s390.c?h=queue


--- snip---
	vcpu->arch.sie_block->icptcode = 0;
	VCPU_EVENT(vcpu, 6, "entering sie flags %x",
		   atomic_read(&vcpu->arch.sie_block->cpuflags));
	trace_kvm_s390_sie_enter(vcpu,
				 atomic_read(&vcpu->arch.sie_block->cpuflags));

	/*
	 * As PF_VCPU will be used in fault handler, between guest_enter
	 * and guest_exit should be no uaccess.
	 */
	preempt_disable();
	kvm_guest_enter();
	preempt_enable();
	rc = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
	kvm_guest_exit();

	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
		   vcpu->arch.sie_block->icptcode);
	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
--- snip---


> 
>         vcpu->arch.sie_block->icptcode = 0;
>         preempt_disable();
>         kvm_guest_enter();
>         preempt_enable();
>         VCPU_EVENT(vcpu, 6, "entering sie flags %x",
>                    atomic_read(&vcpu->arch.sie_block->cpuflags));
>         trace_kvm_s390_sie_enter(vcpu,
>                                  atomic_read(&vcpu->arch.sie_block->cpuflags));
>         rc = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
> 
> Patch missing?  Perhaps you should send a pull request instead as soon as
> 3.12-rc1 comes out.

For future patches, yes. I will go out for a kernel.org account, but it will certainly
take some time.

Christian

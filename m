From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/8] KVM: s390: Split up __vcpu_run into three parts
Date: Thu, 12 Sep 2013 10:59:35 +0200
Message-ID: <52318277.6010200@redhat.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com> <1378974829-46578-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1378974829-46578-3-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 12/09/2013 10:33, Christian Borntraeger ha scritto:
>  
>  	vcpu->arch.sie_block->icptcode = 0;
> -	VCPU_EVENT(vcpu, 6, "entering sie flags %x",
> -		   atomic_read(&vcpu->arch.sie_block->cpuflags));
> -	trace_kvm_s390_sie_enter(vcpu,
> -				 atomic_read(&vcpu->arch.sie_block->cpuflags));
> +	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
> +	VCPU_EVENT(vcpu, 6, "entering sie flags %x", cpuflags);
> +	trace_kvm_s390_sie_enter(vcpu, cpuflags);

I don't have this VCPU_EVENT in kvm/queue, it is after preempt_enable:

        vcpu->arch.sie_block->icptcode = 0;
        preempt_disable();
        kvm_guest_enter();
        preempt_enable();
        VCPU_EVENT(vcpu, 6, "entering sie flags %x",
                   atomic_read(&vcpu->arch.sie_block->cpuflags));
        trace_kvm_s390_sie_enter(vcpu,
                                 atomic_read(&vcpu->arch.sie_block->cpuflags));
        rc = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);

Patch missing?  Perhaps you should send a pull request instead as soon as
3.12-rc1 comes out.

Paolo

From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 4/5] s390x/kvm: test whether a cpu is
 STOPPED when checking "has_work"
Date: Thu, 31 Jul 2014 09:45:01 +0200
Message-ID: <20140731094501.31d8a047@thinkpad-w530>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
	<1404997839-29038-5-git-send-email-borntraeger@de.ibm.com>
	<53D654D2.40308@suse.de>
	<20140728161644.00c09b3f@thinkpad-w530>
	<2B39547D-B9A3-4509-808C-B0808067ED54@suse.de>
	<53D78937.3010307@de.ibm.com>
	<53D78A44.1060706@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53D78A44.1060706@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> > We have
> > - wait (wait bit in PSW)
> > - disabled wait (wait bit and interrupt fencing in PSW)
> > - STOPPED (not related to PSW, state change usually handled via service processor or hypervisor)
> >
> > I think we have to differentiate between KVM/TCG. On KVM we always do in kernel halt and qemu sees a halted only for STOPPED or disabled wait. TCG has to take care of the normal wait as well.
> >
> >  From a first glimpse, a disabled wait and STOPPED look similar, but there are (important) differences, e.g. other CPUs get a different a different result from a SIGP SENSE. This makes a big difference, e.g. for Linux guests, that send a SIGP STOP, followed by a SIGP SENSE loop until the CPU is down on hotplug (and shutdown, kexec..) So I think we agree, that handling the cpu states natively makes sense.
> >
> > The question is now only how to model it correctly without breaking TCG/KVM and reuse as much common code as possible. Correct?
> >
> > Do I understand you correctly, that your collapsing of stopped and halted is only in the qemu coding sense, IOW maybe we could just modify kvm_arch_process_async_events to consider the STOPPED state, as TCGs sigp implementation does not support SMP anyway?
> 
> That works for me, yes.
> 
> 
> Alex
> 

I had a look at it yesterday and it seems like we can totally drop this patch:

1. TCG doesn't support multiple CPUs and the TCG SIGP implementation isn't
ready for proper STOP/START/SENSE. Testing for STOPPED cpus in cpu_has_work()
can be dropped. To be able to support TCG was the main reason for this patch -
as we don't want to do so for now, we can leave it as is. We can still decide
to support the cpu states later using a mechanism suggest by Alex
(interrupt_requests).

Even if cpu_has_work() would make cpu.c:cpu_thread_is_idle() return false,
kvm_arch_process_async_events() called by kvm-all.c:kvm_cpu_exec() would make
it go back to sleep. Therefore a stopped VCPU will never be able to run in the
KVM case (because it always has cs->halted = true).

2. The unhalt in kvm_arch_process_async_events is for a special case where a
VCPU is in disabled wait and receives e.g. a machine-check interrupt. These
might happen in the future, for now we will never see them (the only
way to get a vcpu out of disabled wait are SIGP RESTART/CPU RESET - so we
don't break anything at that point).

David

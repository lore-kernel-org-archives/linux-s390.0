From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH/RFC 2/3] s390/kvm: Platform specific kvm_arch_vcpu_dont_yield
Date: Fri, 14 Feb 2014 10:56:15 +0100
Message-ID: <52FDE83F.3050607@redhat.com>
References: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com> <1392119132-50182-3-git-send-email-borntraeger@de.ibm.com> <52FD4913.3000107@redhat.com> <52FD4D17.10307@de.ibm.com> <52FD5608.2050808@redhat.com> <52FDE813.5050809@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52FDE813.5050809@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 14/02/2014 10:55, Christian Borntraeger ha scritto:
> OK.
> Michael can you rework the series to simply use
> " if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu)" in kvm_vcpu_on_spin
>
> and make kvm_arch_vcpu_runnable  kvm_cpu_has_interrupt(vcpu) in s390 code?
> That should be equivalent for s390 with even simpler code.
> It might also help x86 and others.

Exactly my point. ;)

Paolo

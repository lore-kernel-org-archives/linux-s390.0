From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 2/3] s390/kvm: Platform specific kvm_arch_vcpu_dont_yield
Date: Fri, 14 Feb 2014 10:55:31 +0100
Message-ID: <52FDE813.5050809@de.ibm.com>
References: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com> <1392119132-50182-3-git-send-email-borntraeger@de.ibm.com> <52FD4913.3000107@redhat.com> <52FD4D17.10307@de.ibm.com> <52FD5608.2050808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52FD5608.2050808@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 14/02/14 00:32, Paolo Bonzini wrote:
> Il 13/02/2014 23:54, Christian Borntraeger ha scritto:
>> We had several variants but in the end we tried to come up with a patch that does not
>> influence other architectures. Your proposal would certainly be fine for s390,
>> but what impact does it have on x86, arm, arm64? Will it cause performance regressions?
> 
> It may also have the same advantages you got on s390.
> 
>> So I think that the patch as is is probably the safest choice until we have some
>> data from x86, arm, arm64, no?
> 
> No, using an existing API is always better than inventing a new one.

OK. 
Michael can you rework the series to simply use 
" if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu)" in kvm_vcpu_on_spin

and make kvm_arch_vcpu_runnable  kvm_cpu_has_interrupt(vcpu) in s390 code?
That should be equivalent for s390 with even simpler code.
It might also help x86 and others.


> If you post the new patch series, and describe the benchmark you were using, we can reproduce it on x86.

The benchmark was some workload doing lots of semaphore up/down with hundreds
of processes. Will see if I can come up with a minimal test.

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC V3 2/3] kvm: Note down when cpu relax intercepted
 or pause loop exited
Date: Fri, 13 Jul 2012 08:13:46 +0200
Message-ID: <4FFFBC9A.6080107@de.ibm.com>
References: <20120712191712.30440.68944.sendpatchset@codeblue> <20120712191800.30440.16406.sendpatchset@codeblue> <4FFF2D5F.3050902@de.ibm.com> <4FFF979F.8070100@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFF979F.8070100@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 13/07/12 05:35, Raghavendra K T wrote:
> Yes! I forgot about archs in init function.
> How about having
> #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
> vcpu->ple.cpu_relax_intercepted = false;
> vcpu->ple.dy_eligible = false;
> #endif
> 
> This would solve all the problem.

No, you need to mask all places....

> 
>>>
>>>       r = kvm_arch_vcpu_init(vcpu);
>>>       if (r<  0)
>>> @@ -1577,6 +1579,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>>>       int pass;
>>>       int i;
>>>
>>> +    me->ple.cpu_relax_intercepted = true;
>>
>> dito
> 
> currently vcpu_on_spin is used only by x86 and s390. so if some other
> arch in future uses vcpu_on_spin, I believe they also have to enable
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
> what do you think?

...because  this function is compiled no matter if called or not.
> 
>> maybe define static inline access functions in kvm_host.h that are no-ops
>> if CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT is not set.

As I already said, can you have a look at using access functions?

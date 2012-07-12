From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC V3 2/3] kvm: Note down when cpu relax intercepted
 or pause loop exited
Date: Thu, 12 Jul 2012 22:02:39 +0200
Message-ID: <4FFF2D5F.3050902@de.ibm.com>
References: <20120712191712.30440.68944.sendpatchset@codeblue> <20120712191800.30440.16406.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120712191800.30440.16406.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 12/07/12 21:18, Raghavendra K T wrote:
> +#ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
[...]
> +	struct {
> +		bool cpu_relax_intercepted;
> +		bool dy_eligible;
> +	} ple;
> +#endif
[...]
>  	}
>  	vcpu->run = page_address(page);
> +	vcpu->ple.cpu_relax_intercepted = false;
> +	vcpu->ple.dy_eligible = false;

This struct is only defined if CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT is set, but here it
is always accessed. Will break on !x86 && !s390.
> 
>  	r = kvm_arch_vcpu_init(vcpu);
>  	if (r < 0)
> @@ -1577,6 +1579,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>  	int pass;
>  	int i;
> 
> +	me->ple.cpu_relax_intercepted = true;

dito
>  	/*
>  	 * We boost the priority of a VCPU that is runnable but not
>  	 * currently running, because it got preempted by something
> @@ -1602,6 +1605,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>  			}
>  		}
>  	}
> +	me->ple.cpu_relax_intercepted = false;

again.

maybe define static inline access functions in kvm_host.h that are no-ops
if CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT is not set.

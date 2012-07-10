From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RFC V2 2/2] kvm PLE handler: Choose better candidate for
 directed yield
Date: Tue, 10 Jul 2012 22:50:18 +0200
Message-ID: <20120710205018.GB16986@gmail.com>
References: <20120710193056.16440.40112.sendpatchset@codeblue>
 <20120710193138.16440.31791.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120710193138.16440.31791.sendpatchset@codeblue>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>


* Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:

> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1595,6 +1595,9 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>  				continue;
>  			if (waitqueue_active(&vcpu->wq))
>  				continue;
> +			if (!kvm_arch_vcpu_check_and_update_eligible(vcpu)) {
> +				continue;
> +			}

Saw this fly by for a second time and now it annoyed me enough 
to mention it: those curly braces are superfluous and should be 
dropped.

Thanks,

	Ingo

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V3 2/3] kvm: Note down when cpu relax intercepted or
 pause loop exited
Date: Fri, 13 Jul 2012 19:24:26 +0530
Message-ID: <20120713135426.GA5208@linux.vnet.ibm.com>
References: <20120712191712.30440.68944.sendpatchset@codeblue>
 <20120712191800.30440.16406.sendpatchset@codeblue>
 <4FFF2D5F.3050902@de.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FFF2D5F.3050902@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

> On 12/07/12 21:18, Raghavendra K T wrote:
> > +#ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
> [...]
> > +	struct {
> > +		bool cpu_relax_intercepted;
> > +		bool dy_eligible;
> > +	} ple;
> > +#endif
> [...]
> >  	}
> >  	vcpu->run = page_address(page);
> > +	vcpu->ple.cpu_relax_intercepted = false;
> > +	vcpu->ple.dy_eligible = false;
> 
> This struct is only defined if CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT is set, but here it
> is always accessed. Will break on !x86 && !s390.

How about moving this struct definition outside the CONFIG.
i.e it would be available by default.
If any arch cares to use vcpu_on_spin(), they would get the benefit by
default. 

This would avoid all the CONFIG magic that we would have to do
otherwise.

-- 
Thanks and Regards
Srikar

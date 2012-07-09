From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH RFC 2/2] kvm PLE handler: Choose better candidate for
 directed yield
Date: Mon, 09 Jul 2012 18:30:25 -0400
Message-ID: <4FFB5B81.4040903@redhat.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <20120709062053.24030.52767.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120709062053.24030.52767.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2012 02:20 AM, Raghavendra K T wrote:

> +bool kvm_arch_vcpu_check_and_update_eligible(struct kvm_vcpu *vcpu)
> +{
> +	bool eligible;
> +
> +	eligible = !vcpu->arch.plo.pause_loop_exited ||
> +			(vcpu->arch.plo.pause_loop_exited&&
> +			 vcpu->arch.plo.dy_eligible);
> +
> +	if (vcpu->arch.plo.pause_loop_exited)
> +		vcpu->arch.plo.dy_eligible = !vcpu->arch.plo.dy_eligible;
> +
> +	return eligible;
> +}

This is a nice simple mechanism to skip CPUs that were
eligible last time and had pause loop exits recently.

However, it could stand some documentation.  Please
add a good comment explaining how and why the algorithm
works, when arch.plo.pause_loop_exited is cleared, etc...

It would be good to make this heuristic understandable
to people who look at the code for the first time.

-- 
All rights reversed

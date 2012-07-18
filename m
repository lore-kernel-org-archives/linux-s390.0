From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V5 3/3] kvm: Choose better candidate for directed
 yield
Date: Wed, 18 Jul 2012 20:09:04 +0530
Message-ID: <5006CA88.8040906@linux.vnet.ibm.com>
References: <20120718133717.5321.71347.sendpatchset@codeblue.in.ibm.com> <20120718133800.5321.51446.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20120718133800.5321.51446.sendpatchset@codeblue.in.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>, Srikar <srikar@linux.vnet.ibm.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/18/2012 07:08 PM, Raghavendra K T wrote:
> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
> +bool kvm_vcpu_eligible_for_directed_yield(struct kvm_vcpu *vcpu)
> +{
> +	bool eligible;
> +
> +	eligible = !vcpu->spin_loop.in_spin_loop ||
> +			(vcpu->spin_loop.in_spin_loop&&
> +			 vcpu->spin_loop.dy_eligible);
> +
> +	if (vcpu->spin_loop.in_spin_loop)
> +		vcpu->spin_loop.dy_eligible = !vcpu->spin_loop.dy_eligible;
> +
> +	return eligible;
> +}

I should have added a comment like:
Since algorithm is based on heuristics, accessing another vcpu data
without locking does not harm. It may result in trying to yield to  same 
VCPU, fail and continue with next and so on.

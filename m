From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC 1/2] kvm vcpu: Note down pause loop exit
Date: Wed, 11 Jul 2012 11:53:36 +0300
Message-ID: <4FFD3F10.5020900@redhat.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <20120709062032.24030.10454.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120709062032.24030.10454.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2012 09:20 AM, Raghavendra K T wrote:
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> 
> Noting pause loop exited vcpu helps in filtering right candidate to yield.
> Yielding to same vcpu may result in more wastage of cpu.
> 
>  
>  struct kvm_lpage_info {
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f75af40..a492f5d 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -3264,6 +3264,7 @@ static int interrupt_window_interception(struct vcpu_svm *svm)
>  
>  static int pause_interception(struct vcpu_svm *svm)
>  {
> +	svm->vcpu.arch.plo.pause_loop_exited = true;
>  	kvm_vcpu_on_spin(&(svm->vcpu));
>  	return 1;
>  }
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 32eb588..600fb3c 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4945,6 +4945,7 @@ out:
>  static int handle_pause(struct kvm_vcpu *vcpu)
>  {
>  	skip_emulated_instruction(vcpu);
> +	vcpu->arch.plo.pause_loop_exited = true;
>  	kvm_vcpu_on_spin(vcpu);
>  

This code is duplicated.  Should we move it to kvm_vcpu_on_spin?

That means the .plo structure needs to be in common code, but that's not
too bad perhaps.

> index be6d549..07dbd14 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5331,7 +5331,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  
>  	if (req_immediate_exit)
>  		smp_send_reschedule(vcpu->cpu);
> -
> +	vcpu->arch.plo.pause_loop_exited = false;

This adds some tiny overhead to vcpu entry.  You could remove it by
using the vcpu->requests mechanism to clear the flag, since
vcpu->requests is already checked on every entry.

>  	kvm_guest_enter();
>  

-- 
error compiling committee.c: too many arguments to function

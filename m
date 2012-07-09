From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH RFC 1/2] kvm vcpu: Note down pause loop exit
Date: Mon, 09 Jul 2012 18:39:10 -0400
Message-ID: <4FFB5D8E.70402@redhat.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <20120709062032.24030.10454.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120709062032.24030.10454.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2012 02:20 AM, Raghavendra K T wrote:

> @@ -484,6 +484,13 @@ struct kvm_vcpu_arch {
>   		u64 length;
>   		u64 status;
>   	} osvw;
> +
> +	/* Pause loop exit optimization */
> +	struct {
> +		bool pause_loop_exited;
> +		bool dy_eligible;
> +	} plo;

I know kvm_vcpu_arch is traditionally not a well documented
structure, but it would be really nice if each variable inside
this sub-structure could get some documentation.

Also, do we really want to introduce another acronym here?

Or would we be better off simply calling this struct .ple,
since that is a name people are already familiar with.

-- 
All rights reversed

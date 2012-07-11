From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC 0/2] kvm: Improving directed yield in PLE handler
Date: Wed, 11 Jul 2012 12:06:51 +0300
Message-ID: <4FFD422B.9060008@redhat.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <4FFA8E5E.3070108@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFA8E5E.3070108@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2012 10:55 AM, Christian Borntraeger wrote:
> On 09/07/12 08:20, Raghavendra K T wrote:
>> Currently Pause Looop Exit (PLE) handler is doing directed yield to a
>> random VCPU on PL exit. Though we already have filtering while choosing
>> the candidate to yield_to, we can do better.
>> 
>> Problem is, for large vcpu guests, we have more probability of yielding
>> to a bad vcpu. We are not able to prevent directed yield to same guy who
>> has done PL exit recently, who perhaps spins again and wastes CPU.
>> 
>> Fix that by keeping track of who has done PL exit. So The Algorithm in series
>> give chance to a VCPU which has:
> 
> 
> We could do the same for s390. The appropriate exit would be diag44 (yield to hypervisor).
> 
> Almost all s390 kernels use diag9c (directed yield to a given guest cpu) for spinlocks, though.

Perhaps x86 should copy this.

> So there is no win here, but there are other cases were diag44 is used, e.g. cpu_relax.
> I have to double check with others, if these cases are critical, but for now, it seems 
> that your dummy implementation  for s390 is just fine. After all it is a no-op until 
> we implement something.

Does the data structure make sense for you?  If so we can move it to
common code (and manage it in kvm_vcpu_on_spin()).  We can guard it with
CONFIG_KVM_HAVE_CPU_RELAX_INTERCEPT or something, so other archs don't
have to pay anything.

-- 
error compiling committee.c: too many arguments to function

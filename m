From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 3/3] kvm: Choose better candidate for directed
 yield
Date: Wed, 18 Jul 2012 07:58:05 +0530
Message-ID: <50061F35.4050305@linux.vnet.ibm.com>
References: <20120716082445.23477.15128.sendpatchset@codeblue.in.ibm.com> <20120716082529.23477.91096.sendpatchset@codeblue.in.ibm.com> <5003E7ED.2030701@redhat.com> <50043CF3.8020903@redhat.com> <50052272.5020803@redhat.com> <50052BB5.2040909@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <50052BB5.2040909@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Srikar <srikar@linux.vnet.ibm.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/17/2012 02:39 PM, Raghavendra K T wrote:
[...]
>
> But
>> if vcpu A is spinning for x% of its time and processing on the other,
>> then vcpu B will flip its dy_eligible for those x%, and not flip it when
>> it's processing. I don't understand how this is useful.
>
> Suppose A is doing really good job and and has not done pause loop
> exit, we will not touch it's dy_eligible flag. Also dy_eligible flag
> will not prevent B doing yield_to to A.
>
> Suppose A has started spinning in the beginning itself, it will do pause
> loop exit if it crosses threshold, and we will now start toggling
> dy_eligible.
>
> Was that you were referring?
>
> And it seems we may still have to set dy_eligible flag to false at the
> beginning of vcpu_on_spin along with cpu_relax_intercepted = true, like
> below, so that we do not have spill-over status from previous PL exits.
>
> vcpu_on_spin()
> {
> cpu_relax_intercepted = true;
> dy_eligible = false;
> .
> .
> .
>
> cpu_relax_intercepted = false;
> }
>
> Let me know if that addresses your concern.
>

Thought you brought in is miraculous. taking care of not having 
spill-over dy_eligible status is needed for making algorithm technically 
more correct. will spin V5 with all these changes.

>>
>> I guess this is an attempt to impose fairness on yielding, and it makes
>> sense to do this, but I don't know if this is the best way to achieve it.
>>
>

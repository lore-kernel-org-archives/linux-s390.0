From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 3/3] kvm: Choose better candidate for directed
 yield
Date: Mon, 16 Jul 2012 23:19:12 +0530
Message-ID: <50045418.9070805@linux.vnet.ibm.com>
References: <20120716082445.23477.15128.sendpatchset@codeblue.in.ibm.com> <20120716082529.23477.91096.sendpatchset@codeblue.in.ibm.com> <5003E7ED.2030701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5003E7ED.2030701@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>, Srikar <srikar@linux.vnet.ibm.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/16/2012 03:37 PM, Avi Kivity wrote:
> On 07/16/2012 11:25 AM, Raghavendra K T wrote:
>> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>>
>> Currently, on a large vcpu guests, there is a high probability of
>> yielding to the same vcpu who had recently done a pause-loop exit or
>> cpu relax intercepted. Such a yield can lead to the vcpu spinning
>> again and hence degrade the performance.
>>
>> The patchset keeps track of the pause loop exit/cpu relax interception
>> and gives chance to a vcpu which:
>>   (a) Has not done pause loop exit or cpu relax intercepted at all
>>       (probably he is preempted lock-holder)
>>   (b) Was skipped in last iteration because it did pause loop exit or
>>       cpu relax intercepted, and probably has become eligible now
>>       (next eligible lock holder)
>>
>
>>
>> +#ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
>> +/*
>> + * Helper that checks whether a VCPU is eligible for directed yield.
>> + * Most eligible candidate to yield is decided by following heuristics:
>> + *
>> + *  (a) VCPU which has not done pl-exit or cpu relax intercepted recently
>> + *  (preempted lock holder), indicated by @cpu_relax_intercepted.
>> + *  Set at the beiginning and cleared at the end of interception/PLE handler.
>> + *
>> + *  (b) VCPU which has done pl-exit/ cpu relax intercepted but did not get
>> + *  chance last time (mostly it has become eligible now since we have probably
>> + *  yielded to lockholder in last iteration. This is done by toggling
>> + *  @dy_eligible each time a VCPU checked for eligibility.)
>> + *
>> + *  Yielding to a recently pl-exited/cpu relax intercepted VCPU before yielding
>> + *  to preempted lock-holder could result in wrong VCPU selection and CPU
>> + *  burning. Giving priority for a potential lock-holder increases lock
>> + *  progress.
>> + */
>> +bool kvm_vcpu_check_and_update_eligible(struct kvm_vcpu *vcpu)
>
> Predicates' names should give a hint as to what true and false returns
> mean.  For example vcpu_eligible_for_directed_yield().
>

I agree regarding the Predicate name. My confusion was it was
doing more than that (flipping eligible flag).
So, I  ll go with kvm_vcpu_eligible_for_directed_yield()

>> +{
[...]
>> +	return eligible;
>> +}
>
> You're accessing another vcpu's data structures without any locking.
> This is probably okay since we're not basing any life or death decisions
> on this, but a comment would be good to explain to readers that this has
> been considered and is okay (and why).
>
>

True and agree. What we doing here is not worth of locking overhead.
will try to explain more on that.

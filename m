From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V4 3/3] kvm: Choose better candidate for directed
 yield
Date: Tue, 17 Jul 2012 11:29:38 +0300
Message-ID: <50052272.5020803@redhat.com>
References: <20120716082445.23477.15128.sendpatchset@codeblue.in.ibm.com> <20120716082529.23477.91096.sendpatchset@codeblue.in.ibm.com> <5003E7ED.2030701@redhat.com> <50043CF3.8020903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50043CF3.8020903@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Rik van Riel <riel@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Srikar <srikar@linux.vnet.ibm.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/16/2012 07:10 PM, Rik van Riel wrote:
> On 07/16/2012 06:07 AM, Avi Kivity wrote:
> 
>>> +{
>>> +    bool eligible;
>>> +
>>> +    eligible = !vcpu->ple.cpu_relax_intercepted ||
>>> +            (vcpu->ple.cpu_relax_intercepted&&
>>> +             vcpu->ple.dy_eligible);
>>> +
>>> +    if (vcpu->ple.cpu_relax_intercepted)
>>> +        vcpu->ple.dy_eligible = !vcpu->ple.dy_eligible;
>>
>> Probably should assign 'true', since the previous value is essentially
>> random.
> 
> I suspect the intended purpose of this conditional is to
> flip the eligibility of a vcpu for being selected as a
> direct yield target.
> 
> In other words, that bit of the code is correct.

If vcpu A is in a long spin loop and is preempted away, and vcpu B dips
several times in kvm_vcpu_on_spin(), then it will act as intended.  But
if vcpu A is spinning for x% of its time and processing on the other,
then vcpu B will flip its dy_eligible for those x%, and not flip it when
it's processing.  I don't understand how this is useful.

I guess this is an attempt to impose fairness on yielding, and it makes
sense to do this, but I don't know if this is the best way to achieve it.

-- 
error compiling committee.c: too many arguments to function

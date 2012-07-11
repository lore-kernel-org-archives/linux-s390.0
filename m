From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 0/2] kvm: Improving directed yield in PLE handler
Date: Wed, 11 Jul 2012 18:34:34 +0530
Message-ID: <4FFD79E2.3080307@linux.vnet.ibm.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <4FFA8E5E.3070108@de.ibm.com> <4FFD422B.9060008@redhat.com> <4FFD52CD.7040403@de.ibm.com> <4FFD68AA.1000607@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4FFD68AA.1000607@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/11/2012 05:21 PM, Raghavendra K T wrote:
> On 07/11/2012 03:47 PM, Christian Borntraeger wrote:
>> On 11/07/12 11:06, Avi Kivity wrote:
[...]
>>>> So there is no win here, but there are other cases were diag44 is
>>>> used, e.g. cpu_relax.
>>>> I have to double check with others, if these cases are critical, but
>>>> for now, it seems
>>>> that your dummy implementation for s390 is just fine. After all it
>>>> is a no-op until
>>>> we implement something.
>>>
>>> Does the data structure make sense for you? If so we can move it to
>>> common code (and manage it in kvm_vcpu_on_spin()). We can guard it with
>>> CONFIG_KVM_HAVE_CPU_RELAX_INTERCEPT or something, so other archs don't
>>> have to pay anything.
>>
>> Ignoring the name, yes the data structure itself seems based on the
>> algorithm
>> and not on arch specific things. That should work.
>
> Ok. can you please elaborate, on the flow.
>

Ok got it..  Will check how the code can be common to both x86 and s390.

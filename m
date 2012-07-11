From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC 0/2] kvm: Improving directed yield in PLE handler
Date: Wed, 11 Jul 2012 13:55:33 +0200
Message-ID: <4FFD69B5.9000401@de.ibm.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <4FFA8E5E.3070108@de.ibm.com> <4FFD422B.9060008@redhat.com> <4FFD52CD.7040403@de.ibm.com> <4FFD68AA.1000607@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFD68AA.1000607@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 11/07/12 13:51, Raghavendra K T wrote:
>>>> Almost all s390 kernels use diag9c (directed yield to a given guest cpu) for spinlocks, though.
>>>
>>> Perhaps x86 should copy this.
>>
>> See arch/s390/lib/spinlock.c
>> The basic idea is using several heuristics:
>> - loop for a given amount of loops
>> - check if the lock holder is currently scheduled by the hypervisor
>>    (smp_vcpu_scheduled, which uses the sigp sense running instruction)
>>    Dont know if such thing is available for x86. It must be a lot cheaper
>>    than a guest exit to be useful
> 
> Unfortunately we do not have information on lock-holder.

That would be an independent patch and requires guest changes.

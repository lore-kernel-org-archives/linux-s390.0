From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V3 0/3] kvm: Improving directed yield in PLE handler
Date: Fri, 13 Jul 2012 00:53:44 +0530
Message-ID: <4FFF2440.40807@linux.vnet.ibm.com>
References: <20120712191712.30440.68944.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120712191712.30440.68944.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/13/2012 12:47 AM, Raghavendra K T wrote:
> Currently Pause Loop Exit (PLE) handler is doing directed yield to a
> random vcpu on pl-exit. We already have filtering while choosing
> the candidate to yield_to. This change adds more checks while choosing
> a candidate to yield_to.
>
> On a large vcpu guests, there is a high probability of
> yielding to the same vcpu who had recently done a pause-loop exit.
> Such a yield can lead to the vcpu spinning again.
>
> The patchset keeps track of the pause loop exit and gives chance to a
> vcpu which has:
>
>   (a) Not done pause loop exit at all (probably he is preempted lock-holder)
>
>   (b) vcpu skipped in last iteration because it did pause loop exit, and
>   probably has become eligible now (next eligible lock holder)
>
> This concept also helps in cpu relax interception cases which use same handler.

The patches are tested on x86 only since I don't have access to s390
machine. Please let me know if changes are ok on s390.

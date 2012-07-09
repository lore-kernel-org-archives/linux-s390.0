From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH RFC 0/2] kvm: Improving directed yield in PLE handler
Date: Mon, 09 Jul 2012 18:28:03 -0400
Message-ID: <4FFB5AF3.4010805@redhat.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120709062012.24030.37154.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2012 02:20 AM, Raghavendra K T wrote:
> Currently Pause Looop Exit (PLE) handler is doing directed yield to a
> random VCPU on PL exit. Though we already have filtering while choosing
> the candidate to yield_to, we can do better.
>
> Problem is, for large vcpu guests, we have more probability of yielding
> to a bad vcpu. We are not able to prevent directed yield to same guy who
> has done PL exit recently, who perhaps spins again and wastes CPU.
>
> Fix that by keeping track of who has done PL exit. So The Algorithm in series
> give chance to a VCPU which has:
>
>   (a) Not done PLE exit at all (probably he is preempted lock-holder)
>
>   (b) VCPU skipped in last iteration because it did PL exit, and probably
>   has become eligible now (next eligible lock holder)
>
> Future enhancemnets:

Your patch series looks good to me. Simple changes with a
significant result.

However, the simple heuristic could use some comments :)

-- 
All rights reversed

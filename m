From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH RFC V2 2/2] kvm PLE handler: Choose better candidate for
 directed yield
Date: Tue, 10 Jul 2012 15:40:43 -0400
Message-ID: <4FFC853B.30900@redhat.com>
References: <20120710193056.16440.40112.sendpatchset@codeblue> <20120710193138.16440.31791.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120710193138.16440.31791.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/10/2012 03:31 PM, Raghavendra K T wrote:
> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>
> Currently PLE handler can repeatedly do a directed yield to same vcpu
> that has recently done PL exit. This can degrade the performance.
>
> Try to yield to most eligible guy instead by alternate yielding.
> Precisely, give chance to a VCPU which has:
>   (a) Not done PLE exit at all (probably he is preempted lock-holder)
>   (b) VCPU skipped in last iteration because it did PL exit, and probably
>   has become eligible now (next eligible lock holder)
>
> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed

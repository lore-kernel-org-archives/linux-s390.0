From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 1/2] kvm vcpu: Note down pause loop exit
Date: Mon, 09 Jul 2012 12:03:08 +0530
Message-ID: <4FFA7B24.9040900@linux.vnet.ibm.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <20120709062032.24030.10454.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120709062032.24030.10454.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2012 11:50 AM, Raghavendra K T wrote:
> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>
> Noting pause loop exited vcpu helps in filtering right candidate to yield.
> Yielding to same vcpu may result in more wastage of cpu.
>
> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
> ---

Oops. Sorry some how sign-off and from interchanged.. interchanged

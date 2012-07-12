From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RFC 0/2] kvm: Improving directed yield in PLE handler
Date: Thu, 12 Jul 2012 12:19:18 +1000
Message-ID: <1342059558.18850.48.camel@pasglop>
References: <20120709062012.24030.37154.sendpatchset@codeblue>
	 <4FFA8E5E.3070108@de.ibm.com> <4FFD422B.9060008@redhat.com>
	 <4FFD52CD.7040403@de.ibm.com> <4FFD5DA3.3010001@redhat.com>
	 <39DA3B9A-87D6-4EA5-B1FF-B6E30733EF7B@suse.de>
	 <4FFD621D.5090607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFD621D.5090607@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2012-07-11 at 14:23 +0300, Avi Kivity wrote:
> On 07/11/2012 02:16 PM, Alexander Graf wrote:
> >> 
> >>> yes the data structure itself seems based on the algorithm
> >>> and not on arch specific things. That should work. If we move that to common 
> >>> code then s390 will use that scheme automatically for the cases were we call 
> >>> kvm_vcpu_on_spin(). All others archs as well.
> >> 
> >> ARM doesn't have an instruction for cpu_relax(), so it can't intercept
> >> it.  Given ppc's dislike of overcommit,
> > 
> > What dislike of overcommit?
> 
> I understood ppc virtualization is more of the partitioning sort.
> Perhaps I misunderstood it.  But the reliance on device assignment, the
> restrictions on scheduling, etc. all point to it.

It historically was but that has changed quite a bit. Essentially the
user can configure partitions to be more of the "all virtualized" kind
or on the contrary more fixed partitions. The hypervisor does shared
processors and we have paravirt APIs to cede our time slice to the lock
holder. 

> >> and the way it implements cpu_relax() by adjusting hw thread priority,
> > 
> > Yeah, I don't think we can intercept relaxing.
> 
> ... and the lack of ability to intercept cpu_relax() ...
> 
> > It's basically a nop-like instruction that gives hardware hints on its current priorities.
> 
> That's what x88 PAUSE does.  But we can intercept it (and not just any
> execution - we can restrict intercept to tight loops executed more than
> a specific number of times).
> 
> > That said, we can always add PV code.
> 
> Sure, but that's defeated by advancements like self-tuning PLE exits.
> It's hard to get this right.
> 

Cheers,
Ben.

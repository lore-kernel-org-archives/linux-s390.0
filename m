From: Andrew Theurer <habanero@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 0/2] kvm: Improving directed yield in PLE handler
Date: Tue, 10 Jul 2012 08:27:29 -0500
Message-ID: <1341926849.2909.28.camel@oc2024037011.ibm.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue>
	 <1341870457.2909.27.camel@oc2024037011.ibm.com>
	 <4FFC17D8.5010108@linux.vnet.ibm.com>
Reply-To: habanero@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFC17D8.5010108@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2012-07-10 at 17:24 +0530, Raghavendra K T wrote:
> On 07/10/2012 03:17 AM, Andrew Theurer wrote:
> > On Mon, 2012-07-09 at 11:50 +0530, Raghavendra K T wrote:
> >> Currently Pause Looop Exit (PLE) handler is doing directed yield to a
> >> random VCPU on PL exit. Though we already have filtering while choosing
> >> the candidate to yield_to, we can do better.
> >
> > Hi, Raghu.
> >
> [...]
> >
> > Can you briefly explain the 1x and 2x configs?  This of course is highly
> > dependent whether or not HT is enabled...
> >
> 
> Sorry if I had not made very clear in earlier threads. Have you applied
> Rik's following patch for base. without this you could see some 
> inconsistent results perhaps.
> 
> https://lkml.org/lkml/2012/6/19/401

Yes, I do have that applied with your patch and in my baseline.

-Andrew Theurer

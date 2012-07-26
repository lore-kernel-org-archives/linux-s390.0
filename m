From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/3] KVM: s390: Trace events support.
Date: Thu, 26 Jul 2012 12:47:52 +0200
Message-ID: <20120726124752.00f9fccd@BR9GNB5Z>
References: <1343056830-45290-1-git-send-email-cornelia.huck@de.ibm.com>
	<50110F4E.6030106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <50110F4E.6030106@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Jul 2012 12:35:10 +0300
Avi Kivity <avi@redhat.com> wrote:

> On 07/23/2012 06:20 PM, Cornelia Huck wrote:
> > Avi, Marcelo,
> > 
> > here's a patch set that introduces trace events for kvm/s390.
> > 
> > It's split into two parts:
> > 
> > - Trace points for architecture-defined events, like intercepts.
> >   This patch calls into the disassembler via the interface provided
> >   by the first patch. These trace points show up under events/kvm/.
> > - Trace points for implementation-specific events like interrupt
> >   injection. These show up under a new trace system, kvm-s390.
> 
> I don't see what's the difference between the two types.  Isn't
> interrupt injection architectural?

I don't think so. The details how we do that might change, it's nothing
dictated by the architecture.

(It might be argued where interrupt delivery belongs, since parts of it
are architectured, while other parts are made up by us.)

> 
> On x86, the implementation tracepoints are ones that may go away if the
> implementation changes significantly, while the architectural ones will
> not go away unless the architecture is changed.  

That's what I tried to do here as well.

> In fact creation and
> destruction of vcpus and reset requests are not only architectural,
> they're generic, you may as well add them to the arch independent trace
> code.

The vpcu creation event also traces interesting information like the
location of our sie control block (in fact, that's the most interesting
information provided by the event).

The reset request traced is s390 specific (for diag 308 ipl).

> 
> btw - why are vcpu creation and destruction useful events to trace?

See above - mainly for the control block location.

Cornelia

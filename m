From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements
 explicit
Date: Sat, 3 Oct 2015 01:53:46 +0200
Message-ID: <20151002235346.GJ14464@wotan.suse.de>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
 <3544271.GfynADMPqZ@wuerfel>
 <20150903014415.GQ8051@wotan.suse.de>
 <1866509.8pE0MIz57e@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1866509.8pE0MIz57e@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-arch@vger.kernel.org, mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 08, 2015 at 03:42:40PM +0200, Arnd Bergmann wrote:
> On Thursday 03 September 2015 03:44:15 Luis R. Rodriguez wrote:
> > On Sun, Aug 30, 2015 at 09:30:26PM +0200, Arnd Bergmann wrote:
> > > On Friday 28 August 2015 17:17:27 Luis R. Rodriguez wrote:
> > > > While at it, as with the ioremap*() variants, since we have no clear
> > > > semantics yet well defined provide a solution for them that returns
> > > > NULL. This allows architectures to move forward by defining pci_ioremap*()
> > > > variants without requiring immediate changes to all architectures. Each
> > > > architecture then can implement their own solution as needed and
> > > > when they get to it.
> > > 
> > > Which architectures are you thinking about here?
> > 
> > Really only S390 would benefit from this now.
> 
> Ok
> 
> > > > Build tested with allyesconfig on:
> > > > 
> > > >         * S390
> > > >         * x86_64
> > > > 
> > > > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> > > 
> > > It's not really clear to me what the purpose of the patch is, is this 
> > > meant as a cleanup, or are you trying to avoid some real-life bugs
> > > you ran into?
> > 
> > Upon adding a new helper into CONFIG_PCI_IOMAP it was only through
> > 0-day build testing that I found that I needed to add something for S390.
> > This means we fix S390 reactively. With the asm-generic stuff in place
> > to return NULL we don't need to do anything but a respective return
> > NULL static inline, the moment that is done the author would know some
> > architectures may not get support for the functionality they are adding.
> > Without this we only find out reactively.
> 
> Hmm, my gut feeling tells me that your approach won't solve the problem
> in general. s390 PCI is just weird in many ways and it will occasionally
> suffer from problems like this (as do other aspects of the s390 architecture
> that are unlike the rest of the world).
> 
> Maybe Martin and Heiko can comment on this, they may have a preference
> from the s390 point of view.

Hrm, so S390 is quirky is really odd ways that no other architecture is or
is at least for now not expected to be ?

> > > The version from lib/iomap.c seems correct for uses of CONFIG_GENERIC_IOMAP,
> > > but most architectures can do better without that option.
> > 
> > By do better do you mean a more optimized solution ?
> 
> Yes: most architectures access the PCI I/O space through memory mapped I/O,
> so we can return a regular __iomem pointer from ioport_map, rather than
> a garbled pointer that the x86 version has to use.
> 
> This means we also get to define iowrite32() to be identical to writel()
> and can save the conditional for each caller.
>
> The lib/iomap.c version is really only needed for architectures that use
> pointer access for PCI memory space, and special instructions for PCI
> I/O space, like x86. s390 has special instructions for both, some
> architectures do not have any I/O port access at all, and most of them
> treat memory and I/O space the same way.

I see, thanks.

  Luis

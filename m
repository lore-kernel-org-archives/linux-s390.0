From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements
 explicit
Date: Thu, 3 Sep 2015 03:44:15 +0200
Message-ID: <20150903014415.GQ8051@wotan.suse.de>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
 <3544271.GfynADMPqZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3544271.GfynADMPqZ@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-arch@vger.kernel.org, mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Aug 30, 2015 at 09:30:26PM +0200, Arnd Bergmann wrote:
> On Friday 28 August 2015 17:17:27 Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > The S390 architecture requires a custom pci_iomap() implementation
> > as the asm-generic implementation assumes there are disjunctions
> > between PCI BARs, and on S390 PCI BAR are not disjunctive, S390 requires
> > the bar parameter in order to find the corresponding device and create
> > the mapping cookie.
> > 
> > This clash with the asm-generic pci_iomap() implementation is implicit,
> > there are no current semantics to make this incompatability explicit.
> > Make the S390 PCI BAR non-disjunction incompatibility explicit, and
> > also pave the way for alternative incompatibilities to be defined.
> 
> I don't think we really need to spell it out here. s390 PCI is different
> from everybody else's in a lot of ways, so a simple 'depends on PCI &&
> !S390' for CONFIG_PCI_IOMAP seems simpler and more intuitive.

Sure that would work as well.

> > While at it, as with the ioremap*() variants, since we have no clear
> > semantics yet well defined provide a solution for them that returns
> > NULL. This allows architectures to move forward by defining pci_ioremap*()
> > variants without requiring immediate changes to all architectures. Each
> > architecture then can implement their own solution as needed and
> > when they get to it.
> 
> Which architectures are you thinking about here?

Really only S390 would benefit from this now.

> > Build tested with allyesconfig on:
> > 
> >         * S390
> >         * x86_64
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> 
> It's not really clear to me what the purpose of the patch is, is this 
> meant as a cleanup, or are you trying to avoid some real-life bugs
> you ran into?

Upon adding a new helper into CONFIG_PCI_IOMAP it was only through
0-day build testing that I found that I needed to add something for S390.
This means we fix S390 reactively. With the asm-generic stuff in place
to return NULL we don't need to do anything but a respective return
NULL static inline, the moment that is done the author would know some
architectures may not get support for the functionality they are adding.
Without this we only find out reactively.

> > This came up as an idea after noting that S390 has no way to be
> > explicit about its requirements, this also means we don't have a
> > quick easy way to ensure that other architectures might have a
> > conflict as well. This provides an easy way to do that by having
> > the architectures define their incompatibilities and allowing those
> > then to negate GENERIC_PCI_IOMAP on lib/Kconfig.
> 
> PCI_IOMAP seems much simpler than ioport_map here, as a lot of
> architectures can have overlapping port numbers across PCI host
> bridges.

Sure, agreed.

> > I think a next cleanup could be the move of the pci_iounmap() out to
> > pci_iomap.h to avoid having each arch having to declare it. That's
> > a separate atomic change though so should go in separately.
> 
> pci_iounmap() is rather tricky, and I think some architectures currently
> get it wrong 

Whoops.

> and will actually unmap parts of the I/O port ranges from
> the PCI host controller mapping. It might be rare enough that it never
> caused problems (that got reported), but it might be nice to actually
> provide an implementation that has a chance of working.

Sure.

> The version from lib/iomap.c seems correct for uses of CONFIG_GENERIC_IOMAP,
> but most architectures can do better without that option.

By do better do you mean a more optimized solution ?

 Luis

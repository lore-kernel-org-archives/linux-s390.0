From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements
 explicit
Date: Sat, 3 Oct 2015 02:04:50 +0200
Message-ID: <20151003000450.GK14464@wotan.suse.de>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
 <3544271.GfynADMPqZ@wuerfel>
 <20150903014415.GQ8051@wotan.suse.de>
 <1866509.8pE0MIz57e@wuerfel>
 <20150911101409.79a7b3ef@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150911101409.79a7b3ef@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-arch@vger.kernel.org, mingo@kernel.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 11, 2015 at 10:14:09AM +0200, Martin Schwidefsky wrote:
> On Tue, 08 Sep 2015 15:42:40 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Thursday 03 September 2015 03:44:15 Luis R. Rodriguez wrote:
> > > On Sun, Aug 30, 2015 at 09:30:26PM +0200, Arnd Bergmann wrote:
> > > > On Friday 28 August 2015 17:17:27 Luis R. Rodriguez wrote:
> > > > > While at it, as with the ioremap*() variants, since we have no clear
> > > > > semantics yet well defined provide a solution for them that returns
> > > > > NULL. This allows architectures to move forward by defining pci_ioremap*()
> > > > > variants without requiring immediate changes to all architectures. Each
> > > > > architecture then can implement their own solution as needed and
> > > > > when they get to it.
> > > > 
> > > > Which architectures are you thinking about here?
> > > 
> > > Really only S390 would benefit from this now.
> > 
> > Ok
> > 
> > > > > Build tested with allyesconfig on:
> > > > > 
> > > > >         * S390
> > > > >         * x86_64
> > > > > 
> > > > > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> > > > 
> > > > It's not really clear to me what the purpose of the patch is, is this 
> > > > meant as a cleanup, or are you trying to avoid some real-life bugs
> > > > you ran into?
> > > 
> > > Upon adding a new helper into CONFIG_PCI_IOMAP it was only through
> > > 0-day build testing that I found that I needed to add something for S390.
> > > This means we fix S390 reactively. With the asm-generic stuff in place
> > > to return NULL we don't need to do anything but a respective return
> > > NULL static inline, the moment that is done the author would know some
> > > architectures may not get support for the functionality they are adding.
> > > Without this we only find out reactively.
> > 
> > Hmm, my gut feeling tells me that your approach won't solve the problem
> > in general. s390 PCI is just weird in many ways and it will occasionally
> > suffer from problems like this (as do other aspects of the s390 architecture
> > that are unlike the rest of the world).
> > 
> > Maybe Martin and Heiko can comment on this, they may have a preference
> > from the s390 point of view.
> 
> I do not see how the additional Kconfig ARCH_PCI_NON_DISJUNCTIVE and the
> #ifdef indirections help with anything. An extension to lib/pci_iomap.c
> now requires an extra inline function in include/asm-generic/pci_iomap.h
> which I am sure will be added blindly without any consideration what
> s390 needs.

The purpose here was to enable evolution of this code *without* having to
require a solution in place for S390, instead on S390 such things would just
not fail to compile and when and if folks needed it they'd write it.

> Actually the patch makes it worse as the new inline will cover things up.
> Instead of a zero day compile error we will be left with a silently broken
> extension.
> 
> I prefer a compile error as it points out that there is a problem.

Of course you would though, the patch's intention is to enable folks to
have to consider a solution for S390, it would let *you* the maintainers
of S390 eventually get to it without requiring a solution in place to be
defiend for S390 always in this area due to the overlapping PCI bar
situation on S390. This is how we devised support requirements for
ioremap_*() variants, for instance, it means architecture and/or
drivers that need these variants can evolve within Linux without having
to wait to iron things out for other architectures. Is that a design
mistake ? I figured we'd want to take advantage of similar practice here,
but if S390 is soooooo quircky that we'd end up with too many of these
I can understand this is undesirable... but that reason is different
than *wanting* a compile error to prompt a solution before code gets
merged upstream or with the hope that a bot compile test should figure
these issues out somehow.

Now, even if these quirky design considerations are spread all over S390
it would seem to me *good* to have them well documented, it does not seem
that's the case today, so using something like this should be considered
for the gains of having these properly identified.

You guys can decide. Was just trying to be proactive here about all this.
I really don't think waiting for a compile bot to tell you there is an
issue scale wells, nor do I think its the best of designs possible.

  Luis

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements
 explicit
Date: Tue, 6 Oct 2015 13:15:04 +0200
Message-ID: <20151006131504.4385c598@mschwide>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
	<1866509.8pE0MIz57e@wuerfel>
	<20151002235346.GJ14464@wotan.suse.de>
	<8902671.32Mbh7QhE4@wuerfel>
	<20151005170914.GM14464@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20151005170914.GM14464@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-arch@vger.kernel.org, mingo@kernel.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 5 Oct 2015 19:09:14 +0200
"Luis R. Rodriguez" <mcgrof@suse.com> wrote:

> On Sun, Oct 04, 2015 at 09:02:04PM +0200, Arnd Bergmann wrote:
> > On Saturday 03 October 2015 01:53:46 Luis R. Rodriguez wrote:
> > > > 
> > > > Hmm, my gut feeling tells me that your approach won't solve the problem
> > > > in general. s390 PCI is just weird in many ways and it will occasionally
> > > > suffer from problems like this (as do other aspects of the s390 architecture
> > > > that are unlike the rest of the world).
> > > > 
> > > > Maybe Martin and Heiko can comment on this, they may have a preference
> > > > from the s390 point of view.
> > > 
> > > Hrm, so S390 is quirky is really odd ways that no other architecture is or
> > > is at least for now not expected to be ?
> > 
> > Absolutely correct. It is the only architecture I'm aware of that tries to
> > support PCI that does not use pointer dereferences for MMIO.
> 
> So its not worth it to have a formal semantic via Kconfig for this and are
> happy with the status quo of having to find out through a bot compile test
> any changes in this domain fails?

For my part I still do not see the value in ARCH_PCI_NON_DISJUNCTIVE.
The existing GENERIC_PCI_IOMAP already allows an architecture to select
the generic implementation (or not to select it). To add another Kconfig
symbol and make GENERIC_PCI_IOMAP depend on it doesn't help.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

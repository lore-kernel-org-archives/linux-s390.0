From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements explicit
Date: Sun, 04 Oct 2015 21:02:04 +0200
Message-ID: <8902671.32Mbh7QhE4@wuerfel>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com> <1866509.8pE0MIz57e@wuerfel> <20151002235346.GJ14464@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151002235346.GJ14464@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-arch@vger.kernel.org, mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org
List-ID: <linux-s390.vger.kernel.org>

On Saturday 03 October 2015 01:53:46 Luis R. Rodriguez wrote:
> > 
> > Hmm, my gut feeling tells me that your approach won't solve the problem
> > in general. s390 PCI is just weird in many ways and it will occasionally
> > suffer from problems like this (as do other aspects of the s390 architecture
> > that are unlike the rest of the world).
> > 
> > Maybe Martin and Heiko can comment on this, they may have a preference
> > from the s390 point of view.
> 
> Hrm, so S390 is quirky is really odd ways that no other architecture is or
> is at least for now not expected to be ?

Absolutely correct. It is the only architecture I'm aware of that tries to
support PCI that does not use pointer dereferences for MMIO.

	Arnd

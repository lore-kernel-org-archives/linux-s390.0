From: "Maciej W. Rozycki" <macro@imgtec.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Wed, 27 Jan 2016 11:26:20 +0000
Message-ID: <alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk>
References: <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com> <20160114203430.GC3818@linux.vnet.ibm.com> <56980C91.1010403@imgtec.com> <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com> <20160114225510.GJ3818@linux.vnet.ibm.com> <56983054.4070807@imgtec.com> <20160115004753.GN3818@linux.vnet.ibm.com> <56984642.3090106@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <56984642.3090106@imgtec.com>
Sender: linux-sh-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge
List-ID: <linux-s390.vger.kernel.org>

On Fri, 15 Jan 2016, Leonid Yegoshin wrote:

> > So you need to build a different kernel for some types of MIPS systems?
> > Or do you do boot-time rewriting, like a number of other arches do?
> 
> I don't know. I would like to have responses. Ralf asked Maciej about old
> systems and that came nowhere. Even rewrite - don't know what to do with that:
> no lightweight SYNC or no SYNC at all - yes, it is still possible that SYNC on
> some systems can be too heavy or even harmful, nobody tested that.

 I don't recall being asked; mind that I might not get to messages I have 
not been cc-ed in a timely manner and I may miss some altogether.  With 
the amount of mailing list traffic that passes by me my scanner may fail 
to trigger.  Sorry if this causes anybody trouble, but such is life.

 Coincidentally, I have just posted some notes on SYNC in a different 
thread, see <http://lkml.iu.edu/hypermail/linux/kernel/1601.3/03080.html>.  
There's a reference to an older message of mine there too.  I hope this 
answers your questions.

  Maciej

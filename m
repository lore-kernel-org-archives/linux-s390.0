Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 18 May 2017 18:30:10 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/1] futex: remove duplicated code
Message-ID: <20170518173010.GK21359@arm.com>
References: <20170515130742.18357-1-jslaby@suse.cz>
 <20170515131644.GA3605@arm.com>
 <14580dfc-9721-38ab-a1e0-6b4aba13b406@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14580dfc-9721-38ab-a1e0-6b4aba13b406@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170518173010.Zky7HLwqsvtMBjq8oghpBhdRaDIW3bgI38X45VTnhhU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 17, 2017 at 10:01:29AM +0200, Jiri Slaby wrote:
> On 05/15/2017, 03:16 PM, Will Deacon wrote:
> > Whilst I think this is a good idea, the code in question actually results
> > in undefined behaviour per the C spec and is reported by UBSAN.
> 
> Hi, yes, I know -- this patch was the 1st from the series of 3 which I
> sent a long time ago to fix that up too. But I remember your patch, so I
> sent only this one this time.
> 
> > See my
> > patch fixing arm64 here (which I'd forgotten about):
> > 
> > https://www.spinics.net/lists/linux-arch/msg38564.html
> > 
> > But, as stated in the thread above, I think we should go a step further
> > and remove FUTEX_OP_{OR,ANDN,XOR,OPARG_SHIFT} altogether. They don't
> > appear to be used by userspace, and this whole thing is a total mess.
> > 
> > Any thoughts?
> 
> Ok, I am all for that. I think the only question is who is going to do
> the work and submit it :)? Do I understand correctly to eliminate all
> these functions and the path into the kernel? But won't this break API
> -- are there really no users of this interface?

That's the million-dollar question, really. I don't know of any code using
it, and I couldn't find any when I looked (also nothing reported by Debian
Codesearch afaict), but I was hoping linux-arch might have some thoughts
on this too.

For now, I'll queue my arm64 patch before I forget about it again!

Will

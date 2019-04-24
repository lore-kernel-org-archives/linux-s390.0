From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 5/5] arm64/speculation: Support 'mitigations=' cmdline
 option
Date: Wed, 24 Apr 2019 15:16:31 +0100
Message-ID: <20190424141631.GH14829@fuggles.cambridge.arm.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1904162124020.1780@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904162124020.1780@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.orglinux
List-ID: <linux-s390.vger.kernel.org>

Hi Thomas,

On Tue, Apr 16, 2019 at 09:26:13PM +0200, Thomas Gleixner wrote:
> On Fri, 12 Apr 2019, Josh Poimboeuf wrote:
> 
> > Configure arm64 runtime CPU speculation bug mitigations in accordance
> > with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
> > v2, and Speculative Store Bypass.
> > 
> > The default behavior is unchanged.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> > NOTE: This is based on top of Jeremy Linton's patches:
> >       https://lkml.kernel.org/r/20190410231237.52506-1-jeremy.linton@arm.com
> 
> So I keep that out and we have to revisit that once the ARM64 stuff hits a
> tree, right? I can have a branch with just the 4 first patches applied
> which ARM64 folks can pull in when they apply Jeremy's patches before te
> merge window.

I'm assuming that this refers to the core/speculation branch in tip:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/speculation

but please can you confirm that I'm good to pull that into arm64?

Cheers,

Will

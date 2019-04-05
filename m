From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH RFC 5/5] arm64/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Date: Fri, 5 Apr 2019 11:03:51 -0500
Message-ID: <20190405160351.5l4wbmool5m4rkua@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
 <20190405144414.GB7662@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190405144414.GB7662@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.orglinux
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 05, 2019 at 03:44:14PM +0100, Will Deacon wrote:
> Hi Josh,
> 
> On Thu, Apr 04, 2019 at 11:44:15AM -0500, Josh Poimboeuf wrote:
> > Configure arm64 runtime CPU speculation bug mitigations in accordance
> > with the 'cpu_spec_mitigations=' cmdline options.  This affects
> > Meltdown and Speculative Store Bypass.
> > 
> > The default behavior is unchanged.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 2 ++
> >  arch/arm64/kernel/cpu_errata.c                  | 4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 6 ++++++
> >  3 files changed, 12 insertions(+)
> 
> Just wanted to make you aware that this is probably going to conflict badly
> with some patches we have pending to hook up the sysfs entries:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/640326.html
> 
> That patch series isn't quite there yet, so I'm expecting a v7, but I think
> it will change the shape of this patch quite a lot.

Thanks for the heads up Will.  I will drop the arm64 patch for now then.

-- 
Josh

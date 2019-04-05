From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Date: Fri, 5 Apr 2019 11:05:36 -0500
Message-ID: <20190405160536.sks2hmo6sxnxg3tl@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
 <20190405135712.GF23348@zn.tnic>
 <20190405143101.ksj7ayjis4p52dgt@treble>
 <20190405152650.GH23348@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190405152650.GH23348@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 05, 2019 at 05:26:50PM +0200, Borislav Petkov wrote:
> On Fri, Apr 05, 2019 at 09:31:01AM -0500, Josh Poimboeuf wrote:
> > My thinking was that the individual options could be used to override
> > the global option.  But maybe that's overkill?  I dunno.
> 
> You mean if the user deliberately types:
> 
> "cpu_spec_mitigations=off spectre_v2=auto"
> 
> on the cmdline to turn off all and then enable only one?
> 
> Hmm, yap, sounds like an overkill to me. Then I'd probably do:
> 
> 	pr_err("Make up your mind already!\n");
> 	return;
> 
> :-))
> 
> I'd say let's do the simpler and cleaner thing now and think about
> supporting this overkill when it really turns out that it is needed.

Fair enough.

> > I assume you mean just the part where L1TF_MITIGATION_DEFAULT is added?
> 
> Yap.

Ok.

-- 
Josh

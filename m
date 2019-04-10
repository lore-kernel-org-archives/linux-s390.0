From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Date: Wed, 10 Apr 2019 14:10:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904101408580.3479@nanos.tec.linutronix.de>
References: <cover.1554396090.git.jpoimboe@redhat.com> <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com> <20190405131211.GE23348@zn.tnic> <20190405142048.burthk2jnpcvi2om@treble> <20190405152059.GG23348@zn.tnic> <20190405160136.GI23348@zn.tnic>
 <20190405161852.nmpk22omgiety4df@treble> <87sguqwgu7.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sguqwgu7.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arc
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> 
> > On Fri, Apr 05, 2019 at 06:01:36PM +0200, Borislav Petkov wrote:
> >> Thinking about this more, we can shave off the first 4 chars and have it
> >> be:
> >> 
> >> spec_mitigations=
> >> 
> >> I think it is painfully clear which speculation mitigations we mean. And
> >> the other switches don't have "cpu_" prefixes too so...
> >
> > Sure, I'm ok with renaming it to that, if there are no objections.
> 
> What about when we have a mitigation for a non-speculation related bug :)

Those kind of silicon bugs are usually mitigated unconditionally.

Thanks,

	tglx

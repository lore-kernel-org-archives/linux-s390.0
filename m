From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Date: Wed, 10 Apr 2019 10:30:28 +0200
Message-ID: <20190410083028.GA26580@zn.tnic>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
 <20190405131211.GE23348@zn.tnic>
 <20190405142048.burthk2jnpcvi2om@treble>
 <20190405152059.GG23348@zn.tnic>
 <20190405160136.GI23348@zn.tnic>
 <20190405161852.nmpk22omgiety4df@treble>
 <87sguqwgu7.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sguqwgu7.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.orglin
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 03:48:48PM +1000, Michael Ellerman wrote:
> What about when we have a mitigation for a non-speculation related bug :)

Like that is *ever* going to happen... :-P

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

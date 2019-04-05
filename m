Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 5 Apr 2019 17:20:59 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Message-ID: <20190405152059.GG23348@zn.tnic>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
 <20190405131211.GE23348@zn.tnic>
 <20190405142048.burthk2jnpcvi2om@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405142048.burthk2jnpcvi2om@treble>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190405152059.08_dCkDXzn8b5SW1QVcJq5DyPHq85ZVw5ngPousboME@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 05, 2019 at 09:20:48AM -0500, Josh Poimboeuf wrote:
> In your scenario, the fact that it's so easy to remember would save the
> day, since you wouldn't have to go look up some obscure shortened option
> name in the documentation :-)

No no, the idea is for the short option to be memorable.

> Suggestions are welcome but I couldn't come up with a reasonable shorter
> option.

Same here.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

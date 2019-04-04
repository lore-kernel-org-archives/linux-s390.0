Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 4 Apr 2019 21:49:05 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
In-Reply-To: <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
Message-ID: <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
References: <cover.1554396090.git.jpoimboe@redhat.com> <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404194905.qR9T-btAf0BVt0YfG6H0h19JLAE1AXADvXFhopuL0f4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 4 Apr 2019, Josh Poimboeuf wrote:

> Configure powerpc CPU runtime speculation bug mitigations in accordance
> with the 'cpu_spec_mitigations=' cmdline options.  This affects
> Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
[ ... snip ... ]
> -	if (!no_nospec)
> +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)

'!no_nospec' is something that I am sure will come back to hunt me in my 
bad dreams.

But that's been there already, and fixing it is out of scope of this 
patch. Other than that, as discussed previously -- I really like this new 
global option. Feel free to add

	Reviewed-by: Jiri Kosina <jkosina@suse.cz>

for the whole set.

Thanks,

-- 
Jiri Kosina
SUSE Labs

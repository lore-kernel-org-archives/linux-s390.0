Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 16 Apr 2019 09:53:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/5] cpu/speculation: Add 'mitigations=' cmdline
 option
In-Reply-To: <cover.1555085500.git.jpoimboe@redhat.com>
Message-ID: <nycvar.YFH.7.76.1904160952410.9803@cbobk.fhfr.pm>
References: <cover.1555085500.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190416075329.KJr8FAkPx2czAf7YhpSnZUCFfQ8f7y-rGWjWftCShrI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 12 Apr 2019, Josh Poimboeuf wrote:

> v2:
> - docs improvements: [Randy, Michael]
> - Rename to "mitigations=" [Michael]
> - Add cpu_mitigations_off() function wrapper [Michael]
> - x86: Simplify logic [Boris]
> - powerpc: Fix no_rfi_flush checking bug (use '&&' instead of '||')
> - arm64: Rebase onto Jeremy Linton's v7 patches [Will]
> - arm64: "kpti command line option" [Steve P]
> - arm64: Add nospectre_v2 support
> 
> -----------
> 
> Keeping track of the number of mitigations for all the CPU speculation
> bugs has become overwhelming for many users.  It's getting more and more
> complicated to decide which mitigations are needed for a given
> architecture.  Complicating matters is the fact that each arch tends to
> have its own custom way to mitigate the same vulnerability.
> 
> Most users fall into a few basic categories:
> 
> a) they want all mitigations off;
> 
> b) they want all reasonable mitigations on, with SMT enabled even if
>    it's vulnerable; or
> 
> c) they want all reasonable mitigations on, with SMT disabled if
>    vulnerable.
> 
> Define a set of curated, arch-independent options, each of which is an
> aggregation of existing options:
> 
> - mitigations=off: Disable all mitigations.
> 
> - mitigations=auto: [default] Enable all the default mitigations, but
>   leave SMT enabled, even if it's vulnerable.
> 
> - mitigations=auto,nosmt: Enable all the default mitigations, disabling
>   SMT if needed by a mitigation.
> 
> Josh Poimboeuf (5):
>   cpu/speculation: Add 'mitigations=' cmdline option
>   x86/speculation: Support 'mitigations=' cmdline option
>   powerpc/speculation: Support 'mitigations=' cmdline option
>   s390/speculation: Support 'mitigations=' cmdline option
>   arm64/speculation: Support 'mitigations=' cmdline option

Tested-by: Jiri Kosina <jkosina@suse.cz> (on x86)
Reviewed-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

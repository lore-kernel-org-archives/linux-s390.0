Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 5 Apr 2019 15:12:11 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Message-ID: <20190405131211.GE23348@zn.tnic>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190405131211.Q2NjuOAdnJlvlrA0AG2RZhInDwko2zhWKJScqKXcYKQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 04, 2019 at 11:44:11AM -0500, Josh Poimboeuf wrote:
> Keeping track of the number of mitigations for all the CPU speculation
> bugs has become overwhelming for many users.  It's getting more and more
> complicated to decide which mitigations are needed for a given
> architecture.  Complicating matters is the fact that each arch tends to
> their own custom way to mitigate the same vulnerability.

Yap, we definitely need something like that.

> Most users fall into a few basic categories:
> 
> a) they want all mitigations off;
> 
> b) they want all reasonable mitigations on, with SMT enabled even if
>    it's vulnerable; or

Uff, "reasonable" - there's the bikeshed waiting to happen.

> c) they want all reasonable mitigations on, with SMT disabled if
>    vulnerable.
> 
> Define a set of curated, arch-independent options, each of which is an
> aggregation of existing options:
> 
> - cpu_spec_mitigations=off: Disable all mitigations.

"cpu_spec_mitigations" is too long, TBH.

Imagine yourself in a loud, noisy data center - you basically can't wait
to leave - crouched over a keyboard in an impossible position, having
to type that thing and then making a typo. Whoops, too late, already
pressed Enter. Shiiiit!

Now you have to wait at least 15 mins for the damn single-threaded added
value BIOS crap to noodle through all the cores just so you can try
again, because you just rebooted the box.

And I know, my ideas for shorter cmdline options are crazy, like

cpu_spec_mtg=

which people would say, yuck, unreadable...

Oh, I know! How about

cpu_vulns=

?

We already have /sys/devices/system/cpu/vulnerabilities so it'll be the
same as that. Less things to remember.

> - cpu_spec_mitigations=auto: [default] Enable all the default
>   mitigations, but leave SMT enabled, even if it's vulnerable.
> 
> - cpu_spec_mitigations=auto,nosmt: Enable all the default mitigations,
>   disabling SMT if needed by a mitigation.

Yah, the suboption choices make sense to me.

> 
> Currently, these options are placeholders which don't actually do
> anything.  They will be fleshed out in upcoming patches.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++++++
>  include/linux/cpu.h                           |  8 +++++++
>  kernel/cpu.c                                  | 15 ++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c4d830003b21..ac42e510bd6e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2544,6 +2544,29 @@
>  			in the "bleeding edge" mini2440 support kernel at
>  			http://repo.or.cz/w/linux-2.6/mini2440.git
>  
> +	cpu_spec_mitigations=
> +			[KNL] Control mitigations for CPU speculation
> +			vulnerabilities on affected CPUs.  This is a set of
> +			curated, arch-independent options, each of which is an
> +			aggregation of existing options.
> +
> +			off
> +				Disable all speculative CPU mitigations.

Alias to

cpu_vulns=make_linux_fast_again

:-P

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 16 Apr 2019 16:13:35 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/5] cpu/speculation: Add 'mitigations=' cmdline option
Message-ID: <20190416141335.GH31772@zn.tnic>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190416141335.y67wtJ3m8fkN-XpvdvDpqRMM1qKZjkvbz7qOljwput8@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 12, 2019 at 03:39:28PM -0500, Josh Poimboeuf wrote:
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 38890f62f9a8..aed9083f8eac 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2320,3 +2320,18 @@ void __init boot_cpu_hotplug_init(void)
>  #endif
>  	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
>  }
> +
> +enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
> +
> +static int __init mitigations_cmdline(char *arg)

Forgot the verb: "mitigations_parse_cmdline".

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

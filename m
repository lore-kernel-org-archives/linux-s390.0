From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4.4 247/266] cpu/speculation: Add mitigations= cmdline option
Date: Thu, 16 May 2019 09:04:41 +0200
Message-ID: <CAMuHMdVFaQLbH7F=Ard5MzUzG1FTfwLH=7xz=LpA3YaZyj2+Zg@mail.gmail.com>
References: <20190515090722.696531131@linuxfoundation.org> <20190515090731.364702401@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190515090731.364702401@linuxfoundation.org>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Hutchings <ben@decadent.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Steven Price <steven.price@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jon Masters <jcm@redhat.com>, Waiman Long <longman@redhat.com>, Linux-Arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Josh
List-ID: <linux-s390.vger.kernel.org>

Hi Greg, Ben,

On Wed, May 15, 2019 at 1:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
>
> commit 98af8452945c55652de68536afdde3b520fec429 upstream.
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
> Currently, these options are placeholders which don't actually do
> anything.  They will be fleshed out in upcoming patches.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

> [bwh: Backported to 4.4:
>  - Drop the auto,nosmt option which we can't support

This doesn't really stand out. I.e. I completely missed it, and started
wondering why "auto,nosmt" was not documented in
kernel-parameters.txt below...

> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2173,6 +2173,25 @@ bytes respectively. Such letter suffixes
>                         in the "bleeding edge" mini2440 support kernel at
>                         http://repo.or.cz/w/linux-2.6/mini2440.git
>
> +       mitigations=
> +                       Control optional mitigations for CPU vulnerabilities.
> +                       This is a set of curated, arch-independent options, each
> +                       of which is an aggregation of existing arch-specific
> +                       options.
> +
> +                       off
> +                               Disable all optional CPU mitigations.  This
> +                               improves system performance, but it may also
> +                               expose users to several CPU vulnerabilities.
> +
> +                       auto (default)
> +                               Mitigate all CPU vulnerabilities, but leave SMT
> +                               enabled, even if it's vulnerable.  This is for
> +                               users who don't want to be surprised by SMT
> +                               getting disabled across kernel upgrades, or who
> +                               have other ways of avoiding SMT-based attacks.
> +                               This is the default behavior.
> +
>         mminit_loglevel=
>                         [KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
>                         parameter allows control of the logging verbosity for

> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -842,3 +842,16 @@ void init_cpu_online(const struct cpumas
>  {
>         cpumask_copy(to_cpumask(cpu_online_bits), src);
>  }
> +
> +enum cpu_mitigations cpu_mitigations = CPU_MITIGATIONS_AUTO;
> +
> +static int __init mitigations_parse_cmdline(char *arg)
> +{
> +       if (!strcmp(arg, "off"))
> +               cpu_mitigations = CPU_MITIGATIONS_OFF;
> +       else if (!strcmp(arg, "auto"))
> +               cpu_mitigations = CPU_MITIGATIONS_AUTO;

Perhaps

    else
            pr_crit("mitigations=%s is not supported\n", arg);

?

Actually that makes sense on mainline, too.
Cooking a patch...

> +
> +       return 0;
> +}
> +early_param("mitigations", mitigations_parse_cmdline);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

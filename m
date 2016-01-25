From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 0/3] kallsyms base relative series
Date: Mon, 25 Jan 2016 10:53:34 -0800
Message-ID: <CAGXu5jK9vSafsp8KdArPqT748WwcSnhDO0vYcuhCu+NHeSiFfg@mail.gmail.com>
References: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 25, 2016 at 6:19 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This v4 of my kallsyms base relative implementation is now a 3 piece series,
> since it caused some problems due to the way absolute symbols are handled
> by the absolute per cpu code. As it turns out, that code was probably wrong
> in the sense that it caused non-relocated symbol addresses to be emitted
> for values that are in fact relative to the address of the kernel text.
>
> Patch #1 fixes the scripts/kallsyms invocation to only pass the x86_64
> specific --absolute-percpu option if CONFIG_SMP is also set.
>
> Patch #2 reworks the absolute percpu code to only emit those percpu symbols
> as absolute, and not symbols that have been classified as 'A' (absolute) by
> the linker, since that does not mean quite the same thing.
>
> Patch #3 is the original kallsyms base relative patch, with some
> modifications:
> - folded the s/ULLONG_MAX/-1ULL? change made by Andrew
> - ensured that the kallsyms_relative_base value itself is relocated as
>   required.
> - dropped all of the acks and other tags, as they have become outdated with
>   the recent changes to this patch.
>
> Ard Biesheuvel (3):
>   x86: kallsyms: disable absolute percpu symbols on !SMP
>   kallsyms: don't overload absolute symbol type for percpu symbols
>   kallsyms: add support for relative offsets in kallsyms address table

Still works for me!

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

-Kees

>
>  init/Kconfig            |  16 +++
>  kernel/kallsyms.c       |  38 ++++++--
>  scripts/kallsyms.c      | 102 +++++++++++++++++---
>  scripts/link-vmlinux.sh |   6 +-
>  scripts/namespace.pl    |   2 +
>  5 files changed, 142 insertions(+), 22 deletions(-)
>
> --
> 2.5.0
>



-- 
Kees Cook
Chrome OS & Brillo Security

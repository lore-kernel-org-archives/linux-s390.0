Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/4] support for text-relative kallsyms table
In-Reply-To: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
Date: Thu, 21 Jan 2016 15:40:53 +1030
Message-ID: <878u3jy0te.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz
List-ID: <linux-s390.vger.kernel.org>

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> This implements text-relative kallsyms address tables. This was developed
> as part of my series to implement KASLR/CONFIG_RELOCATABLE for arm64, but
> I think it may be beneficial to other architectures as well, so I am
> presenting it as a separate series.

Nice work!

AFAICT this should work for every arch, as long as they start with _text
(esp: data and init must be > _text).  In addition, it's not harmful on
32 bit archs.

IOW, I'd like to turn it on for everyone and discard some code.  But
it's easier to roll in like you've done first.

Should we enable it by default for every arch for now, and see what
happens?

Thanks!
Rusty.

> The idea is that on 64-bit builds, it is rather wasteful to use absolute
> addressing for kernel symbols since they are all within a couple of MBs
> of each other. On top of that, the absolute addressing implies that, when
> the kernel is relocated at runtime, each address in the table needs to be
> fixed up individually.
>
> Since all section-relative addresses are already emitted relative to _text,
> it is quite straight-forward to record only the offset, and add the absolute
> address of _text at runtime when referring to the address table.
>
> The reduction ranges from around 250 KB uncompressed vmlinux size and 10 KB
> compressed size (s390) to 3 MB/500 KB for ppc64 (although, in the latter case,
> the reduction in uncompressed size is primarily __init data)
>
> Kees Cook was so kind to test these against x86_64, and confirmed that KASLR
> still operates as expected.
>
> Ard Biesheuvel (4):
>   kallsyms: add support for relative offsets in kallsyms address table
>   powerpc: enable text relative kallsyms for ppc64
>   s390: enable text relative kallsyms for 64-bit targets
>   x86_64: enable text relative kallsyms for 64-bit targets
>
>  arch/powerpc/Kconfig    |  1 +
>  arch/s390/Kconfig       |  1 +
>  arch/x86/Kconfig        |  1 +
>  init/Kconfig            | 14 ++++++++
>  kernel/kallsyms.c       | 35 +++++++++++++-----
>  scripts/kallsyms.c      | 38 +++++++++++++++++---
>  scripts/link-vmlinux.sh |  4 +++
>  scripts/namespace.pl    |  1 +
>  8 files changed, 82 insertions(+), 13 deletions(-)
>
> -- 
> 2.5.0

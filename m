From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] jump_label: move 'asm goto' support test to Kconfig
Date: Wed, 02 Jan 2019 22:22:44 +1100
Message-ID: <87imz7xq0r.fsf@concordia.ellerman.id.au>
References: <1546182855-24290-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546182855-24290-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: masahiroy@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "David S . Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Currently, CONFIG_JUMP_LABEL just means "I _want_ to use jump label".
>
> The jump label is controlled by HAVE_JUMP_LABEL, which is defined
> like this:
>
>   #if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
>   # define HAVE_JUMP_LABEL
>   #endif
>
> We can improve this by testing 'asm goto' support in Kconfig, then
> make JUMP_LABEL depend on CC_HAS_ASM_GOTO.
>
> Ugly #ifdef HAVE_JUMP_LABEL will go away, and CONFIG_JUMP_LABEL will
> match to the real kernel capability.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> This is a trivial conversion from the build system PoV.
> I want to queue this up to kbuild tree.
>
>
>  Makefile                                          |  7 -------
>  arch/Kconfig                                      |  1 +
>  arch/arm/kernel/jump_label.c                      |  4 ----
>  arch/arm64/kernel/jump_label.c                    |  4 ----
>  arch/mips/kernel/jump_label.c                     |  4 ----
>  arch/powerpc/include/asm/asm-prototypes.h         |  2 +-
>  arch/powerpc/kernel/jump_label.c                  |  2 --
>  arch/powerpc/platforms/powernv/opal-tracepoints.c |  2 +-
>  arch/powerpc/platforms/powernv/opal-wrappers.S    |  2 +-
>  arch/powerpc/platforms/pseries/hvCall.S           |  4 ++--
>  arch/powerpc/platforms/pseries/lpar.c             |  2 +-

Looks OK to me.

If there's any odd build errors they should get caught in linux-next.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

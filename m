From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: jump_label: move 'asm goto' support test to Kconfig
Date: Thu, 3 Jan 2019 09:35:49 +0900
Message-ID: <CAK7LNASWScb7Qt0kmV8RyBdix2GPA24gv=eRNYVWu5dGGePbfQ@mail.gmail.com>
References: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "David S . Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, X86 ML <x86@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 2, 2019 at 9:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> I was not aware that CONFIG_JUMP_LABEL Kconfig setting depends on the
> support of asm-goto.
>
> Currently, I am doing experiments with clang-7 and a snapshot of
> clang-8 on Linux/x86.
> These compilers have no asm-goto support.
>
> What is your recommendation for Linux >= v4.20?
> I am asking as it is possible to set CONFIG_JUMP_LABEL=y when
> compiling with clang - which has no effect.
> This is confusing.
>
> Thanks, this patch makes things clearer and protects users from
> setting "wrong" in the sense of non-functional settings.
>
> I have tested this against recent Linus tree where kbuild/kconfig Git
> pulls were latest commits.
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ x86 with LLVM/Clang
> v7 and v8 (snapshot) ]


Which part was tested?

x86 kernel cannot be compiled with Clang
since it lacks the asm-goto support.


$ make CC=clang
Compiler lacks asm-goto support.
arch/x86/Makefile:293: recipe for target 'checkbin' failed
make: *** [checkbin] Error 1






-- 
Best Regards
Masahiro Yamada

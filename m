Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200922232140.1994390-1-morbo@google.com>
In-Reply-To: <20200922232140.1994390-1-morbo@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 25 Sep 2020 01:03:19 +0900
Message-ID: <CAK7LNATjf+bVqkkoZgwu9sr-A+VXxEnW_R8nEwmH=aDEU6NAQw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: explicitly specify the build id style
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Catalin Marinas <catalin.marinas@arm.com>, "David S . Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org, "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <natechancellor@gmail.com>

On Wed, Sep 23, 2020 at 8:21 AM Bill Wendling <morbo@google.com> wrote:
>
> ld's --build-id defaults to "sha1" style, while lld defaults to "fast".
> The build IDs are very different between the two, which may confuse
> programs that reference them.
>
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  Makefile                             | 4 ++--
>  arch/arm/vdso/Makefile               | 2 +-
>  arch/arm64/kernel/vdso/Makefile      | 2 +-
>  arch/arm64/kernel/vdso32/Makefile    | 2 +-
>  arch/mips/vdso/Makefile              | 2 +-
>  arch/riscv/kernel/vdso/Makefile      | 2 +-
>  arch/s390/kernel/vdso64/Makefile     | 2 +-
>  arch/sparc/vdso/Makefile             | 2 +-
>  arch/x86/entry/vdso/Makefile         | 2 +-
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)


Applied to linux-kbuild.
Thanks.

-- 
Best Regards
Masahiro Yamada

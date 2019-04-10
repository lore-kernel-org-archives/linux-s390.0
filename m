Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:03:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
In-Reply-To: <20190408212648.2407234-10-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410180357.3290d24f@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:23 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> llvm on s390 has problems with __builtin_return_address(n), with n>0,
> this results in a somewhat cryptic error message:
> 
> fatal error: error in backend: Unsupported stack frame traversal count
> 
> To work around it, use the direct return address directly. This
> is probably not ideal here, but gets things to compile and should
> only lead to inferior reporting, not to misbehavior of the generated
> code.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=41424
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/ftrace.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> index 5a3c95b11952..7923c63946fb 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -13,7 +13,12 @@
> 
>  #ifndef __ASSEMBLY__
> 
> +#ifdef CONFIG_CC_IS_CLANG
> +/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> +#define ftrace_return_address(n) __builtin_return_address(0)
> +#else
>  #define ftrace_return_address(n) __builtin_return_address(n)
> +#endif
> 
>  void _mcount(void);
>  void ftrace_caller(void);

I can say I like this one. If the compiler can not do __builtin_return_address(n)
it feels wrong to just use __builtin_return_address(0).

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

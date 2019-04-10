Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:00:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 08/12] s390: syscall_wrapper: avoid clang warning
In-Reply-To: <20190408212648.2407234-8-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410180044.22fbba3f@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:21 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Building system calls with clang results in a warning
> about an alias from a global function to a static one:
> 
> ../fs/namei.c:3847:1: warning: unused function '__se_sys_mkdirat' [-Wunused-function]
> SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
> ^
> ../include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE3'
>  #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>                                    ^
> ../include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
>         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>         ^
> ../arch/s390/include/asm/syscall_wrapper.h:126:18: note: expanded from macro '__SYSCALL_DEFINEx'
>         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))          \
>                         ^
> <scratch space>:31:1: note: expanded from here
> __se_sys_mkdirat
> ^
> 
> The only reference to the static __se_sys_mkdirat() here is the alias, but
> this only gets evaluated later. Making this function global as well avoids
> the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to s390/linux:features for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

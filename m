Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190116131527.2071570-1-arnd@arndb.de> <20190116131527.2071570-5-arnd@arndb.de>
 <20190117133115.GC18351@osiris>
In-Reply-To: <20190117133115.GC18351@osiris>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Jan 2019 17:23:45 +0100
Message-ID: <CAK8P3a0eY17fM=-wQ0GZKiMxjiLrJaZxUeR__v1G86EfqwYGrA@mail.gmail.com>
Subject: Re: [PATCH 4/5] s390: autogenerate compat syscall wrappers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 17, 2019 at 2:31 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> The patch below is needed as compile fix (allnoconfig).
> I will add this to your patch, no resend needed.

Ok, good catch! This is obviously the right fix.

      Arnd

> diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
> index 27ebe871692f..873e7a7794b3 100644
> --- a/arch/s390/include/asm/syscall_wrapper.h
> +++ b/arch/s390/include/asm/syscall_wrapper.h
> @@ -106,11 +106,10 @@
>         asmlinkage long __s390x_sys_##sname(void)
>
>  #define COND_SYSCALL(name)                                             \
> -       cond_syscall(__s390x_sys_##name)                                \
> -       cond_syscall(__s390_sys_##name)
> +       cond_syscall(__s390x_sys_##name)
>
>  #define SYS_NI(name)                                                   \
> -       SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers);
> +       SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);
>
>  #endif /* CONFIG_COMPAT */
>
>

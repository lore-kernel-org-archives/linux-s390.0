Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/mm: Explicitly compare PAGE_DEFAULT_KEY against zero
 in storage_key_init_range
References: <20200214064207.10381-1-natechancellor@gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Feb 2020 08:34:36 +0100
MIME-Version: 1.0
In-Reply-To: <20200214064207.10381-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e93b8ff2-0203-445c-c226-df482e542cb0@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com



On 14.02.20 07:42, Nathan Chancellor wrote:
> Clang warns:
> 
>  In file included from ../arch/s390/purgatory/purgatory.c:10:
>  In file included from ../include/linux/kexec.h:18:
>  In file included from ../include/linux/crash_core.h:6:
>  In file included from ../include/linux/elfcore.h:5:
>  In file included from ../include/linux/user.h:1:
>  In file included from ../arch/s390/include/asm/user.h:11:
>  ../arch/s390/include/asm/page.h:45:6: warning: converting the result of
>  '<<' to a boolean always evaluates to false
>  [-Wtautological-constant-compare]
>          if (PAGE_DEFAULT_KEY)
>             ^
>  ../arch/s390/include/asm/page.h:23:44: note: expanded from macro
>  'PAGE_DEFAULT_KEY'
>  #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
>                                                   ^
>  1 warning generated.
> 
> Explicitly compare this against zero to silence the warning as it is
> intended to be used in a boolean context.
> 
> Fixes: de3fa841e429 ("s390/mm: fix compile for PAGE_DEFAULT_KEY != 0")
> Link: https://github.com/ClangBuiltLinux/linux/issues/860
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  arch/s390/include/asm/page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
> index 85e944f04c70..1019efd85b9d 100644
> --- a/arch/s390/include/asm/page.h
> +++ b/arch/s390/include/asm/page.h
> @@ -42,7 +42,7 @@ void __storage_key_init_range(unsigned long start, unsigned long end);
>  
>  static inline void storage_key_init_range(unsigned long start, unsigned long end)
>  {
> -	if (PAGE_DEFAULT_KEY)
> +	if (PAGE_DEFAULT_KEY != 0)
>  		__storage_key_init_range(start, end);
>  }
>  
> 

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Tue, 10 May 2016 13:48:06 +0200
Message-ID: <7091358.aJt1stteb5@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <9651510.pg5Vmm8vKS@wuerfel> <5731AE2E.2050403@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5731AE2E.2050403@huawei.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Tuesday 10 May 2016 17:47:26 Zhangjian wrote:
> On 2016/5/10 16:36, Arnd Bergmann wrote:
> > On Tuesday 10 May 2016 15:42:07 Zhangjian wrote:
> >> On 2016/5/6 20:37, Yury Norov wrote:
> 
> "include/uapi/asm-generic/posix_types.h" is uapi, we could not check
> "ARCH_32BIT_OFF_T" here. Besides, the `__kernel_long_t` is long which
> mean it is 32bit in ILP32. should we define something like x32?
>      ```
>      diff --git a/arch/arm64/include/uapi/asm/posix_types.h b/arch/arm64/include/uapi/asm/posix_types.h
>      index 7985ff6..9baa8d3 100644
>      --- a/arch/arm64/include/uapi/asm/posix_types.h
>      +++ b/arch/arm64/include/uapi/asm/posix_types.h

glibc does not use the definition of __kernel_off_t, it has its own
copy, so changing the kernel headers would do nothing.

>      @@ -5,6 +5,9 @@ typedef unsigned short __kernel_old_uid_t;
>       typedef unsigned short __kernel_old_gid_t;
>        #define __kernel_old_uid_t __kernel_old_uid_t
> 
>       +typedef long long __kernel_long_t;
>       +typedef unsigned long long __kernel_ulong_t;
>       +
>        #include <asm-generic/posix_types.h>
> 
>        #endif /*  __ASM_POSIX_TYPES_H */u
>      ```

This would break all sorts of things, because __kernel_long_t/__kernel_ulong_t
are not just used for off_t but also other things.

> 
> On the other hand, glibc define it own off_t in "bits/types.h":
>      __STD_TYPE __OFF_T_TYPE __off_t;        /* Type of file sizes and offsets.  */
>      __STD_TYPE __OFF64_T_TYPE __off64_t;    /* Type of file sizes and offsets (LFS).  */
> 
> in "sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h":
>      #define __OFF_T_TYPE            __SLONGWORD_TYPE
>      #define __OFF64_T_TYPE          __SQUAD_TYPE
> 
> If we define off_t as 64bit in glibc:
>      #define __OFF_T_TYPE           __SQUAD_TYPE
> 
> Should We need to align all the off_t syscall to 64bit syscall in
> kernel?
> 

Yes, this is the change that I think we need to make, along with
the same change for __INO_T_TYPE and 

#define __OFF_T_MATCHES_OFF64_T        1
#define __INO_T_MATCHES_INO64_T        1

If I read the rest of the glibc headers right, that should be all we need
to ensure that both off_t and off64_t match the __kernel_loff_t based
syscalls.

	Arnd

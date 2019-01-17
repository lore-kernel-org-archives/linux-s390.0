Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 17 Jan 2019 14:31:15 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 4/5] s390: autogenerate compat syscall wrappers
References: <20190116131527.2071570-1-arnd@arndb.de>
 <20190116131527.2071570-5-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190116131527.2071570-5-arnd@arndb.de>
Message-Id: <20190117133115.GC18351@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, y2038@lists.linaro.org, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 16, 2019 at 02:15:22PM +0100, Arnd Bergmann wrote:
> Any system call that takes a pointer argument on s390 requires
> a wrapper function to do a 31-to-64 zero-extension, these are
> currently generated in arch/s390/kernel/compat_wrapper.c.
> 
> On arm64 and x86, we already generate similar wrappers for all
> system calls in the place of their definition, just for a different
> purpose (they load the arguments from pt_regs).
> 
> We can do the same thing here, by adding an asm/syscall_wrapper.h
> file with a copy of all the relevant macros to override the generic
> version. Besides the addition of the compat entry point, these also
> rename the entry points with a __s390_ or __s390x_ prefix, similar
> to what we do on arm64 and x86. This in turn requires renaming
> a few things, and adding a proper ni_syscall() entry point.
> 
> In order to still compile system call definitions that pass an
> loff_t argument, the __SC_COMPAT_CAST() macro checks for that
> and forces an -ENOSYS error, which was the best I could come up
> with. Those functions must obviously not get called from user
> space, but instead require hand-written compat_sys_*() handlers,
> which fortunately already exist.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig                       |   1 +
>  arch/s390/include/asm/syscall_wrapper.h | 136 ++++++++++++++++++++++++
>  arch/s390/kernel/compat_wrapper.c       |  23 +---
>  arch/s390/kernel/entry.S                |   4 +-
>  arch/s390/kernel/sys_s390.c             |   5 +
>  5 files changed, 148 insertions(+), 21 deletions(-)
>  create mode 100644 arch/s390/include/asm/syscall_wrapper.h

The patch below is needed as compile fix (allnoconfig).
I will add this to your patch, no resend needed.

diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 27ebe871692f..873e7a7794b3 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -106,11 +106,10 @@
 	asmlinkage long __s390x_sys_##sname(void)
 
 #define COND_SYSCALL(name)						\
-	cond_syscall(__s390x_sys_##name)				\
-	cond_syscall(__s390_sys_##name)
+	cond_syscall(__s390x_sys_##name)
 
 #define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers);
+	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);
 
 #endif /* CONFIG_COMPAT */
 

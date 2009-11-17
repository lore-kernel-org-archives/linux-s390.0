From: Eric Paris <eparis@redhat.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Date: Tue, 17 Nov 2009 10:23:56 -0500
Message-ID: <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
	 <4B0291BB.3090005@in.ibm.com>
	 <20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
	 <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
	 <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2009-11-17 at 14:55 +0100, Heiko Carstens wrote:

> Yes, also some places should have used lgfr instead of llgfr for proper sign
> extension. But please, just drop the s390 bits from your patch.
> Its easier and less painful for us to do it ourselves instead of reviewing
> and fixing these things. (No offence intended!).

dropped and won't show up in -next tomorrow.

This what I thought it should be and would love to read if you say it's
right....

diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index cb5232d..8962161 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -269,7 +269,9 @@
 #define	__NR_pwritev		329
 #define __NR_rt_tgsigqueueinfo	330
 #define __NR_perf_event_open	331
-#define NR_syscalls 332
+#define __NR_fanotify_init	332
+#define __NR_fanotify_mark	333
+#define NR_syscalls 334
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index cbd9901..c81723d 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1855,3 +1855,20 @@ sys32_execve_wrapper:
 	llgtr	%r3,%r3			# compat_uptr_t *
 	llgtr	%r4,%r4			# compat_uptr_t *
 	jg	sys32_execve		# branch to system call
+
+	.globl	sys_fanotify_init_wrapper
+sys_fanotify_init_wrapper:
+	llgfr	%r2,%r2			# unsigned int
+	llgfr	%r3,%r3			# unsigned int
+	llgfr	%r4,%r4			# unsigned int
+	jg	sys_fanotify_init	# branch to system call
+
+	.globl	sys32_fanotify_mark_wrapper
+sys32_fanotify_mark_wrapper:
+	lgfr	%r2,%r2			# int
+	llgfr	%r3,%r3			# unsigned int
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# char *
+	sllg	%r6,%r6,32		# get high word of 64bit mask
+	l	%r6,164(%r15)		# get low word of 64bit mask
+	jg	sys_fanotify_mark
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 30eca07..cc781f1 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -340,3 +340,5 @@ SYSCALL(sys_preadv,sys_preadv,compat_sys_preadv_wrapper)
 SYSCALL(sys_pwritev,sys_pwritev,compat_sys_pwritev_wrapper)
 SYSCALL(sys_rt_tgsigqueueinfo,sys_rt_tgsigqueueinfo,compat_sys_rt_tgsigqueueinfo_wrapper) /* 330 */
 SYSCALL(sys_perf_event_open,sys_perf_event_open,sys_perf_event_open_wrapper)
+SYSCALL(sys_fanotify_init,sys_fanotify_init,sys_fanotify_init_wrapper)
+SYSCALL(sys_fanotify_mark,sys_fanotify_mark,sys32_fanotify_mark_wrapper)

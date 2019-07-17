Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGQB3T (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jul 2019 21:29:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so1069319pgj.0
        for <linux-s390@vger.kernel.org>; Tue, 16 Jul 2019 18:29:19 -0700 (PDT)
Subject: [PATCH v2 4/4] tools: Add fchmodat4
Date: Tue, 16 Jul 2019 18:27:19 -0700
Message-Id: <20190717012719.5524-5-palmer@sifive.com>
In-Reply-To: <20190717012719.5524-1-palmer@sifive.com>
References: <20190717012719.5524-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, James.Bottomley@HansenPartnership.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, peterz@infradead.org, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, Palmer Dabbelt <palmer@sifive.com>, dhowells@redhat.com, firoz.khan@linaro.org, stefan@agner.ch, schwidefsky@de.ibm.com, axboe@kernel.dk, christian@brauner.io, hare@suse.com, deepa.kernel@gmail.com, tycho@tycho.ws, kim.phillips@arm.com, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

I'm not sure why it's necessary to add this explicitly to tools/ as well
as arch/, but there were a few instances of fspick in here so I blindly
added fchmodat4 in the same fashion.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 tools/include/uapi/asm-generic/unistd.h           | 4 +++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a87904daf103..36232ea94956 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_fchmodat4 434
+__SYSCALL(__NR_fchmodat4, sys_fchmodat4)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..b92d5b195e66 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	fchmodat4		__x64_sys_fchmodat4
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
2.21.0

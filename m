Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:6283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729389AbgFRLDd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jun 2020 07:03:33 -0400
From: Xiaoming Ni <nixiaoming@huawei.com>
Subject: [PATCH] s390: fix build error for sys_call_table_emu
Date: Thu, 18 Jun 2020 19:03:20 +0800
Message-ID: <20200618110320.104013-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: acme@kernel.org, alexander.shishkin@linux.intel.com, arnd@arndb.de, borntraeger@de.ibm.com, catalin.marinas@arm.com, christian@brauner.io, cyphar@cyphar.com, dhowells@redhat.com, ebiederm@xmission.com, fenghua.yu@intel.com, geert@linux-m68k.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, ink@jurassic.park.msu.ru, jolsa@redhat.com, linux@armlinux.org.uk, lkp@intel.com, mark.rutland@arm.com, mattst88@gmail.com, minchan@kernel.org, mingo@redhat.com, monstr@monstr.eu, namhyung@kernel.org, nixiaoming@huawei.com, peterz@infradead.org, rth@twiddle.net, sargun@sargun.me, sfr@canb.auug.org.au, tony.luck@intel.com, will@kernel.org, akpm@linux-foundation.org
Cc: alex.huangjianhui@huawei.com, zhongjubin@huawei.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, clang-built-linux@googlegroups.com, kbuild-all@lists.01.org, linux-mm@kvack.org

Build error on s390:
	arch/s390/kernel/entry.o: in function `sys_call_table_emu':
	>> (.rodata+0x1288): undefined reference to `__s390_'

In commit ("All arch: remove system call sys_sysctl")
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
-149  common	_sysctl			sys_sysctl			compat_sys_sysctl
+149  common	_sysctl			sys_ni_syscall
 150  common	mlock			sys_mlock			sys_mlock

After the patch is integrated, there is a format error in the generated
arch/s390/include/generated/asm/syscall_table.h:
	SYSCALL(sys_fdatasync, sys_fdatasync)
	SYSCALL(sys_ni_syscall,) /* cause build error */
	SYSCALL(sys_mlock,sys_mlock)

There are holes in the system call number in
 arch/s390/kernel/syscalls/syscall.tbl. When generating syscall_table.h,
these hole numbers will be automatically filled with "NI_SYSCALL".
Therefore, delete the number 149 to fix the current compilation failure.
 Similarly, modify tools/perf/arch/s390/entry/syscalls/syscall.tbl.

Fixes: ("All arch: remove system call sys_sysctl")
Fixes: https://lore.kernel.org/linuxppc-dev/20200616030734.87257-1-nixiaoming@huawei.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 arch/s390/kernel/syscalls/syscall.tbl           | 1 -
 tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index f17aaf6fe5de..bcaf93994e3c 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -138,7 +138,6 @@
 146  common	writev			sys_writev			compat_sys_writev
 147  common	getsid			sys_getsid			sys_getsid
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
-149  common	_sysctl			sys_ni_syscall
 150  common	mlock			sys_mlock			sys_mlock
 151  common	munlock			sys_munlock			sys_munlock
 152  common	mlockall		sys_mlockall			sys_mlockall
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 0193f9b98753..eb77d0d01d8f 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -138,7 +138,6 @@
 146  common	writev			sys_writev			compat_sys_writev
 147  common	getsid			sys_getsid			sys_getsid
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
-149  common	_sysctl			sys_ni_syscall
 150  common	mlock			sys_mlock			compat_sys_mlock
 151  common	munlock			sys_munlock			compat_sys_munlock
 152  common	mlockall		sys_mlockall			sys_mlockall
-- 
2.27.0

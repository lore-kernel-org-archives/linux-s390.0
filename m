Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE8334C1B;
	Mon, 10 Nov 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800894; cv=none; b=QC7lZuw7Ehbrzq0Xt+Oirp9mooUGhCuuZI3ZhBjCT+9WDrocQfDJ16kBPEs6OLuefhnLMtxAib6LHrHTY/NMZZJ5/M6j8kKIDD7pXFQPcHnCBZre1540hCuhFss04up5JnHk8b87e9n6N5Ms/9Dyq4nRfSKDI+v2x8joq71k53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800894; c=relaxed/simple;
	bh=Bn0mepK25pHA+hkCnP4hbLPRs9q6HO0R9sCmNikzyN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi+7U3aWhUkMHkhucBLyUpDXcYiETYqggjnApGOdmv4Keh9qTlDjfxzP4Ln9KDaTCfMNwUEYdWpDVMc/SPivFZ+wA//o+AcanCqf6yyPY3tkFZsLpxP/3WYkmkSvInolzrHhIxHx8n+DephNMIZ2y7VR1Bt+NYIXbwBt0+87t4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GnBmeVbe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GnBmeVbe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA8fWjB000920;
	Mon, 10 Nov 2025 18:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XJ6D1PZzxiVmBKyjd
	KzuD5SH8pDYlVEiFX6t9ArN4QM=; b=GnBmeVbeCsGe7/0E0y8uekUDb32F0JJrr
	wdctuBssjpbanKOl5h5UROmyDaOQ+UiLEP9Ps1mzKg0ovXFmI4NEvDeNpD90Xydo
	Zt30TO0pEjSizfcRP6DDfwpvO7z8lkXNXJ1biPzh8FpnLRVu9jbNlQFknFz5kjY2
	yDf8SP34IG6DNBZG8DnnU1hgCQ7yEtyw1FbPuxboAPwLT0ircsktVjs4AjoBC6F4
	s/UT7UHNwSJxL4MSyb0OlOETh0zV9JblrHp0lRHIXjFJ6U3M2dVyq1Hkp7GsunWy
	SoOQYfffkele0hpF6FV4TKyAls8DOcH9Rl2vzF2YSkWwUM1dfaq1A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7yyfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGM2xP004726;
	Mon, 10 Nov 2025 18:54:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxq89x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAIsgZT43385132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:54:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC8F20040;
	Mon, 10 Nov 2025 18:54:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 484B72004B;
	Mon, 10 Nov 2025 18:54:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 18:54:42 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 8/8] s390/syscalls: Switch to generic system call table generation
Date: Mon, 10 Nov 2025 19:54:40 +0100
Message-ID: <20251110185440.2667511-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110185440.2667511-1-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=691234f7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=BoF0dP3RD9xWtoqPa1YA:9
X-Proofpoint-GUID: SGuEFuZOhHQ3t7nclEHJda8Ce28BZ6ja
X-Proofpoint-ORIG-GUID: SGuEFuZOhHQ3t7nclEHJda8Ce28BZ6ja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX4dMgC9Y8dY46
 AI8Z4sT88Xk5B8xiRC4Sj7kL33gNVvUQxDwcapEVO2wLESSrKjgPlIHAI/ZCRNRPBfZgHu9xZkQ
 bnVz60Id5G/FQzkQ+nsxAGUdDSG3VifC29TbdCL9WWjWTEWWogq4FhsV5fuXJkkO0fG9lrIIIzI
 DijNcIS9Tm/Cp/L98xlC4NP2sTnekZAzP3RRR/3tSU9kPKwHWuIGKhcS6SB+XQzc5FuDIjYCtwu
 5Qkm9lm9GF/kHCJvOaWpfA2y4hH3wuR/iK3aOAa2fcOZnp4ITZGs+/qw3nW1wwajVEspzEDz9Nx
 XTLOu8HzO18G8VOhp7TO6eK397InNFcxwvQgB3V7BdxcjbLm1aDWiXcH5HmbHsq7MSjsVCayapb
 8gU5GMGiXzBkArjRWehq5vkmF6yeKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

The s390 syscall.tbl format differs slightly from most others, and
therefore requires an s390 specific system call table generation
script.

With compat support gone use the opportunity to switch to generic
system call table generation. The abi for all 64 bit system calls is
now common, since there is no need to specify if system call entry
points are only for 64 bit anymore.

Furthermore create the system call table in C instead of assembler
code in order to get type checking for all system call functions
contained within the table.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Makefile                    |   3 +-
 arch/s390/include/asm/unistd.h        |   3 +-
 arch/s390/kernel/entry.S              |   8 -
 arch/s390/kernel/syscall.c            |  10 +
 arch/s390/kernel/syscalls/Makefile    |  58 +-
 arch/s390/kernel/syscalls/syscall.tbl | 856 ++++++++++++--------------
 arch/s390/kernel/syscalls/syscalltbl  | 232 -------
 7 files changed, 424 insertions(+), 746 deletions(-)
 delete mode 100755 arch/s390/kernel/syscalls/syscalltbl

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index f41b8c5c4e56..bf53e7d1487a 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -134,10 +134,9 @@ zfcpdump:
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archheaders:
-	$(Q)$(MAKE) $(build)=$(syscalls) uapi
+	$(Q)$(MAKE) $(build)=$(syscalls) all
 
 archprepare:
-	$(Q)$(MAKE) $(build)=$(syscalls) kapi
 	$(Q)$(MAKE) $(build)=$(tools) kapi $(extra_tools)
 ifeq ($(KBUILD_EXTMOD),)
 # We need to generate vdso-offsets.h before compiling certain files in kernel/.
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 252d7ac7a6b2..921c3fb3586b 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -8,7 +8,8 @@
 #define _ASM_S390_UNISTD_H_
 
 #include <uapi/asm/unistd.h>
-#include <asm/unistd_nr.h>
+
+#define NR_syscalls (__NR_syscalls)
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 3c7f183a945d..1e266c0eae2c 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -606,11 +606,3 @@ SYM_DATA_START_LOCAL(daton_psw)
 	.quad	PSW_KERNEL_BITS
 	.quad	.Ldaton
 SYM_DATA_END(daton_psw)
-
-	.section .rodata, "a"
-	.balign	8
-#define SYSCALL(esame,emu)	.quad __s390x_ ## esame
-SYM_DATA_START(sys_call_table)
-#include <asm/syscall_table.h>
-SYM_DATA_END(sys_call_table)
-#undef SYSCALL
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index 3b7ea1ef468a..795b6cca74c9 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -39,6 +39,16 @@
 
 #include "entry.h"
 
+#define __SYSCALL(nr, sym) long __s390x_##sym(struct pt_regs *);
+#include <asm/syscall_table.h>
+#undef __SYSCALL
+
+#define __SYSCALL(nr, sym) [nr] = (__s390x_##sym),
+const sys_call_ptr_t sys_call_table[__NR_syscalls] = {
+#include <asm/syscall_table.h>
+};
+#undef __SYSCALL
+
 #ifdef CONFIG_SYSVIPC
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls.
diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index c5d958a09ff4..d5fca0ca0890 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -1,48 +1,32 @@
 # SPDX-License-Identifier: GPL-2.0
+kapi := arch/$(SRCARCH)/include/generated/asm
+uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-gen	:= arch/$(ARCH)/include/generated
-kapi	:= $(gen)/asm
-uapi	:= $(gen)/uapi/asm
-
-syscall	:= $(src)/syscall.tbl
-systbl	:= $(src)/syscalltbl
-
-gen-y := $(kapi)/syscall_table.h
-kapi-hdrs-y := $(kapi)/unistd_nr.h
-uapi-hdrs-y := $(uapi)/unistd_32.h
-uapi-hdrs-y += $(uapi)/unistd_64.h
-
-targets += $(addprefix ../../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))
-
-PHONY += kapi uapi
-
-kapi:	$(gen-y) $(kapi-hdrs-y)
-uapi:	$(uapi-hdrs-y)
-
-
-# Create output directory if not already present
 $(shell mkdir -p $(uapi) $(kapi))
 
+syscall := $(src)/syscall.tbl
+syshdr := $(srctree)/scripts/syscallhdr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
+
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$@" < $< > $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis common,$* $< $@
 
-quiet_cmd_sysnr = SYSNR   $@
-      cmd_sysnr = $(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget)) < $< > $@
+quiet_cmd_systbl = SYSTBL  $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
 
-quiet_cmd_syscalls = SYSTBL  $@
-      cmd_syscalls = $(CONFIG_SHELL) '$(systbl)' -S < $< > $@
-
-syshdr_abi_unistd_32 := common,32
-$(uapi)/unistd_32.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,syshdr)
-
-syshdr_abi_unistd_64 := common,64
-$(uapi)/unistd_64.h: $(syscall) $(systbl) FORCE
+$(uapi)/unistd_%.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 $(kapi)/syscall_table.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,syscalls)
+	$(call if_changed,systbl)
 
-sysnr_abi_unistd_nr := common,32,64
-$(kapi)/unistd_nr.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,sysnr)
+uapisyshdr-y		+= unistd_64.h
+kapisyshdr-y		+= syscall_table.h
+
+uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
+kapisyshdr-y	:= $(addprefix $(kapi)/, $(kapisyshdr-y))
+targets		+= $(addprefix ../../../../, $(uapisyshdr-y) $(kapisyshdr-y))
+
+PHONY += all
+all: $(uapisyshdr-y) $(kapisyshdr-y)
+	@:
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 8a6744d658db..e07b49262b9a 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -3,472 +3,396 @@
 # System call table for s390
 #
 # Format:
+# <nr> <abi> <syscall> <entry>
 #
-# <nr> <abi> <syscall> <entry-64bit> <compat-entry>
-#
-# where <abi> can be common, 64, or 32
+# The <abi> is always common.
 
-1    common	exit			sys_exit			sys_exit
-2    common	fork			sys_fork			sys_fork
-3    common	read			sys_read			compat_sys_s390_read
-4    common	write			sys_write			compat_sys_s390_write
-5    common	open			sys_open			compat_sys_open
-6    common	close			sys_close			sys_close
-7    common	restart_syscall		sys_restart_syscall		sys_restart_syscall
-8    common	creat			sys_creat			sys_creat
-9    common	link			sys_link			sys_link
-10   common	unlink			sys_unlink			sys_unlink
-11   common	execve			sys_execve			compat_sys_execve
-12   common	chdir			sys_chdir			sys_chdir
-13   32		time			-				sys_time32
-14   common	mknod			sys_mknod			sys_mknod
-15   common	chmod			sys_chmod			sys_chmod
-16   32		lchown			-				sys_lchown16
-19   common	lseek			sys_lseek			compat_sys_lseek
-20   common	getpid			sys_getpid			sys_getpid
-21   common	mount			sys_mount			sys_mount
-22   common	umount			sys_oldumount			sys_oldumount
-23   32		setuid			-				sys_setuid16
-24   32		getuid			-				sys_getuid16
-25   32		stime			-				sys_stime32
-26   common	ptrace			sys_ptrace			compat_sys_ptrace
-27   common	alarm			sys_alarm			sys_alarm
-29   common	pause			sys_pause			sys_pause
-30   common	utime			sys_utime			sys_utime32
-33   common	access			sys_access			sys_access
-34   common	nice			sys_nice			sys_nice
-36   common	sync			sys_sync			sys_sync
-37   common	kill			sys_kill			sys_kill
-38   common	rename			sys_rename			sys_rename
-39   common	mkdir			sys_mkdir			sys_mkdir
-40   common	rmdir			sys_rmdir			sys_rmdir
-41   common	dup			sys_dup				sys_dup
-42   common	pipe			sys_pipe			sys_pipe
-43   common	times			sys_times			compat_sys_times
-45   common	brk			sys_brk				sys_brk
-46   32		setgid			-				sys_setgid16
-47   32		getgid			-				sys_getgid16
-48   common	signal			sys_signal			sys_signal
-49   32		geteuid			-				sys_geteuid16
-50   32		getegid			-				sys_getegid16
-51   common	acct			sys_acct			sys_acct
-52   common	umount2			sys_umount			sys_umount
-54   common	ioctl			sys_ioctl			compat_sys_ioctl
-55   common	fcntl			sys_fcntl			compat_sys_fcntl
-57   common	setpgid			sys_setpgid			sys_setpgid
-60   common	umask			sys_umask			sys_umask
-61   common	chroot			sys_chroot			sys_chroot
-62   common	ustat			sys_ustat			compat_sys_ustat
-63   common	dup2			sys_dup2			sys_dup2
-64   common	getppid			sys_getppid			sys_getppid
-65   common	getpgrp			sys_getpgrp			sys_getpgrp
-66   common	setsid			sys_setsid			sys_setsid
-67   common	sigaction		sys_sigaction			compat_sys_sigaction
-70   32		setreuid		-				sys_setreuid16
-71   32		setregid		-				sys_setregid16
-72   common	sigsuspend		sys_sigsuspend			sys_sigsuspend
-73   common	sigpending		sys_sigpending			compat_sys_sigpending
-74   common	sethostname		sys_sethostname			sys_sethostname
-75   common	setrlimit		sys_setrlimit			compat_sys_setrlimit
-76   32		getrlimit		-				compat_sys_old_getrlimit
-77   common	getrusage		sys_getrusage			compat_sys_getrusage
-78   common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
-79   common	settimeofday		sys_settimeofday		compat_sys_settimeofday
-80   32		getgroups		-				sys_getgroups16
-81   32		setgroups		-				sys_setgroups16
-83   common	symlink			sys_symlink			sys_symlink
-85   common	readlink		sys_readlink			sys_readlink
-86   common	uselib			sys_uselib			sys_uselib
-87   common	swapon			sys_swapon			sys_swapon
-88   common	reboot			sys_reboot			sys_reboot
-89   common	readdir			-				compat_sys_old_readdir
-90   common	mmap			sys_old_mmap			compat_sys_s390_old_mmap
-91   common	munmap			sys_munmap			sys_munmap
-92   common	truncate		sys_truncate			compat_sys_truncate
-93   common	ftruncate		sys_ftruncate			compat_sys_ftruncate
-94   common	fchmod			sys_fchmod			sys_fchmod
-95   32		fchown			-				sys_fchown16
-96   common	getpriority		sys_getpriority			sys_getpriority
-97   common	setpriority		sys_setpriority			sys_setpriority
-99   common	statfs			sys_statfs			compat_sys_statfs
-100  common	fstatfs			sys_fstatfs			compat_sys_fstatfs
-101  32		ioperm			-				-
-102  common	socketcall		sys_socketcall			compat_sys_socketcall
-103  common	syslog			sys_syslog			sys_syslog
-104  common	setitimer		sys_setitimer			compat_sys_setitimer
-105  common	getitimer		sys_getitimer			compat_sys_getitimer
-106  common	stat			sys_newstat			compat_sys_newstat
-107  common	lstat			sys_newlstat			compat_sys_newlstat
-108  common	fstat			sys_newfstat			compat_sys_newfstat
-110  common	lookup_dcookie		-				-
-111  common	vhangup			sys_vhangup			sys_vhangup
-112  common	idle			-				-
-114  common	wait4			sys_wait4			compat_sys_wait4
-115  common	swapoff			sys_swapoff			sys_swapoff
-116  common	sysinfo			sys_sysinfo			compat_sys_sysinfo
-117  common	ipc			sys_s390_ipc			compat_sys_s390_ipc
-118  common	fsync			sys_fsync			sys_fsync
-119  common	sigreturn		sys_sigreturn			compat_sys_sigreturn
-120  common	clone			sys_clone			sys_clone
-121  common	setdomainname		sys_setdomainname		sys_setdomainname
-122  common	uname			sys_newuname			sys_newuname
-124  common	adjtimex		sys_adjtimex			sys_adjtimex_time32
-125  common	mprotect		sys_mprotect			sys_mprotect
-126  common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
-127  common	create_module		-				-
-128  common	init_module		sys_init_module			sys_init_module
-129  common	delete_module		sys_delete_module		sys_delete_module
-130  common	get_kernel_syms		-				-
-131  common	quotactl		sys_quotactl			sys_quotactl
-132  common	getpgid			sys_getpgid			sys_getpgid
-133  common	fchdir			sys_fchdir			sys_fchdir
-134  common	bdflush			sys_ni_syscall			sys_ni_syscall
-135  common	sysfs			sys_sysfs			sys_sysfs
-136  common	personality		sys_s390_personality		sys_s390_personality
-137  common	afs_syscall		-				-
-138  32		setfsuid		-				sys_setfsuid16
-139  32		setfsgid		-				sys_setfsgid16
-140  32		_llseek			-				sys_llseek
-141  common	getdents		sys_getdents			compat_sys_getdents
-142  32		_newselect		-				compat_sys_select
-142  64		select			sys_select			-
-143  common	flock			sys_flock			sys_flock
-144  common	msync			sys_msync			sys_msync
-145  common	readv			sys_readv			sys_readv
-146  common	writev			sys_writev			sys_writev
-147  common	getsid			sys_getsid			sys_getsid
-148  common	fdatasync		sys_fdatasync			sys_fdatasync
-149  common	_sysctl			-				-
-150  common	mlock			sys_mlock			sys_mlock
-151  common	munlock			sys_munlock			sys_munlock
-152  common	mlockall		sys_mlockall			sys_mlockall
-153  common	munlockall		sys_munlockall			sys_munlockall
-154  common	sched_setparam		sys_sched_setparam		sys_sched_setparam
-155  common	sched_getparam		sys_sched_getparam		sys_sched_getparam
-156  common	sched_setscheduler	sys_sched_setscheduler		sys_sched_setscheduler
-157  common	sched_getscheduler	sys_sched_getscheduler		sys_sched_getscheduler
-158  common	sched_yield		sys_sched_yield			sys_sched_yield
-159  common	sched_get_priority_max	sys_sched_get_priority_max	sys_sched_get_priority_max
-160  common	sched_get_priority_min	sys_sched_get_priority_min	sys_sched_get_priority_min
-161  common	sched_rr_get_interval	sys_sched_rr_get_interval	sys_sched_rr_get_interval_time32
-162  common	nanosleep		sys_nanosleep			sys_nanosleep_time32
-163  common	mremap			sys_mremap			sys_mremap
-164  32		setresuid		-				sys_setresuid16
-165  32		getresuid		-				sys_getresuid16
-167  common	query_module		-				-
-168  common	poll			sys_poll			sys_poll
-169  common	nfsservctl		-				-
-170  32		setresgid		-				sys_setresgid16
-171  32		getresgid		-				sys_getresgid16
-172  common	prctl			sys_prctl			sys_prctl
-173  common	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
-174  common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
-175  common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
-176  common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
-177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time32
-178  common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-179  common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-180  common	pread64			sys_pread64			compat_sys_s390_pread64
-181  common	pwrite64		sys_pwrite64			compat_sys_s390_pwrite64
-182  32		chown			-				sys_chown16
-183  common	getcwd			sys_getcwd			sys_getcwd
-184  common	capget			sys_capget			sys_capget
-185  common	capset			sys_capset			sys_capset
-186  common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
-187  common	sendfile		sys_sendfile64			compat_sys_sendfile
-188  common	getpmsg			-				-
-189  common	putpmsg			-				-
-190  common	vfork			sys_vfork			sys_vfork
-191  32		ugetrlimit		-				compat_sys_getrlimit
-191  64		getrlimit		sys_getrlimit			-
-192  32		mmap2			-				compat_sys_s390_mmap2
-193  32		truncate64		-				compat_sys_s390_truncate64
-194  32		ftruncate64		-				compat_sys_s390_ftruncate64
-195  32		stat64			-				compat_sys_s390_stat64
-196  32		lstat64			-				compat_sys_s390_lstat64
-197  32		fstat64			-				compat_sys_s390_fstat64
-198  32		lchown32		-				sys_lchown
-198  64		lchown			sys_lchown			-
-199  32		getuid32		-				sys_getuid
-199  64		getuid			sys_getuid			-
-200  32		getgid32		-				sys_getgid
-200  64		getgid			sys_getgid			-
-201  32		geteuid32		-				sys_geteuid
-201  64		geteuid			sys_geteuid			-
-202  32		getegid32		-				sys_getegid
-202  64		getegid			sys_getegid			-
-203  32		setreuid32		-				sys_setreuid
-203  64		setreuid		sys_setreuid			-
-204  32		setregid32		-				sys_setregid
-204  64		setregid		sys_setregid			-
-205  32		getgroups32		-				sys_getgroups
-205  64		getgroups		sys_getgroups			-
-206  32		setgroups32		-				sys_setgroups
-206  64		setgroups		sys_setgroups			-
-207  32		fchown32		-				sys_fchown
-207  64		fchown			sys_fchown			-
-208  32		setresuid32		-				sys_setresuid
-208  64		setresuid		sys_setresuid			-
-209  32		getresuid32		-				sys_getresuid
-209  64		getresuid		sys_getresuid			-
-210  32		setresgid32		-				sys_setresgid
-210  64		setresgid		sys_setresgid			-
-211  32		getresgid32		-				sys_getresgid
-211  64		getresgid		sys_getresgid			-
-212  32		chown32			-				sys_chown
-212  64		chown			sys_chown			-
-213  32		setuid32		-				sys_setuid
-213  64		setuid			sys_setuid			-
-214  32		setgid32		-				sys_setgid
-214  64		setgid			sys_setgid			-
-215  32		setfsuid32		-				sys_setfsuid
-215  64		setfsuid		sys_setfsuid			-
-216  32		setfsgid32		-				sys_setfsgid
-216  64		setfsgid		sys_setfsgid			-
-217  common	pivot_root		sys_pivot_root			sys_pivot_root
-218  common	mincore			sys_mincore			sys_mincore
-219  common	madvise			sys_madvise			sys_madvise
-220  common	getdents64		sys_getdents64			sys_getdents64
-221  32		fcntl64			-				compat_sys_fcntl64
-222  common	readahead		sys_readahead			compat_sys_s390_readahead
-223  32		sendfile64		-				compat_sys_sendfile64
-224  common	setxattr		sys_setxattr			sys_setxattr
-225  common	lsetxattr		sys_lsetxattr			sys_lsetxattr
-226  common	fsetxattr		sys_fsetxattr			sys_fsetxattr
-227  common	getxattr		sys_getxattr			sys_getxattr
-228  common	lgetxattr		sys_lgetxattr			sys_lgetxattr
-229  common	fgetxattr		sys_fgetxattr			sys_fgetxattr
-230  common	listxattr		sys_listxattr			sys_listxattr
-231  common	llistxattr		sys_llistxattr			sys_llistxattr
-232  common	flistxattr		sys_flistxattr			sys_flistxattr
-233  common	removexattr		sys_removexattr			sys_removexattr
-234  common	lremovexattr		sys_lremovexattr		sys_lremovexattr
-235  common	fremovexattr		sys_fremovexattr		sys_fremovexattr
-236  common	gettid			sys_gettid			sys_gettid
-237  common	tkill			sys_tkill			sys_tkill
-238  common	futex			sys_futex			sys_futex_time32
-239  common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
-240  common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
-241  common	tgkill			sys_tgkill			sys_tgkill
-243  common	io_setup		sys_io_setup			compat_sys_io_setup
-244  common	io_destroy		sys_io_destroy			sys_io_destroy
-245  common	io_getevents		sys_io_getevents		sys_io_getevents_time32
-246  common	io_submit		sys_io_submit			compat_sys_io_submit
-247  common	io_cancel		sys_io_cancel			sys_io_cancel
-248  common	exit_group		sys_exit_group			sys_exit_group
-249  common	epoll_create		sys_epoll_create		sys_epoll_create
-250  common	epoll_ctl		sys_epoll_ctl			sys_epoll_ctl
-251  common	epoll_wait		sys_epoll_wait			sys_epoll_wait
-252  common	set_tid_address		sys_set_tid_address		sys_set_tid_address
-253  common	fadvise64		sys_fadvise64_64		compat_sys_s390_fadvise64
-254  common	timer_create		sys_timer_create		compat_sys_timer_create
-255  common	timer_settime		sys_timer_settime		sys_timer_settime32
-256  common	timer_gettime		sys_timer_gettime		sys_timer_gettime32
-257  common	timer_getoverrun	sys_timer_getoverrun		sys_timer_getoverrun
-258  common	timer_delete		sys_timer_delete		sys_timer_delete
-259  common	clock_settime		sys_clock_settime		sys_clock_settime32
-260  common	clock_gettime		sys_clock_gettime		sys_clock_gettime32
-261  common	clock_getres		sys_clock_getres		sys_clock_getres_time32
-262  common	clock_nanosleep		sys_clock_nanosleep		sys_clock_nanosleep_time32
-264  32		fadvise64_64		-				compat_sys_s390_fadvise64_64
-265  common	statfs64		sys_statfs64			compat_sys_statfs64
-266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
-267  common	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
-268  common	mbind			sys_mbind			sys_mbind
-269  common	get_mempolicy		sys_get_mempolicy		sys_get_mempolicy
-270  common	set_mempolicy		sys_set_mempolicy		sys_set_mempolicy
-271  common	mq_open			sys_mq_open			compat_sys_mq_open
-272  common	mq_unlink		sys_mq_unlink			sys_mq_unlink
-273  common	mq_timedsend		sys_mq_timedsend		sys_mq_timedsend_time32
-274  common	mq_timedreceive		sys_mq_timedreceive		sys_mq_timedreceive_time32
-275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
-276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
-277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
-278  common	add_key			sys_add_key			sys_add_key
-279  common	request_key		sys_request_key			sys_request_key
-280  common	keyctl			sys_keyctl			compat_sys_keyctl
-281  common	waitid			sys_waitid			compat_sys_waitid
-282  common	ioprio_set		sys_ioprio_set			sys_ioprio_set
-283  common	ioprio_get		sys_ioprio_get			sys_ioprio_get
-284  common	inotify_init		sys_inotify_init		sys_inotify_init
-285  common	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
-286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
-287  common	migrate_pages		sys_migrate_pages		sys_migrate_pages
-288  common	openat			sys_openat			compat_sys_openat
-289  common	mkdirat			sys_mkdirat			sys_mkdirat
-290  common	mknodat			sys_mknodat			sys_mknodat
-291  common	fchownat		sys_fchownat			sys_fchownat
-292  common	futimesat		sys_futimesat			sys_futimesat_time32
-293  32		fstatat64		-				compat_sys_s390_fstatat64
-293  64		newfstatat		sys_newfstatat			-
-294  common	unlinkat		sys_unlinkat			sys_unlinkat
-295  common	renameat		sys_renameat			sys_renameat
-296  common	linkat			sys_linkat			sys_linkat
-297  common	symlinkat		sys_symlinkat			sys_symlinkat
-298  common	readlinkat		sys_readlinkat			sys_readlinkat
-299  common	fchmodat		sys_fchmodat			sys_fchmodat
-300  common	faccessat		sys_faccessat			sys_faccessat
-301  common	pselect6		sys_pselect6			compat_sys_pselect6_time32
-302  common	ppoll			sys_ppoll			compat_sys_ppoll_time32
-303  common	unshare			sys_unshare			sys_unshare
-304  common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
-305  common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
-306  common	splice			sys_splice			sys_splice
-307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
-308  common	tee			sys_tee				sys_tee
-309  common	vmsplice		sys_vmsplice			sys_vmsplice
-310  common	move_pages		sys_move_pages			sys_move_pages
-311  common	getcpu			sys_getcpu			sys_getcpu
-312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
-313  common	utimes			sys_utimes			sys_utimes_time32
-314  common	fallocate		sys_fallocate			compat_sys_s390_fallocate
-315  common	utimensat		sys_utimensat			sys_utimensat_time32
-316  common	signalfd		sys_signalfd			compat_sys_signalfd
-317  common	timerfd			-				-
-318  common	eventfd			sys_eventfd			sys_eventfd
-319  common	timerfd_create		sys_timerfd_create		sys_timerfd_create
-320  common	timerfd_settime		sys_timerfd_settime		sys_timerfd_settime32
-321  common	timerfd_gettime		sys_timerfd_gettime		sys_timerfd_gettime32
-322  common	signalfd4		sys_signalfd4			compat_sys_signalfd4
-323  common	eventfd2		sys_eventfd2			sys_eventfd2
-324  common	inotify_init1		sys_inotify_init1		sys_inotify_init1
-325  common	pipe2			sys_pipe2			sys_pipe2
-326  common	dup3			sys_dup3			sys_dup3
-327  common	epoll_create1		sys_epoll_create1		sys_epoll_create1
-328  common	preadv			sys_preadv			compat_sys_preadv
-329  common	pwritev			sys_pwritev			compat_sys_pwritev
-330  common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-331  common	perf_event_open		sys_perf_event_open		sys_perf_event_open
-332  common	fanotify_init		sys_fanotify_init		sys_fanotify_init
-333  common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
-334  common	prlimit64		sys_prlimit64			sys_prlimit64
-335  common	name_to_handle_at	sys_name_to_handle_at		sys_name_to_handle_at
-336  common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-337  common	clock_adjtime		sys_clock_adjtime		sys_clock_adjtime32
-338  common	syncfs			sys_syncfs			sys_syncfs
-339  common	setns			sys_setns			sys_setns
-340  common	process_vm_readv	sys_process_vm_readv		sys_process_vm_readv
-341  common	process_vm_writev	sys_process_vm_writev		sys_process_vm_writev
-342  common	s390_runtime_instr	sys_s390_runtime_instr		sys_s390_runtime_instr
-343  common	kcmp			sys_kcmp			sys_kcmp
-344  common	finit_module		sys_finit_module		sys_finit_module
-345  common	sched_setattr		sys_sched_setattr		sys_sched_setattr
-346  common	sched_getattr		sys_sched_getattr		sys_sched_getattr
-347  common	renameat2		sys_renameat2			sys_renameat2
-348  common	seccomp			sys_seccomp			sys_seccomp
-349  common	getrandom		sys_getrandom			sys_getrandom
-350  common	memfd_create		sys_memfd_create		sys_memfd_create
-351  common	bpf			sys_bpf				sys_bpf
-352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		sys_s390_pci_mmio_write
-353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		sys_s390_pci_mmio_read
-354  common	execveat		sys_execveat			compat_sys_execveat
-355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
-356  common	membarrier		sys_membarrier			sys_membarrier
-357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg_time32
-358  common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
-359  common	socket			sys_socket			sys_socket
-360  common	socketpair		sys_socketpair			sys_socketpair
-361  common	bind			sys_bind			sys_bind
-362  common	connect			sys_connect			sys_connect
-363  common	listen			sys_listen			sys_listen
-364  common	accept4			sys_accept4			sys_accept4
-365  common	getsockopt		sys_getsockopt			sys_getsockopt
-366  common	setsockopt		sys_setsockopt			sys_setsockopt
-367  common	getsockname		sys_getsockname			sys_getsockname
-368  common	getpeername		sys_getpeername			sys_getpeername
-369  common	sendto			sys_sendto			sys_sendto
-370  common	sendmsg			sys_sendmsg			compat_sys_sendmsg
-371  common	recvfrom		sys_recvfrom			compat_sys_recvfrom
-372  common	recvmsg			sys_recvmsg			compat_sys_recvmsg
-373  common	shutdown		sys_shutdown			sys_shutdown
-374  common	mlock2			sys_mlock2			sys_mlock2
-375  common	copy_file_range		sys_copy_file_range		sys_copy_file_range
-376  common	preadv2			sys_preadv2			compat_sys_preadv2
-377  common	pwritev2		sys_pwritev2			compat_sys_pwritev2
-378  common	s390_guarded_storage	sys_s390_guarded_storage	sys_s390_guarded_storage
-379  common	statx			sys_statx			sys_statx
-380  common	s390_sthyi		sys_s390_sthyi			sys_s390_sthyi
-381  common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
-382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
-383  common	rseq			sys_rseq			sys_rseq
-384  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
-385  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
-386  common	pkey_free		sys_pkey_free			sys_pkey_free
+1	common	exit				sys_exit
+2	common	fork				sys_fork
+3	common	read				sys_read
+4	common	write				sys_write
+5	common	open				sys_open
+6	common	close				sys_close
+7	common	restart_syscall			sys_restart_syscall
+8	common	creat				sys_creat
+9	common	link				sys_link
+10	common	unlink				sys_unlink
+11	common	execve				sys_execve
+12	common	chdir				sys_chdir
+14	common	mknod				sys_mknod
+15	common	chmod				sys_chmod
+19	common	lseek				sys_lseek
+20	common	getpid				sys_getpid
+21	common	mount				sys_mount
+22	common	umount				sys_oldumount
+26	common	ptrace				sys_ptrace
+27	common	alarm				sys_alarm
+29	common	pause				sys_pause
+30	common	utime				sys_utime
+33	common	access				sys_access
+34	common	nice				sys_nice
+36	common	sync				sys_sync
+37	common	kill				sys_kill
+38	common	rename				sys_rename
+39	common	mkdir				sys_mkdir
+40	common	rmdir				sys_rmdir
+41	common	dup				sys_dup
+42	common	pipe				sys_pipe
+43	common	times				sys_times
+45	common	brk				sys_brk
+48	common	signal				sys_signal
+51	common	acct				sys_acct
+52	common	umount2				sys_umount
+54	common	ioctl				sys_ioctl
+55	common	fcntl				sys_fcntl
+57	common	setpgid				sys_setpgid
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	common	ustat				sys_ustat
+63	common	dup2				sys_dup2
+64	common	getppid				sys_getppid
+65	common	getpgrp				sys_getpgrp
+66	common	setsid				sys_setsid
+67	common	sigaction			sys_sigaction
+72	common	sigsuspend			sys_sigsuspend
+73	common	sigpending			sys_sigpending
+74	common	sethostname			sys_sethostname
+75	common	setrlimit			sys_setrlimit
+77	common	getrusage			sys_getrusage
+78	common	gettimeofday			sys_gettimeofday
+79	common	settimeofday			sys_settimeofday
+83	common	symlink				sys_symlink
+85	common	readlink			sys_readlink
+86	common	uselib				sys_uselib
+87	common	swapon				sys_swapon
+88	common	reboot				sys_reboot
+89	common	readdir
+90	common	mmap				sys_old_mmap
+91	common	munmap				sys_munmap
+92	common	truncate			sys_truncate
+93	common	ftruncate			sys_ftruncate
+94	common	fchmod				sys_fchmod
+96	common	getpriority			sys_getpriority
+97	common	setpriority			sys_setpriority
+99	common	statfs				sys_statfs
+100	common	fstatfs				sys_fstatfs
+102	common	socketcall			sys_socketcall
+103	common	syslog				sys_syslog
+104	common	setitimer			sys_setitimer
+105	common	getitimer			sys_getitimer
+106	common	stat				sys_newstat
+107	common	lstat				sys_newlstat
+108	common	fstat				sys_newfstat
+110	common	lookup_dcookie
+111	common	vhangup				sys_vhangup
+112	common	idle
+114	common	wait4				sys_wait4
+115	common	swapoff				sys_swapoff
+116	common	sysinfo				sys_sysinfo
+117	common	ipc				sys_s390_ipc
+118	common	fsync				sys_fsync
+119	common	sigreturn			sys_sigreturn
+120	common	clone				sys_clone
+121	common	setdomainname			sys_setdomainname
+122	common	uname				sys_newuname
+124	common	adjtimex			sys_adjtimex
+125	common	mprotect			sys_mprotect
+126	common	sigprocmask			sys_sigprocmask
+127	common	create_module
+128	common	init_module			sys_init_module
+129	common	delete_module			sys_delete_module
+130	common	get_kernel_syms
+131	common	quotactl			sys_quotactl
+132	common	getpgid				sys_getpgid
+133	common	fchdir				sys_fchdir
+134	common	bdflush				sys_ni_syscall
+135	common	sysfs				sys_sysfs
+136	common	personality			sys_s390_personality
+137	common	afs_syscall
+141	common	getdents			sys_getdents
+142	common	select				sys_select
+143	common	flock				sys_flock
+144	common	msync				sys_msync
+145	common	readv				sys_readv
+146	common	writev				sys_writev
+147	common	getsid				sys_getsid
+148	common	fdatasync			sys_fdatasync
+149	common	_sysctl
+150	common	mlock				sys_mlock
+151	common	munlock				sys_munlock
+152	common	mlockall			sys_mlockall
+153	common	munlockall			sys_munlockall
+154	common	sched_setparam			sys_sched_setparam
+155	common	sched_getparam			sys_sched_getparam
+156	common	sched_setscheduler		sys_sched_setscheduler
+157	common	sched_getscheduler		sys_sched_getscheduler
+158	common	sched_yield			sys_sched_yield
+159	common	sched_get_priority_max		sys_sched_get_priority_max
+160	common	sched_get_priority_min		sys_sched_get_priority_min
+161	common	sched_rr_get_interval		sys_sched_rr_get_interval
+162	common	nanosleep			sys_nanosleep
+163	common	mremap				sys_mremap
+167	common	query_module
+168	common	poll				sys_poll
+169	common	nfsservctl
+172	common	prctl				sys_prctl
+173	common	rt_sigreturn			sys_rt_sigreturn
+174	common	rt_sigaction			sys_rt_sigaction
+175	common	rt_sigprocmask			sys_rt_sigprocmask
+176	common	rt_sigpending			sys_rt_sigpending
+177	common	rt_sigtimedwait			sys_rt_sigtimedwait
+178	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
+179	common	rt_sigsuspend			sys_rt_sigsuspend
+180	common	pread64				sys_pread64
+181	common	pwrite64			sys_pwrite64
+183	common	getcwd				sys_getcwd
+184	common	capget				sys_capget
+185	common	capset				sys_capset
+186	common	sigaltstack			sys_sigaltstack
+187	common	sendfile			sys_sendfile64
+188	common	getpmsg
+189	common	putpmsg
+190	common	vfork				sys_vfork
+191	common	getrlimit			sys_getrlimit
+198	common	lchown				sys_lchown
+199	common	getuid				sys_getuid
+200	common	getgid				sys_getgid
+201	common	geteuid				sys_geteuid
+202	common	getegid				sys_getegid
+203	common	setreuid			sys_setreuid
+204	common	setregid			sys_setregid
+205	common	getgroups			sys_getgroups
+206	common	setgroups			sys_setgroups
+207	common	fchown				sys_fchown
+208	common	setresuid			sys_setresuid
+209	common	getresuid			sys_getresuid
+210	common	setresgid			sys_setresgid
+211	common	getresgid			sys_getresgid
+212	common	chown				sys_chown
+213	common	setuid				sys_setuid
+214	common	setgid				sys_setgid
+215	common	setfsuid			sys_setfsuid
+216	common	setfsgid			sys_setfsgid
+217	common	pivot_root			sys_pivot_root
+218	common	mincore				sys_mincore
+219	common	madvise				sys_madvise
+220	common	getdents64			sys_getdents64
+222	common	readahead			sys_readahead
+224	common	setxattr			sys_setxattr
+225	common	lsetxattr			sys_lsetxattr
+226	common	fsetxattr			sys_fsetxattr
+227	common	getxattr			sys_getxattr
+228	common	lgetxattr			sys_lgetxattr
+229	common	fgetxattr			sys_fgetxattr
+230	common	listxattr			sys_listxattr
+231	common	llistxattr			sys_llistxattr
+232	common	flistxattr			sys_flistxattr
+233	common	removexattr			sys_removexattr
+234	common	lremovexattr			sys_lremovexattr
+235	common	fremovexattr			sys_fremovexattr
+236	common	gettid				sys_gettid
+237	common	tkill				sys_tkill
+238	common	futex				sys_futex
+239	common	sched_setaffinity		sys_sched_setaffinity
+240	common	sched_getaffinity		sys_sched_getaffinity
+241	common	tgkill				sys_tgkill
+243	common	io_setup			sys_io_setup
+244	common	io_destroy			sys_io_destroy
+245	common	io_getevents			sys_io_getevents
+246	common	io_submit			sys_io_submit
+247	common	io_cancel			sys_io_cancel
+248	common	exit_group			sys_exit_group
+249	common	epoll_create			sys_epoll_create
+250	common	epoll_ctl			sys_epoll_ctl
+251	common	epoll_wait			sys_epoll_wait
+252	common	set_tid_address			sys_set_tid_address
+253	common	fadvise64			sys_fadvise64_64
+254	common	timer_create			sys_timer_create
+255	common	timer_settime			sys_timer_settime
+256	common	timer_gettime			sys_timer_gettime
+257	common	timer_getoverrun		sys_timer_getoverrun
+258	common	timer_delete			sys_timer_delete
+259	common	clock_settime			sys_clock_settime
+260	common	clock_gettime			sys_clock_gettime
+261	common	clock_getres			sys_clock_getres
+262	common	clock_nanosleep			sys_clock_nanosleep
+265	common	statfs64			sys_statfs64
+266	common	fstatfs64			sys_fstatfs64
+267	common	remap_file_pages		sys_remap_file_pages
+268	common	mbind				sys_mbind
+269	common	get_mempolicy			sys_get_mempolicy
+270	common	set_mempolicy			sys_set_mempolicy
+271	common	mq_open				sys_mq_open
+272	common	mq_unlink			sys_mq_unlink
+273	common	mq_timedsend			sys_mq_timedsend
+274	common	mq_timedreceive			sys_mq_timedreceive
+275	common	mq_notify			sys_mq_notify
+276	common	mq_getsetattr			sys_mq_getsetattr
+277	common	kexec_load			sys_kexec_load
+278	common	add_key				sys_add_key
+279	common	request_key			sys_request_key
+280	common	keyctl				sys_keyctl
+281	common	waitid				sys_waitid
+282	common	ioprio_set			sys_ioprio_set
+283	common	ioprio_get			sys_ioprio_get
+284	common	inotify_init			sys_inotify_init
+285	common	inotify_add_watch		sys_inotify_add_watch
+286	common	inotify_rm_watch		sys_inotify_rm_watch
+287	common	migrate_pages			sys_migrate_pages
+288	common	openat				sys_openat
+289	common	mkdirat				sys_mkdirat
+290	common	mknodat				sys_mknodat
+291	common	fchownat			sys_fchownat
+292	common	futimesat			sys_futimesat
+293	common	newfstatat			sys_newfstatat
+294	common	unlinkat			sys_unlinkat
+295	common	renameat			sys_renameat
+296	common	linkat				sys_linkat
+297	common	symlinkat			sys_symlinkat
+298	common	readlinkat			sys_readlinkat
+299	common	fchmodat			sys_fchmodat
+300	common	faccessat			sys_faccessat
+301	common	pselect6			sys_pselect6
+302	common	ppoll				sys_ppoll
+303	common	unshare				sys_unshare
+304	common	set_robust_list			sys_set_robust_list
+305	common	get_robust_list			sys_get_robust_list
+306	common	splice				sys_splice
+307	common	sync_file_range			sys_sync_file_range
+308	common	tee				sys_tee
+309	common	vmsplice			sys_vmsplice
+310	common	move_pages			sys_move_pages
+311	common	getcpu				sys_getcpu
+312	common	epoll_pwait			sys_epoll_pwait
+313	common	utimes				sys_utimes
+314	common	fallocate			sys_fallocate
+315	common	utimensat			sys_utimensat
+316	common	signalfd			sys_signalfd
+317	common	timerfd
+318	common	eventfd				sys_eventfd
+319	common	timerfd_create			sys_timerfd_create
+320	common	timerfd_settime			sys_timerfd_settime
+321	common	timerfd_gettime			sys_timerfd_gettime
+322	common	signalfd4			sys_signalfd4
+323	common	eventfd2			sys_eventfd2
+324	common	inotify_init1			sys_inotify_init1
+325	common	pipe2				sys_pipe2
+326	common	dup3				sys_dup3
+327	common	epoll_create1			sys_epoll_create1
+328	common	preadv				sys_preadv
+329	common	pwritev				sys_pwritev
+330	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+331	common	perf_event_open			sys_perf_event_open
+332	common	fanotify_init			sys_fanotify_init
+333	common	fanotify_mark			sys_fanotify_mark
+334	common	prlimit64			sys_prlimit64
+335	common	name_to_handle_at		sys_name_to_handle_at
+336	common	open_by_handle_at		sys_open_by_handle_at
+337	common	clock_adjtime			sys_clock_adjtime
+338	common	syncfs				sys_syncfs
+339	common	setns				sys_setns
+340	common	process_vm_readv		sys_process_vm_readv
+341	common	process_vm_writev		sys_process_vm_writev
+342	common	s390_runtime_instr		sys_s390_runtime_instr
+343	common	kcmp				sys_kcmp
+344	common	finit_module			sys_finit_module
+345	common	sched_setattr			sys_sched_setattr
+346	common	sched_getattr			sys_sched_getattr
+347	common	renameat2			sys_renameat2
+348	common	seccomp				sys_seccomp
+349	common	getrandom			sys_getrandom
+350	common	memfd_create			sys_memfd_create
+351	common	bpf				sys_bpf
+352	common	s390_pci_mmio_write		sys_s390_pci_mmio_write
+353	common	s390_pci_mmio_read		sys_s390_pci_mmio_read
+354	common	execveat			sys_execveat
+355	common	userfaultfd			sys_userfaultfd
+356	common	membarrier			sys_membarrier
+357	common	recvmmsg			sys_recvmmsg
+358	common	sendmmsg			sys_sendmmsg
+359	common	socket				sys_socket
+360	common	socketpair			sys_socketpair
+361	common	bind				sys_bind
+362	common	connect				sys_connect
+363	common	listen				sys_listen
+364	common	accept4				sys_accept4
+365	common	getsockopt			sys_getsockopt
+366	common	setsockopt			sys_setsockopt
+367	common	getsockname			sys_getsockname
+368	common	getpeername			sys_getpeername
+369	common	sendto				sys_sendto
+370	common	sendmsg				sys_sendmsg
+371	common	recvfrom			sys_recvfrom
+372	common	recvmsg				sys_recvmsg
+373	common	shutdown			sys_shutdown
+374	common	mlock2				sys_mlock2
+375	common	copy_file_range			sys_copy_file_range
+376	common	preadv2				sys_preadv2
+377	common	pwritev2			sys_pwritev2
+378	common	s390_guarded_storage		sys_s390_guarded_storage
+379	common	statx				sys_statx
+380	common	s390_sthyi			sys_s390_sthyi
+381	common	kexec_file_load			sys_kexec_file_load
+382	common	io_pgetevents			sys_io_pgetevents
+383	common	rseq				sys_rseq
+384	common	pkey_mprotect			sys_pkey_mprotect
+385	common	pkey_alloc			sys_pkey_alloc
+386	common	pkey_free			sys_pkey_free
 # room for arch specific syscalls
-392	64	semtimedop		sys_semtimedop			-
-393  common	semget			sys_semget			sys_semget
-394  common	semctl			sys_semctl			compat_sys_semctl
-395  common	shmget			sys_shmget			sys_shmget
-396  common	shmctl			sys_shmctl			compat_sys_shmctl
-397  common	shmat			sys_shmat			compat_sys_shmat
-398  common	shmdt			sys_shmdt 			sys_shmdt
-399  common	msgget			sys_msgget			sys_msgget
-400  common	msgsnd			sys_msgsnd			compat_sys_msgsnd
-401  common	msgrcv			sys_msgrcv			compat_sys_msgrcv
-402  common	msgctl			sys_msgctl			compat_sys_msgctl
-403	32	clock_gettime64		-				sys_clock_gettime
-404	32	clock_settime64		-				sys_clock_settime
-405	32	clock_adjtime64		-				sys_clock_adjtime
-406	32	clock_getres_time64	-				sys_clock_getres
-407	32	clock_nanosleep_time64	-				sys_clock_nanosleep
-408	32	timer_gettime64		-				sys_timer_gettime
-409	32	timer_settime64		-				sys_timer_settime
-410	32	timerfd_gettime64	-				sys_timerfd_gettime
-411	32	timerfd_settime64	-				sys_timerfd_settime
-412	32	utimensat_time64	-				sys_utimensat
-413	32	pselect6_time64		-				compat_sys_pselect6_time64
-414	32	ppoll_time64		-				compat_sys_ppoll_time64
-416	32	io_pgetevents_time64	-				compat_sys_io_pgetevents_time64
-417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
-418	32	mq_timedsend_time64	-				sys_mq_timedsend
-419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
-420	32	semtimedop_time64	-				sys_semtimedop
-421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
-422	32	futex_time64		-				sys_futex
-423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
-424  common	pidfd_send_signal	sys_pidfd_send_signal		sys_pidfd_send_signal
-425  common	io_uring_setup		sys_io_uring_setup              sys_io_uring_setup
-426  common	io_uring_enter		sys_io_uring_enter              sys_io_uring_enter
-427  common	io_uring_register	sys_io_uring_register           sys_io_uring_register
-428  common	open_tree		sys_open_tree			sys_open_tree
-429  common	move_mount		sys_move_mount			sys_move_mount
-430  common	fsopen			sys_fsopen			sys_fsopen
-431  common	fsconfig		sys_fsconfig			sys_fsconfig
-432  common	fsmount			sys_fsmount			sys_fsmount
-433  common	fspick			sys_fspick			sys_fspick
-434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
-435  common	clone3			sys_clone3			sys_clone3
-436  common	close_range		sys_close_range			sys_close_range
-437  common	openat2			sys_openat2			sys_openat2
-438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
-439  common	faccessat2		sys_faccessat2			sys_faccessat2
-440  common	process_madvise		sys_process_madvise		sys_process_madvise
-441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
-442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
-443  common	quotactl_fd		sys_quotactl_fd			sys_quotactl_fd
-444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
-445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
-446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
-447  common	memfd_secret		sys_memfd_secret		sys_memfd_secret
-448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
-449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
-450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
-451  common	cachestat		sys_cachestat			sys_cachestat
-452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
-453  common	map_shadow_stack	sys_map_shadow_stack		sys_map_shadow_stack
-454  common	futex_wake		sys_futex_wake			sys_futex_wake
-455  common	futex_wait		sys_futex_wait			sys_futex_wait
-456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
-457  common	statmount		sys_statmount			sys_statmount
-458  common	listmount		sys_listmount			sys_listmount
-459  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
-460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
-461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
-462  common	mseal			sys_mseal			sys_mseal
-463  common	setxattrat		sys_setxattrat			sys_setxattrat
-464  common	getxattrat		sys_getxattrat			sys_getxattrat
-465  common	listxattrat		sys_listxattrat			sys_listxattrat
-466  common	removexattrat		sys_removexattrat		sys_removexattrat
-467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
-468  common	file_getattr		sys_file_getattr		sys_file_getattr
-469  common	file_setattr		sys_file_setattr		sys_file_setattr
+392	common	semtimedop			sys_semtimedop
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl
+397	common	shmat				sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd
+401	common	msgrcv				sys_msgrcv
+402	common	msgctl				sys_msgctl
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+447	common	memfd_secret			sys_memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
+463	common	setxattrat			sys_setxattrat
+464	common	getxattrat			sys_getxattrat
+465	common	listxattrat			sys_listxattrat
+466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/s390/kernel/syscalls/syscalltbl b/arch/s390/kernel/syscalls/syscalltbl
deleted file mode 100755
index fbac1732f874..000000000000
--- a/arch/s390/kernel/syscalls/syscalltbl
+++ /dev/null
@@ -1,232 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table and header files
-#
-# Copyright IBM Corp. 2018
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-
-#
-# File path to the system call table definition.
-# You can set the path with the -i option.  If omitted,
-# system call table definitions are read from standard input.
-#
-SYSCALL_TBL=""
-
-
-create_syscall_table_entries()
-{
-	local nr abi name entry64 entry32 _ignore
-	local temp=$(mktemp ${TMPDIR:-/tmp}/syscalltbl-common.XXXXXXXXX)
-
-	(
-	#
-	# Initialize with 0 to create an NI_SYSCALL for 0
-	#
-	local prev_nr=0 prev_32=sys_ni_syscall prev_64=sys_ni_syscall
-	while read nr abi name entry64 entry32 _ignore; do
-		test x$entry32 = x- && entry32=sys_ni_syscall
-		test x$entry64 = x- && entry64=sys_ni_syscall
-
-		if test $prev_nr -eq $nr; then
-			#
-			# Same syscall but different ABI, just update
-			# the respective entry point
-			#
-			case $abi in
-			32)
-				prev_32=$entry32
-			;;
-			64)
-				prev_64=$entry64
-			;;
-			esac
-			continue;
-		else
-			printf "%d\t%s\t%s\n" $prev_nr $prev_64 $prev_32
-		fi
-
-		prev_nr=$nr
-		prev_64=$entry64
-		prev_32=$entry32
-	done
-	printf "%d\t%s\t%s\n" $prev_nr $prev_64 $prev_32
-	) >> $temp
-
-	#
-	# Check for duplicate syscall numbers
-	#
-	if ! cat $temp |cut -f1 |uniq -d 2>&1; then
-		echo "Error: generated system call table contains duplicate entries: $temp" >&2
-		exit 1
-	fi
-
-	#
-	# Generate syscall table
-	#
-	prev_nr=0
-	while read nr entry64 entry32; do
-		while test $prev_nr -lt $((nr - 1)); do
-			printf "NI_SYSCALL\n"
-			prev_nr=$((prev_nr + 1))
-		done
-		if test x$entry64 = xsys_ni_syscall &&
-		   test x$entry32 = xsys_ni_syscall; then
-			printf "NI_SYSCALL\n"
-		else
-			printf "SYSCALL(%s,%s)\n" $entry64 $entry32
-		fi
-		prev_nr=$nr
-	done < $temp
-	rm $temp
-}
-
-generate_syscall_table()
-{
-	cat <<-EoHEADER
-	/* SPDX-License-Identifier: GPL-2.0 */
-	/*
-	 * Definitions for sys_call_table, each line represents an
-	 * entry in the table in the form
-	 * SYSCALL(64 bit syscall, 31 bit emulated syscall)
-	 *
-	 * This file is meant to be included from entry.S.
-	 */
-
-	#define NI_SYSCALL SYSCALL(sys_ni_syscall,sys_ni_syscall)
-
-EoHEADER
-	grep -Ev '^(#|[[:blank:]]*$)' $SYSCALL_TBL	\
-		|sort -k1 -n				\
-		|create_syscall_table_entries
-}
-
-create_header_defines()
-{
-	local nr abi name _ignore
-
-	while read nr abi name _ignore; do
-		printf "#define __NR_%s %d\n" $name $nr
-	done
-}
-
-normalize_fileguard()
-{
-	local fileguard="$1"
-
-	echo "$1" |tr '[[:lower:]]' '[[:upper:]]' \
-		  |sed -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'
-}
-
-generate_syscall_header()
-{
-	local abis=$(echo "($1)" | tr ',' '|')
-	local filename="$2"
-	local fileguard suffix
-
-	if test "$filename"; then
-		fileguard=$(normalize_fileguard "__UAPI_ASM_S390_$2")
-	else
-		case "$abis" in
-		*64*) suffix=64 ;;
-		*32*) suffix=32 ;;
-		esac
-		fileguard=$(normalize_fileguard "__UAPI_ASM_S390_SYSCALLS_$suffix")
-	fi
-
-	cat <<-EoHEADER
-	/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-	#ifndef ${fileguard}
-	#define ${fileguard}
-
-EoHEADER
-
-	grep -E "^[[:digit:]]+[[:space:]]+${abis}" $SYSCALL_TBL	\
-		|sort -k1 -n					\
-		|create_header_defines
-
-	cat <<-EoFOOTER
-
-	#endif /* ${fileguard} */
-EoFOOTER
-}
-
-__max_syscall_nr()
-{
-	local abis=$(echo "($1)" | tr ',' '|')
-
-	grep -E "^[[:digit:]]+[[:space:]]+${abis}" $SYSCALL_TBL	 \
-		|sed -ne 's/^\([[:digit:]]*\)[[:space:]].*/\1/p' \
-		|sort -n					 \
-		|tail -1
-}
-
-
-generate_syscall_nr()
-{
-	local abis="$1"
-	local max_syscall_nr num_syscalls
-
-	max_syscall_nr=$(__max_syscall_nr "$abis")
-	num_syscalls=$((max_syscall_nr + 1))
-
-	cat <<-EoHEADER
-	/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-	#ifndef __ASM_S390_SYSCALLS_NR
-	#define __ASM_S390_SYSCALLS_NR
-
-	#define NR_syscalls ${num_syscalls}
-
-	#endif /* __ASM_S390_SYSCALLS_NR */
-EoHEADER
-}
-
-
-#
-# Parse command line arguments
-#
-do_syscall_header=""
-do_syscall_table=""
-do_syscall_nr=""
-output_file=""
-abi_list="common,64"
-filename=""
-while getopts ":HNSXi:a:f:" arg; do
-	case $arg in
-	a)
-		abi_list="$OPTARG"
-		;;
-	i)
-		SYSCALL_TBL="$OPTARG"
-		;;
-	f)
-		filename=${OPTARG##*/}
-		;;
-	H)
-		do_syscall_header=1
-		;;
-	N)
-		do_syscall_nr=1
-		;;
-	S)
-		do_syscall_table=1
-		;;
-	X)
-		set -x
-		;;
-	:)
-		echo "Missing argument for -$OPTARG" >&2
-		exit 1
-	;;
-	\?)
-		echo "Invalid option specified" >&2
-		exit 1
-	;;
-	esac
-done
-
-test "$do_syscall_header" && generate_syscall_header "$abi_list" "$filename"
-test "$do_syscall_table" && generate_syscall_table
-test "$do_syscall_nr" && generate_syscall_nr "$abi_list"
-
-exit 0
-- 
2.48.1


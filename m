Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbgIDUfZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Sep 2020 16:35:25 -0400
Date: Fri, 4 Sep 2020 22:35:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.9-rc4
Message-ID: <your-ad-here.call-01599251714-ext-8456@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc4.

Thank you,
Vasily

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-5

for you to fetch changes up to 5c60ed283e1d87e161441bb273541a948ee96f6a:

  s390: update defconfigs (2020-09-02 13:17:05 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc4

- Fix GENERIC_LOCKBREAK dependency on PREEMPTION in Kconfig broken
  because of a typo.

- Update defconfigs.

----------------------------------------------------------------
Eric Farman (1):
      s390: fix GENERIC_LOCKBREAK dependency typo in Kconfig

Heiko Carstens (1):
      s390: update defconfigs

 arch/s390/Kconfig                    | 2 +-
 arch/s390/configs/debug_defconfig    | 4 ++++
 arch/s390/configs/defconfig          | 3 +++
 arch/s390/configs/zfcpdump_defconfig | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3d86e12e8e3c..b29fcc66ec39 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -30,7 +30,7 @@ config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
 config GENERIC_LOCKBREAK
-	def_bool y if PREEMPTTION
+	def_bool y if PREEMPTION
 
 config PGSTE
 	def_bool y if KVM
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 0cf9a82326a8..7228aabe9da6 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -626,6 +626,7 @@ CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_INODE64=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
@@ -807,6 +808,7 @@ CONFIG_DEBUG_NOTIFIERS=y
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_DEBUG_CREDENTIALS=y
 CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_REF_SCALE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=300
 # CONFIG_RCU_TRACE is not set
 CONFIG_LATENCYTOP=y
@@ -818,6 +820,7 @@ CONFIG_PREEMPT_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_S390_PTDUMP=y
 CONFIG_NOTIFIER_ERROR_INJECTION=m
@@ -829,6 +832,7 @@ CONFIG_FAIL_MAKE_REQUEST=y
 CONFIG_FAIL_IO_TIMEOUT=y
 CONFIG_FAIL_FUTEX=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
 CONFIG_LKDTM=m
 CONFIG_TEST_LIST_SORT=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 5df9759e8ff6..fab03b7a6932 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -617,6 +617,7 @@ CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_INODE64=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
@@ -763,6 +764,7 @@ CONFIG_PANIC_ON_OOPS=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_REF_SCALE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 CONFIG_LATENCYTOP=y
 CONFIG_BOOTTIME_TRACING=y
@@ -771,6 +773,7 @@ CONFIG_STACK_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_S390_PTDUMP=y
 CONFIG_LKDTM=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 4091c50449cd..8f67c55625f9 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -74,5 +74,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
+# CONFIG_RCU_TRACE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set

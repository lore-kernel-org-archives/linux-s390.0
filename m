Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Nov 2020 19:21:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.10-rc5
Message-ID: <20201117182158.GA4746@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull some small s390 updates for 5.10-rc5.

Thanks,
Heiko

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-4

for you to fetch changes up to 78d732e1f326f74f240d416af9484928303d9951:

  s390/cpum_sf.c: fix file permission for cpum_sfb_size (2020-11-12 12:10:36 +0100)

----------------------------------------------------------------
- fix system call exit path; avoid return to user space with
  any TIF/CIF/PIF set

- fix file permission for cpum_sfb_size parameter

- another small defconfig update

----------------------------------------------------------------
Heiko Carstens (2):
      s390: fix system call exit path
      s390: update defconfigs

Thomas Richter (1):
      s390/cpum_sf.c: fix file permission for cpum_sfb_size

 arch/s390/configs/debug_defconfig | 1 +
 arch/s390/kernel/entry.S          | 2 ++
 arch/s390/kernel/perf_cpum_sf.c   | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index a4d3c578fbd8..fe6f529ac82c 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -1,3 +1,4 @@
+CONFIG_UAPI_HEADER_TEST=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_WATCH_QUEUE=y
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 86235919c2d1..5346545b9860 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -422,6 +422,7 @@ ENTRY(system_call)
 #endif
 	LOCKDEP_SYS_EXIT
 .Lsysc_tif:
+	DISABLE_INTS
 	TSTMSK	__PT_FLAGS(%r11),_PIF_WORK
 	jnz	.Lsysc_work
 	TSTMSK	__TI_flags(%r12),_TIF_WORK
@@ -444,6 +445,7 @@ ENTRY(system_call)
 # One of the work bits is on. Find out which one.
 #
 .Lsysc_work:
+	ENABLE_INTS
 	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
 	jo	.Lsysc_reschedule
 	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 4f9e4626df55..f100c9209743 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -2228,4 +2228,4 @@ static int __init init_cpum_sampling_pmu(void)
 }
 
 arch_initcall(init_cpum_sampling_pmu);
-core_param(cpum_sfb_size, CPUM_SF_MAX_SDB, sfb_size, 0640);
+core_param(cpum_sfb_size, CPUM_SF_MAX_SDB, sfb_size, 0644);

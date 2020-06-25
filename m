Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17036 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404222AbgFYMEO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 08:04:14 -0400
Date: Thu, 25 Jun 2020 14:03:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 5.8-rc3
Message-ID: <20200625120327.GA7638@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hi Linus,

please pull s390 updates for 5.8-rc3

Thanks,
Heiko

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-3

for you to fetch changes up to 827c4913923e0b441ba07ba4cc41e01181102303:

  s390/debug: avoid kernel warning on too large number of pages (2020-06-23 14:05:55 +0200)

----------------------------------------------------------------
s390 fixes for 5.8-rc3

- Fix kernel crash on system call single stepping.

- Make sure early program check handler is executed with DAT on to
  avoid an endless program check loop.

- Add __GFP_NOWARN flag to debug feature to avoid user triggerable
  allocation failure messages.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/debug: avoid kernel warning on too large number of pages

Sven Schnelle (1):
      s390: fix system call single stepping

Vasily Gorbik (1):
      s390/kasan: fix early pgm check handler execution

 arch/s390/kernel/debug.c | 3 ++-
 arch/s390/kernel/early.c | 2 ++
 arch/s390/kernel/entry.S | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 636446003a06..263075a1af36 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -198,9 +198,10 @@ static debug_entry_t ***debug_areas_alloc(int pages_per_area, int nr_areas)
 	if (!areas)
 		goto fail_malloc_areas;
 	for (i = 0; i < nr_areas; i++) {
+		/* GFP_NOWARN to avoid user triggerable WARN, we handle fails */
 		areas[i] = kmalloc_array(pages_per_area,
 					 sizeof(debug_entry_t *),
-					 GFP_KERNEL);
+					 GFP_KERNEL | __GFP_NOWARN);
 		if (!areas[i])
 			goto fail_malloc_areas2;
 		for (j = 0; j < pages_per_area; j++) {
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index cd241ee66eff..078277231858 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -170,6 +170,8 @@ static noinline __init void setup_lowcore_early(void)
 	psw_t psw;
 
 	psw.mask = PSW_MASK_BASE | PSW_DEFAULT_KEY | PSW_MASK_EA | PSW_MASK_BA;
+	if (IS_ENABLED(CONFIG_KASAN))
+		psw.mask |= PSW_MASK_DAT;
 	psw.addr = (unsigned long) s390_base_ext_handler;
 	S390_lowcore.external_new_psw = psw;
 	psw.addr = (unsigned long) s390_base_pgm_handler;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 496f74d98473..969b35b177dd 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -378,9 +378,9 @@ ENTRY(system_call)
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	BPOFF
 	lg	%r12,__LC_CURRENT
-	lghi	%r13,__TASK_thread
 	lghi	%r14,_PIF_SYSCALL
 .Lsysc_per:
+	lghi	%r13,__TASK_thread
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER

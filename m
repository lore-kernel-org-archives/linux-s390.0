Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726649AbfFTMRg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Jun 2019 08:17:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KCEsFu097237
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2019 08:17:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t88rqbgbm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2019 08:17:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 20 Jun 2019 13:17:33 +0100
Date: Thu, 20 Jun 2019 14:17:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 5.2-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20190620121727.GA4387@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-5

for you to fetch changes up to 11aff183225c5cf48fae074cd99d8f18ba84ed34:

  vfio-ccw: Destroy kmem cache region on module exit (2019-06-13 15:52:28 +0200)

----------------------------------------------------------------
s390 updates for 5.2-rc6

 - Disable address-of-packed-member warning in s390 specific boot code
   to get rid of a gcc9 warning which otherwise is already disabled
   for the whole kernel.

 - Fix yet another compiler error seen with CONFIG_OPTIMIZE_INLINING
   enabled.

 - Fix memory leak in vfio-ccw code on module exit.

----------------------------------------------------------------
Farhan Ali (1):
      vfio-ccw: Destroy kmem cache region on module exit

Guenter Roeck (1):
      s390/ctl_reg: mark __ctl_set_bit and __ctl_clear_bit as __always_inline

Heiko Carstens (1):
      s390/boot: disable address-of-packed-member warning

 arch/s390/Makefile              | 1 +
 arch/s390/include/asm/ctl_reg.h | 4 ++--
 drivers/s390/cio/vfio_ccw_drv.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index de8521f..e48013c 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -30,6 +30,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
+KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 UTS_MACHINE	:= s390x
diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 4600453..3bda757 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -55,7 +55,7 @@
 		: "i" (low), "i" (high));				\
 } while (0)
 
-static inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
+static __always_inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
 {
 	unsigned long reg;
 
@@ -64,7 +64,7 @@ static inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
 	__ctl_load(reg, cr, cr);
 }
 
-static inline void __ctl_clear_bit(unsigned int cr, unsigned int bit)
+static __always_inline void __ctl_clear_bit(unsigned int cr, unsigned int bit)
 {
 	unsigned long reg;
 
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ee8767f..9125f7f 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -299,6 +299,7 @@ static void __exit vfio_ccw_sch_exit(void)
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
 	kmem_cache_destroy(vfio_ccw_io_region);
+	kmem_cache_destroy(vfio_ccw_cmd_region);
 	destroy_workqueue(vfio_ccw_work_q);
 }
 module_init(vfio_ccw_sch_init);

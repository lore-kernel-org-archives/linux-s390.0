Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgGJNrs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jul 2020 09:47:48 -0400
Date: Fri, 10 Jul 2020 15:47:40 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] more s390 updates for 5.8-rc5
Message-ID: <20200710134740.GA14845@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hi Linus,

please pull more small s390 updates for 5.8-rc5.

This request is mainly due to the fact that Gerald Schaefer's and also
my old email addresses currently do not work any longer. Therefore we
decided to switch to new email addresses and reflect that in the
MAINTAINERS file.

Thanks,
Heiko

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-5

for you to fetch changes up to dd9ce2d6eeaebbdd342cbe095b7a195d569f18d3:

  MAINTAINERS: update email address for Gerald Schaefer (2020-07-10 15:06:49 +0200)

----------------------------------------------------------------
- Update email addresses in MAINTAINERS file and add .mailmap entries
  for Gerald Schaefer and Heiko Carstens.

- Fix huge pte soft dirty copying.

----------------------------------------------------------------
Gerald Schaefer (1):
      MAINTAINERS: update email address for Gerald Schaefer

Heiko Carstens (1):
      MAINTAINERS: update email address for Heiko Carstens

Janosch Frank (1):
      s390/mm: fix huge pte soft dirty copying

 .mailmap                   | 5 +++++
 MAINTAINERS                | 8 ++++----
 arch/s390/mm/hugetlbpage.c | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index c69d9c734fb5..6da12dfd10dc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -90,11 +90,16 @@ Frank Rowand <frowand.list@gmail.com> <frank.rowand@sonymobile.com>
 Frank Zago <fzago@systemfabricworks.com>
 Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
+Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
+Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
+Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@linux.vnet.ibm.com>
 Greg Kroah-Hartman <greg@echidna.(none)>
 Greg Kroah-Hartman <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
 Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
+Heiko Carstens <hca@linux.ibm.com> <h.carstens@de.ibm.com>
+Heiko Carstens <hca@linux.ibm.com> <heiko.carstens@de.ibm.com>
 Henk Vergonet <Henk.Vergonet@gmail.com>
 Henrik Kretzschmar <henne@nachtwindheim.de>
 Henrik Rydberg <rydberg@bitmath.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..06f61751353c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3306,7 +3306,7 @@ X:	arch/riscv/net/bpf_jit_comp32.c
 
 BPF JIT for S390
 M:	Ilya Leoshkevich <iii@linux.ibm.com>
-M:	Heiko Carstens <heiko.carstens@de.ibm.com>
+M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
@@ -14831,7 +14831,7 @@ S:	Maintained
 F:	drivers/video/fbdev/savage/
 
 S390
-M:	Heiko Carstens <heiko.carstens@de.ibm.com>
+M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
 L:	linux-s390@vger.kernel.org
@@ -14862,7 +14862,7 @@ F:	drivers/s390/block/dasd*
 F:	include/linux/dasd_mod.h
 
 S390 IOMMU (PCI)
-M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
+M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -14890,7 +14890,7 @@ F:	drivers/s390/net/
 
 S390 PCI SUBSYSTEM
 M:	Niklas Schnelle <schnelle@linux.ibm.com>
-M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
+M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 82df06d720e8..3b5a4d25ca9b 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -117,7 +117,7 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 					     _PAGE_YOUNG);
 #ifdef CONFIG_MEM_SOFT_DIRTY
 		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_SOFT_DIRTY,
-					     _PAGE_DIRTY);
+					     _PAGE_SOFT_DIRTY);
 #endif
 		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_NOEXEC,
 					     _PAGE_NOEXEC);

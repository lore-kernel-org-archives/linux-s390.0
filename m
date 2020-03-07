Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgCGNGz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 7 Mar 2020 08:06:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 027D3t5n023118
        for <linux-s390@vger.kernel.org>; Sat, 7 Mar 2020 08:06:54 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym6tjxph5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 07 Mar 2020 08:06:53 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 7 Mar 2020 13:06:51 -0000
Date: Sat, 7 Mar 2020 14:06:45 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.6-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01583586405-ext-2652@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.6-rc5.

Thank you,
Vasily

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-5

for you to fetch changes up to df057c914a9c219ac8b8ed22caf7da2f80c1fe26:

  s390/pci: Fix unexpected write combine on resource (2020-03-04 11:18:03 +0100)

----------------------------------------------------------------
s390 updates for 5.6-rc5

- Fix panic in gup_fast on large pud by providing an implementation of
  pud_write. This has been overlooked during migration to common gup code.

- Fix unexpected write combining on PCI stores.

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/mm: fix panic in gup_fast on large pud

Niklas Schnelle (1):
      s390/pci: Fix unexpected write combine on resource

 arch/s390/include/asm/pgtable.h | 6 ++++++
 arch/s390/pci/pci.c             | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 137a3920ca36..6d7c3b7e9281 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -752,6 +752,12 @@ static inline int pmd_write(pmd_t pmd)
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_WRITE) != 0;
 }
 
+#define pud_write pud_write
+static inline int pud_write(pud_t pud)
+{
+	return (pud_val(pud) & _REGION3_ENTRY_WRITE) != 0;
+}
+
 static inline int pmd_dirty(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY) != 0;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index bc61ea18e88d..60716d18ce5a 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -424,7 +424,7 @@ static void zpci_map_resources(struct pci_dev *pdev)
 
 		if (zpci_use_mio(zdev))
 			pdev->resource[i].start =
-				(resource_size_t __force) zdev->bars[i].mio_wb;
+				(resource_size_t __force) zdev->bars[i].mio_wt;
 		else
 			pdev->resource[i].start = (resource_size_t __force)
 				pci_iomap_range_fh(pdev, i, 0, 0);
@@ -531,7 +531,7 @@ static int zpci_setup_bus_resources(struct zpci_dev *zdev,
 			flags |= IORESOURCE_MEM_64;
 
 		if (zpci_use_mio(zdev))
-			addr = (unsigned long) zdev->bars[i].mio_wb;
+			addr = (unsigned long) zdev->bars[i].mio_wt;
 		else
 			addr = ZPCI_ADDR(entry);
 		size = 1UL << zdev->bars[i].size;

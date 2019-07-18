Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732033AbfGRD3n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 23:29:43 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 0/6] Remove x86-specific code from generic headers
Date: Thu, 18 Jul 2019 00:28:52 -0300
Message-Id: <20190718032858.28744-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Hello,

This version is mostly about splitting up patch 2/3 into three separate
patches, as suggested by Christoph Hellwig. Two other changes are a fix in
patch 1 which wasn't selecting ARCH_HAS_MEM_ENCRYPT for s390 spotted by
Janani and removal of sme_active and sev_active symbol exports as suggested
by Christoph Hellwig.

These patches are applied on top of today's dma-mapping/for-next.

I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
been build tested.

Changelog

Since v2:

- Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
  - Added "select ARCH_HAS_MEM_ENCRYPT" to config S390. Suggested by Janani.

- Patch "DMA mapping: Move SME handling to x86-specific files"
  - Split up into 3 new patches. Suggested by Christoph Hellwig.

- Patch "swiotlb: Remove call to sme_active()"
  - New patch.

- Patch "dma-mapping: Remove dma_check_mask()"
  - New patch.

- Patch "x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header"
  - New patch.
  - Removed export of sme_active symbol. Suggested by Christoph Hellwig.

- Patch "fs/core/vmcore: Move sev_active() reference to x86 arch code"
  - Removed export of sev_active symbol. Suggested by Christoph Hellwig.

- Patch "s390/mm: Remove sev_active() function"
  - New patch.

Since v1:

- Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
  - Remove definition of ARCH_HAS_MEM_ENCRYPT from s390/Kconfig as well.
  - Reworded patch title and message a little bit.

- Patch "DMA mapping: Move SME handling to x86-specific files"
  - Adapt s390's <asm/mem_encrypt.h> as well.
  - Remove dma_check_mask() from kernel/dma/mapping.c. Suggested by
    Christoph Hellwig.

Thiago Jung Bauermann (6):
  x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
  swiotlb: Remove call to sme_active()
  dma-mapping: Remove dma_check_mask()
  x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header
  fs/core/vmcore: Move sev_active() reference to x86 arch code
  s390/mm: Remove sev_active() function

 arch/Kconfig                        |  3 +++
 arch/s390/Kconfig                   |  4 +---
 arch/s390/include/asm/mem_encrypt.h |  5 +----
 arch/s390/mm/init.c                 |  8 +-------
 arch/x86/Kconfig                    |  4 +---
 arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
 arch/x86/kernel/crash_dump_64.c     |  5 +++++
 arch/x86/mm/mem_encrypt.c           |  2 --
 fs/proc/vmcore.c                    |  8 ++++----
 include/linux/crash_dump.h          | 14 ++++++++++++++
 include/linux/mem_encrypt.h         | 15 +--------------
 kernel/dma/mapping.c                |  8 --------
 kernel/dma/swiotlb.c                |  3 +--
 13 files changed, 42 insertions(+), 47 deletions(-)

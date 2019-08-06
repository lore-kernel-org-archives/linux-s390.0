Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfHFEts (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Aug 2019 00:49:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x764kaDH064441
        for <linux-s390@vger.kernel.org>; Tue, 6 Aug 2019 00:49:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u6ws91kk0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 06 Aug 2019 00:49:47 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 6 Aug 2019 05:49:46 +0100
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v4 0/6] Remove x86-specific code from generic headers
Date: Tue,  6 Aug 2019 01:49:13 -0300
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190806044919.10622-1-bauerman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Lianbo Jiang <lijiang@redhat.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Hello,

This version has only a small change in the last patch as requested by
Christoph and Halil, and collects Reviewed-by's.

These patches are applied on top of v5.3-rc2.

I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
been build tested.

Changelog

Since v3:

- Patch "s390/mm: Remove sev_active() function"
  - Preserve comment from sev_active() in force_dma_unencrypted().
    Suggested by Christoph Hellwig.

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
 arch/s390/mm/init.c                 |  7 +------
 arch/x86/Kconfig                    |  4 +---
 arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
 arch/x86/kernel/crash_dump_64.c     |  5 +++++
 arch/x86/mm/mem_encrypt.c           |  2 --
 fs/proc/vmcore.c                    |  8 ++++----
 include/linux/crash_dump.h          | 14 ++++++++++++++
 include/linux/mem_encrypt.h         | 15 +--------------
 kernel/dma/mapping.c                |  8 --------
 kernel/dma/swiotlb.c                |  3 +--
 13 files changed, 42 insertions(+), 46 deletions(-)

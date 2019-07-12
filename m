Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbfGLFlO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 01:41:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6C5aQEO013077
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 01:41:12 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpj07mb1h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 01:41:12 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 12 Jul 2019 06:41:11 +0100
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 0/3] Remove x86-specific code from generic headers
Date: Fri, 12 Jul 2019 02:36:28 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190712053631.9814-1-bauerman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Hello,

Both powerpc¹ and s390² are adding <asm/mem_encrypt.h> headers. Currently,
they have to supply definitions for functions and macros which only have a
meaning on x86: sme_me_mask, sme_active() and sev_active().

Christoph Hellwig made a suggestion to "clean up the Kconfig and generic
headers bits for memory encryption so that we don't need all this
boilerplate code", and this is what this series does.

After this patch set, this is powerpc's <asm/mem_encrypt.h>:

    #ifndef _ASM_POWERPC_MEM_ENCRYPT_H
    #define _ASM_POWERPC_MEM_ENCRYPT_H

    #include <asm/svm.h>

    static inline bool mem_encrypt_active(void)
    {
	    return is_secure_guest();
    }

    static inline bool force_dma_unencrypted(struct device *dev)
    {
	    return is_secure_guest();
    }

    int set_memory_encrypted(unsigned long addr, int numpages);
    int set_memory_decrypted(unsigned long addr, int numpages);

    #endif /* _ASM_POWERPC_MEM_ENCRYPT_H */

I don't have a way to test SME nor SEV, so the patches have only been build
tested. They assume the presence of the following two commits:

Commit 4eb5fec31e61 ("fs/proc/vmcore: Enable dumping of encrypted memory
when SEV was active"), which is now in Linus' master branch;

Commit e67a5ed1f86f ("dma-direct: Force unencrypted DMA under SME for
certain DMA masks"), which is in dma-mapping/for-next and comes from this
patch:

https://lore.kernel.org/linux-iommu/10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com/

Thiago Jung Bauermann (3):
  x86/Kconfig: Move ARCH_HAS_MEM_ENCRYPT to arch/Kconfig
  DMA mapping: Move SME handling to x86-specific files
  fs/core/vmcore: Move sev_active() reference to x86 arch code

 arch/Kconfig                       |  3 +++
 arch/x86/Kconfig                   |  5 ++---
 arch/x86/include/asm/dma-mapping.h |  7 +++++++
 arch/x86/include/asm/mem_encrypt.h | 10 ++++++++++
 arch/x86/kernel/crash_dump_64.c    |  5 +++++
 fs/proc/vmcore.c                   |  8 ++++----
 include/linux/crash_dump.h         | 14 ++++++++++++++
 include/linux/mem_encrypt.h        | 15 +--------------
 kernel/dma/Kconfig                 |  3 +++
 kernel/dma/mapping.c               |  4 ++--
 kernel/dma/swiotlb.c               |  3 +--
 11 files changed, 52 insertions(+), 25 deletions(-)

-- 

¹ https://lore.kernel.org/linuxppc-dev/20190521044912.1375-12-bauerman@linux.ibm.com/
² https://lore.kernel.org/kvm/20190612111236.99538-2-pasic@linux.ibm.com/

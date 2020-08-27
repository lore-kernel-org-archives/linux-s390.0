Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726395AbgH0IFO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:05:14 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 00/13] mm/debug_vm_pgtable fixes
Date: Thu, 27 Aug 2020 13:34:25 +0530
Message-Id: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

This patch series includes fixes for debug_vm_pgtable test code so that
they follow page table updates rules correctly. The first two patches introduce
changes w.r.t ppc64. The patches are included in this series for completeness. We can
merge them via ppc64 tree if required.

Hugetlb test is disabled on ppc64 because that needs larger change to satisfy
page table update rules.

The patches are on top of 15bc20c6af4ceee97a1f90b43c0e386643c071b4 (linus/master)

Changes from v2:
* Fix build failure with different configs and architecture.

Changes from v1:
* Address review feedback
* drop test specific pfn_pte and pfn_pmd.
* Update ppc64 page table helper to add _PAGE_PTE 


Aneesh Kumar K.V (13):
  powerpc/mm: Add DEBUG_VM WARN for pmd_clear
  powerpc/mm: Move setting pte specific flags to pfn_pte
  mm/debug_vm_pgtable/ppc64: Avoid setting top bits in radom value
  mm/debug_vm_pgtables/hugevmap: Use the arch helper to identify huge
    vmap support.
  mm/debug_vm_pgtable/savedwrite: Enable savedwrite test with
    CONFIG_NUMA_BALANCING
  mm/debug_vm_pgtable/THP: Mark the pte entry huge before using
    set_pmd/pud_at
  mm/debug_vm_pgtable/set_pte/pmd/pud: Don't use set_*_at to update an
    existing pte entry
  mm/debug_vm_pgtable/thp: Use page table depost/withdraw with THP
  mm/debug_vm_pgtable/locks: Move non page table modifying test together
  mm/debug_vm_pgtable/locks: Take correct page table lock
  mm/debug_vm_pgtable/pmd_clear: Don't use pmd/pud_clear on pte entries
  mm/debug_vm_pgtable/hugetlb: Disable hugetlb test on ppc64
  mm/debug_vm_pgtable: populate a pte entry before fetching it

 arch/powerpc/include/asm/book3s/64/pgtable.h |  29 +++-
 arch/powerpc/include/asm/nohash/pgtable.h    |   5 -
 arch/powerpc/mm/pgtable.c                    |   5 -
 mm/debug_vm_pgtable.c                        | 170 ++++++++++++-------
 4 files changed, 131 insertions(+), 78 deletions(-)

-- 
2.26.2

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42F48BD56;
	Wed,  7 Oct 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373357; cv=none; b=p5a/+RRdsq04iFXI+mzSEw6XDs7La8VXUbeS8ICjMY+CIW8aB+nT/k5OduWk5eOW5dTG3PbSm1yMNaVI5ufwi/Q8ZkwD236GdMEb2YJTlYVDNJ7KEvrM5GD/gXSUF1mHBPHCsV4IYl+QKCOBAQ++Z6KT363B7p7OzRl012Ow54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373357; c=relaxed/simple;
	bh=ENIWVkor4gLjOo5AmICO7pJ9vAFQgSO90Q+TttI5M64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJ0mEc7lUL3Ikq7tzevJ63fcsTlnTfMRY14HLuGakg79wXXvoeFDLg6UfoY//aQDpUgieGk75m1GXlK5WIezKFaRV1O7W07tnVarh8FuXT+2G73116KCy/2XIZH38HLoK2Q+uIty7AhxQGTVLX9QBfwWHZa40cpJdzwqR3jkEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b6hXKOA4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b6hXKOA4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZuvB2400453;
	Wed, 7 Oct 2026 11:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=c9EMoYB6T0wMfGVYaUxSquLvrDtSzCog3Wbp6Jo8V
	q4=; b=b6hXKOA4h6UFtLUdxWzOdNf1JoStxVX7cXwx9RI+RDamXGK8zDETxaEky
	M681GM1Ha3qhZda/ihbha5Hw/LAYLPOSVy/j2JX29KzLWBgwYEp9X5D5O3MxLGcb
	djw6aZJukIa3uV71+6eSNPaubNT6RWE2V9TRimk/wWhRmYemQonq4fAc9E+xKcC9
	kPu7V11QZ0OcrXdH5Qs05Sj3/CQE21d++ImFiYraKrlc5W6p0c1toaCF5RUjuqkT
	JbJtNdv9ZSG9K0RA5EkbpHSiI41z/3O2froomvJ4P3cBq24SySCq8WPiF4Fq2N3t
	CijJRhqNmn6QfzPrZ7bTTADAnqJpQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbvc5fn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWcwe1810425;
	Wed, 7 Oct 2026 11:42:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek2ka0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Bfxeb45154630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 070112005A;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D33B2004B;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 77CBD160862; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v8 00/15] s390/mm: Batch PTE updates in lazy MMU mode
Date: Wed,  7 Oct 2026 13:41:43 +0200
Message-ID: <cover.1791365932.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YZpebUi1ohTJ19ZHo1gM0dcRm2Snm0y5
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=vWxzslZmAAAA:8 a=3TpcdIXXsA1J5E0z9WEA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=W-V1AfKMsUyx0yxTjrDY:22
X-Proofpoint-GUID: l8CyGvrUlQeVgM66WRRZl9KQkfB58jPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX5aFVUCPwOnoR
 Z5G3ixAeqWGa76/FO81pddWq9kjdzko0GOjTeHwMAcdeY9Q1IUdadOV9/jh+RW01fu63nVlBPx0
 8Sr2UwIs9tWzlCDGDHa16h79gQ0hlyJUddhD7qn/dtrP+2I9JDtXOmwwlitR7K3mUbjTXuSDOJJ
 pYNZ9ftEKv+kXOyRgKzwpBhVE5s2jR5BG9cXM+Us5luqBD8JQsNvKA0Amnh0Zt+1wvmCcTKWty+
 alMmoxsmQ6B5C+47OO6zuCsC00Vzqep6GNwYNYEx5WSpPhpTYtjQP13IhN8PMPIzaPievFUQgvS
 32d0G3uhmmxgjvq3KysSsZ4c/BflGaZOFI2Jdad0xov+WuSU/3kL/86iYKRXpJMPub/RIljmDY8
 sPnJaYqfnotKOSAZe2b57PkO0pTIcumqbxkxvjA71A5sBpZBnPPUPluUWOqrzDLQbhBBi5OKTSd
 qEogA2C8ghrvutqR/gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXz7HN2Uz2dOUK
 gYGHQe2c/nbyeruWTjERuESQsnjwMnGPCS/4H3lMP6cjyXLAwKb/2nZ3ZO5idhYdx+TRLOdkld2
 hxHaQ46lunkplXwu4r6NteWMFTL4b+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070046

Hi All,

This is v8 of the batched PTE updates in lazy MMU mode rework.

Patches 1-9 are a prerequisite series [1] backported from mm-new to maste=
r.
It is only posted to facilitate the follow-up s390 lazy MMU rework review=
.

Patch 10 is a cleanup that could be picked independently and is
a prerequisite to patch 11

Patch 11 is the s390 variant of the ARM64 series [2] and provides
hw_pte_t type enablement

Patches 12,13 are the lazy MMU mode implementation and the main
objective of this rework.

Patches 14,15 are an additional KASAN-based lazy-PTE guard mechanism.

1. https://lore.kernel.org/linux-mm/20260922-pte0-v3-0-5670b8cb9059@arm.c=
om/
2. https://lore.kernel.org/all/20260922-pte0_arm-v2-0-a3f1ddff0a8a@arm.co=
m/

Changes since v7:
- CPUHP_BP_PREPARE_DYN hotplug event is used to (de-)allocate per-cpu dat=
a
- lazy_mmu_enabled static key is used to indicate the lazy mmu mode avail=
ability
- is_lazy_mmu_active() is implemented using CLIY alternative
- lazy_mmu_count lowcore variable is turned 1 byte to allow CLIY alternat=
ive

Changes since v6:
- bottom-halves are disabled on entering and leaving the lazy mmu mode

Changes since v5:
- IPTE optimization is not applied to secure guests [4]
- __kasan_(un)poison_pte() are marked as EXPORT_SYMBOL_GPL() [5]
- PTE table poisoning is not applied to architectures with PTE entry size=
=3D
s
  unaligned on KASAN_GRANULE_SIZE [5]
4. https://lore.kernel.org/linux-s390/cover.1783945507.git.agordeev@linux=
=3D
.ibm.com/T/#md98724bd3b66d0a0711deb6089fa541f420566d8
5. https://lore.kernel.org/linux-s390/cover.1783945507.git.agordeev@linux=
=3D
.ibm.com/T/#m9c8b31b4863416732d0cbbc5f5f63290db4522c1

Changes since v4:
- verified that a presumable sashiko performance regression finding [2]
  although appears valid does not really degrade performance
- applied sashiko suggestion [3] and added "direct-pte-access" kasan bug =
=3D
type
2. https://lore.kernel.org/linux-s390/20260623062703.269982B28-agordeev@l=
=3D
inux.ibm.com/#r
3. https://lore.kernel.org/linux-s390/20260623061321.269982A64-agordeev@l=
=3D
inux.ibm.com/

Changes since v3:
- all prerequisite patches are landed in -next and removed from the serie=
=3D
s

Changes since v2:
- lazy_mmu_mode_enable_for_pte_range() renamed to lazy_mmu_mode_enable_wi=
=3D
th_ptes()
  (David Hildenbrand)
- patch "mm/pgtable: Fix bogus comment to clear_not_present_full_ptes()"
  is dropped (David Hildenbrand)
- direct PTE dereferencing KASAN sanitizer added (Heiko Carstens)
- CONFIG_IPTE_BATCH option is dropped (Heiko Carstens)
- PTE_POISON changed from zero to 0x800 (Heiko Carstens)
- allocate per-cpu caches on CPU hot-plug (Heiko Carstens)
- introduced a lowcore field for fast lazy mode checking (Heiko Carstens)
- few minor code changes (Heiko Carstens)

Changes since v1:
- lazy_mmu_mode_enable_pte() renamed to lazy_mmu_mode_enable_for_pte_rang=
=3D
e()
- lazy_mmu_mode_enable_for_pte_range() semantics clarified
- some sashiko comments addressed [1] including one bug fix [1]
- patches 2-4 added
1. https://sashiko.dev/#/patchset/cover.1774420056.git.agordeev%40linux.i=
=3D
bm.com

This series addresses an s390-specific aspect of how page table entries
are modified. In many cases, changing a valid PTE (for example, setting
or clearing a hardware bit) requires issuing an Invalidate Page Table
Entry (IPTE) instruction beforehand.

A disadvantage of the IPTE instruction is that it may initiate a
machine-wide quiesce state. This state acts as an expensive global
hardware lock and should be avoided whenever possible.

Currently, IPTE is invoked for each individual PTE update in most code
paths. However, the instruction itself supports invalidating multiple
PTEs at once, covering up to 256 entries. Using this capability can
significantly reduce the number of quiesce events, with a positive
impact on overall system performance. At present, this feature is not
utilized.

An effort was therefore made to identify kernel code paths that update
large numbers of consecutive PTEs. Such updates can be batched and
handled by a single IPTE invocation, leveraging the hardware support
described above.

A natural candidate for this optimization is page-table walkers that
change attributes of memory ranges and thus modify contiguous ranges
of PTEs. Many memory-management system calls enter lazy MMU mode while
updating such ranges.

This lazy MMU mode can be leveraged to build on the already existing
infrastructure and implement a software-level lazy MMU mechanism,
allowing expensive PTE invalidations on s390 to be batched.

Thanks!

Alexander Gordeev (6):
  s390/mm: Cleanup pXXp_flush_lazy() routines
  s390: Distinguish hardware and software PTEs
  mm: Make lazy MMU mode context-aware
  s390/mm: Batch PTE updates in lazy MMU mode
  mm/kasan: Introduce helpers for lazy MMU mode sanitizer
  s390/mm: Lazy MMU mode sanitizer

Muhammad Usama Anjum (9):
  mm: introduce hw_pte_t for PTE table storage
  mm: rename pointers to software PTE values as ptentp
  mm: use hw_pte_t for generic PTE table storage
  mm: convert PTE table entries in ptep_get()
  mm: convert PTE table entry to pte
  mm: add hw_pte_val for HW PTE storage
  mm/kasan: use hw_pte_t for the early shadow PTE table
  drm/i915: use hw_pte_t for PTE range callbacks
  xen: use hw_pte_t for PTE range callbacks

 MAINTAINERS                                   |   1 +
 arch/s390/Kconfig                             |   2 +
 arch/s390/boot/startup.c                      |   2 +-
 arch/s390/boot/vmem.c                         |  17 +-
 arch/s390/include/asm/gmap_helpers.h          |   2 +-
 arch/s390/include/asm/hugetlb.h               |  18 +-
 arch/s390/include/asm/lowcore.h               |   3 +-
 arch/s390/include/asm/maccess.h               |   2 +-
 arch/s390/include/asm/page.h                  |   3 +-
 arch/s390/include/asm/pgalloc.h               |   6 +-
 arch/s390/include/asm/pgtable.h               | 215 +++++++--
 arch/s390/kernel/uv.c                         |   4 +-
 arch/s390/kvm/s390/pv.c                       |   2 +-
 arch/s390/mm/Makefile                         |   2 +-
 arch/s390/mm/gmap_helpers.c                   |  18 +-
 arch/s390/mm/hugetlbpage.c                    |  20 +-
 arch/s390/mm/lazy_mmu.c                       | 449 ++++++++++++++++++
 arch/s390/mm/maccess.c                        |   2 +-
 arch/s390/mm/pageattr.c                       |  10 +-
 arch/s390/mm/pgtable.c                        |  34 +-
 arch/s390/mm/vmem.c                           |  26 +-
 .../drm/i915/gem/selftests/i915_gem_mman.c    |   4 +-
 drivers/gpu/drm/i915/i915_mm.c                |   4 +-
 drivers/xen/gntdev.c                          |   2 +-
 drivers/xen/privcmd.c                         |   2 +-
 drivers/xen/xenbus/xenbus_client.c            |   2 +-
 drivers/xen/xlate_mmu.c                       |   4 +-
 fs/hugetlbfs/inode.c                          |   3 +-
 fs/proc/task_mmu.c                            |  35 +-
 include/asm-generic/hugetlb.h                 |  15 +-
 include/asm-generic/pgalloc.h                 |   6 +-
 include/asm-generic/tlb.h                     |   5 +-
 include/linux/hugetlb.h                       |  53 ++-
 include/linux/kasan.h                         |  21 +-
 include/linux/mm.h                            |  26 +-
 include/linux/page_table_check.h              |  10 +-
 include/linux/pagewalk.h                      |  10 +-
 include/linux/pgtable.h                       | 127 +++--
 include/linux/pgtable_types.h                 |  23 +
 include/linux/rmap.h                          |   2 +-
 include/linux/swapops.h                       |   6 +-
 include/linux/vmalloc.h                       |   4 +-
 include/trace/events/xen.h                    |  10 +-
 kernel/bpf/arena.c                            |   9 +-
 kernel/events/core.c                          |   3 +-
 mm/Kconfig                                    |   3 +
 mm/damon/ops-common.c                         |   2 +-
 mm/damon/ops-common.h                         |   2 +-
 mm/damon/vaddr.c                              |  20 +-
 mm/debug_vm_pgtable.c                         |   2 +-
 mm/filemap.c                                  |   4 +-
 mm/gup.c                                      |   9 +-
 mm/highmem.c                                  |  15 +-
 mm/hmm.c                                      |   6 +-
 mm/huge_memory.c                              |   4 +-
 mm/hugetlb.c                                  |  60 +--
 mm/hugetlb_vmemmap.c                          |  13 +-
 mm/internal.h                                 |  16 +-
 mm/kasan/common.c                             |  14 +
 mm/kasan/init.c                               |  14 +-
 mm/kasan/kasan.h                              |   2 +
 mm/kasan/report_generic.c                     |   3 +
 mm/kasan/shadow.c                             |   6 +-
 mm/khugepaged.c                               |  50 +-
 mm/ksm.c                                      |  11 +-
 mm/madvise.c                                  |  26 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory-failure.c                           |   6 +-
 mm/memory.c                                   |  86 ++--
 mm/mempolicy.c                                |   4 +-
 mm/migrate.c                                  |   4 +-
 mm/migrate_device.c                           |   4 +-
 mm/mincore.c                                  |   4 +-
 mm/mlock.c                                    |   4 +-
 mm/mprotect.c                                 |  21 +-
 mm/mremap.c                                   |   6 +-
 mm/page_table_check.c                         |   4 +-
 mm/pagewalk.c                                 |   9 +-
 mm/percpu.c                                   |   2 +-
 mm/pgtable-generic.c                          |  20 +-
 mm/ptdump.c                                   |   4 +-
 mm/rmap.c                                     |   6 +-
 mm/sparse-vmemmap.c                           |  22 +-
 mm/swap_state.c                               |   3 +-
 mm/swapfile.c                                 |   5 +-
 mm/userfaultfd.c                              |  32 +-
 mm/util.c                                     |   2 +-
 mm/vmalloc.c                                  |  17 +-
 mm/vmscan.c                                   |   6 +-
 89 files changed, 1269 insertions(+), 512 deletions(-)
 create mode 100644 arch/s390/mm/lazy_mmu.c
 create mode 100644 include/linux/pgtable_types.h

--=20
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627F47277C;
	Wed, 15 Jul 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121775; cv=none; b=mnwb15QA/Ylqtq4KfY3Eg9x4X0zu5mSwm8m2o5Ay548hD7DTpxnG0OQYgypFgEK41tzcaTvIJqB1W6Cm9uwqSD68a/BVdpVLNCF63CE37uOtQTHssfLzj1+oqMslM5/ckSXkTpEpC/nojECEBh7D6U5sh/dtNuu7usNWDQfsYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121775; c=relaxed/simple;
	bh=zL1uHkRpN6v4A54HN0jxUDnu5f59CTM5jwaVSpLZS34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msD7bmrE3hKJSv0bEleZg3EWHm1bDXAf2K3hrFoYr1CFgsYiAlxIqulIO4SPjgr8mDVz7+JUvcYGo4vLwe3aCFgytrzabuGtIfi00nQgM4V6uKFp8lNCuUWucYFAo+RjeWNrz3Pr1OVPmo/qAxOVYZFKXMotgh6brDgqrpIiDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XhHx2mhE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XhHx2mhE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBg6jL4188086;
	Wed, 15 Jul 2026 13:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zrvRKONkIctnT7GLUq69H6eSyaiBYmcbU4wk/GaV1
	k8=; b=XhHx2mhEJqhTF28yZ/ZsLoSKHQ2sufiEFa5uMTnLgP7r63dvzdff8i6a0
	LKoNLcwlhVeThEAfJu+Qil9lwmiJVLOazJtspgNLlX9BRHq7HTDbioydZK6L0DgQ
	YFGsNovQfCewbii8L9x86hNqvOsTJ401+TWA12D9E8F2FMjSlubDBl9dp3bTzrpH
	zfB8KO3cCfBp/4lP7px5avGX98vmS8T6GRaT0+5QAiLIFyqoV+xPRA7i8uL1gJgH
	dl3pgNU1yOqTSNWyaDCjdEsMpSsn3+5W5/ri/4loQe2UYTNJfuHmP4EP/kQzsRJO
	B3n1E4zsYwHX8GbRby3G8pBS9ddzQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2ab4p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:22:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDJdlW006417;
	Wed, 15 Jul 2026 13:22:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k05vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:22:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDMdET50004458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:22:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B09620043;
	Wed, 15 Jul 2026 13:22:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB53220040;
	Wed, 15 Jul 2026 13:22:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Jul 2026 13:22:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id BE88216264B; Wed, 15 Jul 2026 15:22:38 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v6 0/4] s390/mm: Batch PTE updates in lazy MMU mode
Date: Wed, 15 Jul 2026 15:22:34 +0200
Message-ID: <cover.1784121418.git.agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfX8Vg5dXTcIZEF
 jaF0WsAL0e2SOYZVjFH2re5kNqprVC4JDYZezWfzriYv8czHlNR0a7gux9KtBXLlx4mAYtM0s7S
 9iuLO7Uu6620h7e7zikowurgE6KX7sk=
X-Proofpoint-GUID: 3uvqvxQf5dxC4D_8zMYO_7eOfViLUuD1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfXzZB2ZaWRqb7x
 dwMmIJnWKwiZNVI/xXXlwfXmNR3KW6vnEHGTW4ZVyYroFgKpho1T9nV5qsnA24HSnCuuOjzDcZH
 74fqhk7SJSkPtqikbjA839/44KD75Jtj8735jKqvPKIhMQz38lGJRaF1/98iMurq20u9gcsuGKO
 ySwdFpf3/IgkXUlUlmgAuP9vtGNxwCQplQ+qKnNSoCByh7eVVkRzIPDvQNkDCuA5LRBEfXdTMJG
 kAtPUeVW21uJszNxDmO/7etlaIhXT/cACYdV3JAND0euW5hEefuvPTR3f0PpnZnX4oNmYeK9aO5
 ee8OwUVn93xVq2a13loMEIgS/cTsUW5ct6HMBJExxUXIYSGGVPPIXBamipjEYe5SMfBVpjtJ8lp
 iGDf/dWPS6ID/ZVkwzuOa3scPBiWJ+Si9I+vc+L9KrxWf3T/4v4d1oLcnGr9DpmWN2psbEmDv7F
 Pr4lTQfNHuZq6XyvRqw==
X-Proofpoint-ORIG-GUID: A6Vu3jN4j8NekXGnsfVcLGBzYJXFSpgW
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a5789a4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8
 a=1fX-024GrAZ7cXdUNU8A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150131

Hi All!

This is v6 of the batched PTE updates in lazy MMU mode rework.

The presented implementation sets up per-cpu caches in the s390-specific
hotplug callbacks as opposed to CPUHP_BP_PREPARE_DYN hooks. I like this
approach better, since the boot CPU setup is architecture-specific anyway
and the whole SMP-related lowcore initialization is handled in one place.

Changes since v5:
- IPTE optimization is not applied to secure guests [4]
- __kasan_(un)poison_pte() are marked as EXPORT_SYMBOL_GPL() [5]
- PTE table poisoning is not applied to architectures with PTE entry size=
s
  unaligned on KASAN_GRANULE_SIZE [5]
4. https://lore.kernel.org/linux-s390/cover.1783945507.git.agordeev@linux=
.ibm.com/T/#md98724bd3b66d0a0711deb6089fa541f420566d8
5. https://lore.kernel.org/linux-s390/cover.1783945507.git.agordeev@linux=
.ibm.com/T/#m9c8b31b4863416732d0cbbc5f5f63290db4522c1

Changes since v4:
- verified that a presumable sashiko performance regression finding [2]
  although appears valid does not really degrade performance
- applied sashiko suggestion [3] and added "direct-pte-access" kasan bug =
type
2. https://lore.kernel.org/linux-s390/20260623062703.269982B28-agordeev@l=
inux.ibm.com/#r
3. https://lore.kernel.org/linux-s390/20260623061321.269982A64-agordeev@l=
inux.ibm.com/

Changes since v3:
- all prerequisite patches are landed in -next and removed from the serie=
s

Changes since v2:
- lazy_mmu_mode_enable_for_pte_range() renamed to lazy_mmu_mode_enable_wi=
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
e()
- lazy_mmu_mode_enable_for_pte_range() semantics clarified
- some sashiko comments addressed [1] including one bug fix [1]
- patches 2-4 added
1. https://sashiko.dev/#/patchset/cover.1774420056.git.agordeev%40linux.i=
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

Alexander Gordeev (4):
  mm: Make lazy MMU mode context-aware
  s390/mm: Batch PTE updates in lazy MMU mode
  mm/kasan: Introduce helpers for lazy MMU mode sanitizer
  s390/mm: Lazy MMU mode sanitizer

 arch/s390/Kconfig                |   1 +
 arch/s390/include/asm/lazy_mmu.h |   9 +
 arch/s390/include/asm/lowcore.h  |   2 +-
 arch/s390/include/asm/pgtable.h  | 163 +++++++++++--
 arch/s390/kernel/setup.c         |   2 +
 arch/s390/kernel/smp.c           |   7 +
 arch/s390/mm/Makefile            |   2 +-
 arch/s390/mm/lazy_mmu.c          | 401 +++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c           |   8 +-
 fs/proc/task_mmu.c               |   2 +-
 include/linux/kasan.h            |  16 ++
 include/linux/pgtable.h          |  46 ++++
 mm/kasan/common.c                |  10 +
 mm/kasan/kasan.h                 |   2 +
 mm/kasan/report_generic.c        |   3 +
 mm/madvise.c                     |   8 +-
 mm/memory.c                      |   8 +-
 mm/mprotect.c                    |   2 +-
 mm/mremap.c                      |   2 +-
 mm/vmalloc.c                     |   6 +-
 20 files changed, 662 insertions(+), 38 deletions(-)
 create mode 100644 arch/s390/include/asm/lazy_mmu.h
 create mode 100644 arch/s390/mm/lazy_mmu.c

--=20
2.53.0


Alexander Gordeev (4):
  mm: Make lazy MMU mode context-aware
  s390/mm: Batch PTE updates in lazy MMU mode
  mm/kasan: Introduce helpers for lazy MMU mode sanitizer
  s390/mm: Lazy MMU mode sanitizer

 arch/s390/Kconfig                |   1 +
 arch/s390/include/asm/lazy_mmu.h |   9 +
 arch/s390/include/asm/lowcore.h  |   2 +-
 arch/s390/include/asm/pgtable.h  | 157 ++++++++++--
 arch/s390/kernel/setup.c         |   2 +
 arch/s390/kernel/smp.c           |   7 +
 arch/s390/mm/Makefile            |   2 +-
 arch/s390/mm/lazy_mmu.c          | 404 +++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c           |   8 +-
 fs/proc/task_mmu.c               |   2 +-
 include/linux/kasan.h            |  16 ++
 include/linux/pgtable.h          |  46 ++++
 mm/kasan/common.c                |  14 ++
 mm/kasan/kasan.h                 |   2 +
 mm/kasan/report_generic.c        |   3 +
 mm/madvise.c                     |   8 +-
 mm/memory.c                      |   8 +-
 mm/mprotect.c                    |   2 +-
 mm/mremap.c                      |   2 +-
 mm/vmalloc.c                     |   6 +-
 20 files changed, 663 insertions(+), 38 deletions(-)
 create mode 100644 arch/s390/include/asm/lazy_mmu.h
 create mode 100644 arch/s390/mm/lazy_mmu.c

--=20
2.53.0


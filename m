Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0023F482E;
	Mon, 17 Aug 2026 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966394; cv=none; b=tmob6+CV7nwwwFS3PL029MPvzXe81mt994j83Xx6xP+u74iYOOFyRUHUHmzwyLeBFutl8UguqgetItcrXLu/MJ7qd+UBQWFn3iMB7zXjW/xXOKj7cJZeapb7Qc788ihYd5aV/a1Pcg9VxnCnzqh0Y5xNeU1qstxEYCq/WDEL2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966394; c=relaxed/simple;
	bh=8XoROEBT7WcSjPvZO19cv7F88Nhyzzg4fELqWD+HTAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKPrQ/ZLdQKSD7I8bNJJxVC2kiRUAfRpNXgKliE2WADMolw9Mk3Hd8bRfhkauiNkkKhTxQvkJN9sByQYHZsFTNyJIuyqvnpL4NVbTk9hY0Jl8D1FxyEhskCwgBoU4b2IM2WhQPEETlK5h0AKgE4b0TV0sPBg0d38gk1FLags7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KLSxs/wd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KLSxs/wd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVsFk1866232;
	Mon, 17 Aug 2026 11:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6e+ne1rIXYJjE2MvrVaOVaJo/hvVlxdEAI+/2mK+i
	eU=; b=KLSxs/wd7eHcQ2LWQTg/mmD63TkHWrJya8VH0CQDjMLRl2fIE2GWZ1+RT
	j9lnGAT133DsgCkIlMlbm11YUmamfRYse//nVAYj/CwDeQH/cLfzaJUNBUQzL2Rt
	LFchO/bfAkWXufzFSucY51GpZ5N0MTONDxjBgJ0lxVxbMm1GV5pFLWEddmAas3Rw
	JKKpV42/gafwagU34ZOqMn1jvqLQhVEazb+4jI7WvEHzsUdn1b6/6dNini8ZndZC
	4YR51Gj0Up7/PBYq92ookA9YZ1WkwjV6Fy10PtcmW+/ZFbAGW/AnCvy1LFFKadYf
	Fqa7kjKRelXrdsmmAP8c11qsf6vWQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqhy0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 11:33:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HBQkL2029704;
	Mon, 17 Aug 2026 11:33:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xgwsa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 11:33:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HBX2r149152314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 11:33:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781842004B;
	Mon, 17 Aug 2026 11:33:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5184720040;
	Mon, 17 Aug 2026 11:33:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 17 Aug 2026 11:33:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 319F316113B; Mon, 17 Aug 2026 13:33:02 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: [PATCH v7 0/4] s390/mm: Batch PTE updates in lazy MMU mode
Date: Mon, 17 Aug 2026 13:32:58 +0200
Message-ID: <cover.1786956464.git.agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX7fHK6utzTe/D
 NYpr6AHxlDitzhglQc9QUz+PZ5cnkzxJNzAyaoMWOhP70aIrRMS9Lix5jQfG3RLhbR8Aw5eu1Oo
 mqH53364FrllvXQp5o14E72pDwma2jE/8+ADbyUS/YDvQaJpcTkslFnbXFmZeRM0T0QwdDZMhpU
 ud8/Lk0duKRa07eTvRHf4Bb3d/odWHbquDPY8dz+wRxgSh1DbTDgntpAIEsWVLo+IoRO93JjBFf
 epzdRTr7uPeOEzfqs+LSI/0vdUrrUbv+Ovo02OGv+FJhXSuBmfyvS0ZjZgFZzNbVC0FvS/9KAc1
 ELqH4ilmtqK5LRPiwsBLIiEGqI0mHsatBD3/L2pJKim8p6OLqdzh/jpXP+d0mMD7GoomHiiKmxr
 nQN9OLDByeRs8BvYx6k32cmwQMpqyRMpLQ2SRgx6OTiD3mFuhFzVcoqW90xDZrIFsh8fhUps5Tc
 aGIIZud62I6bgGGqeYQ==
X-Proofpoint-ORIG-GUID: Iu-ro_VT6zivZu16bjxxO8LU10f_FYxZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX1Sf9VRau9BSS
 1dg2eNVvSH2AvlPgBg2gJZbta0qNCbyAxJugQ5YlDaXyUFd+pd2qjpOsqXZlDUxJWO+qxtAHZ7D
 EuJViAG+L3L08ufSDyaIaXEzE4SfcuM=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82f174 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
 a=c92rfblmAAAA:8 a=T9aZ4cT7tDVHQAk8hlMA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 9WCtKrOFmYW4zqvzmJX-JNqiUH1MtQD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170087

Hi All!

This is v7 of the batched PTE updates in lazy MMU mode rework.

The presented implementation sets up per-cpu caches in the s390-specific
hotplug callbacks as opposed to CPUHP_BP_PREPARE_DYN hooks. I like this
approach better, since the boot CPU setup is architecture-specific anyway
and the whole SMP-related lowcore initialization is handled in one place.

Heiko Carstens requested some mechanism that would rule out direct
dereferencing of PTE pointers, which otherwise would bypass the per-
cpu cache on s390 and lead to catastrophic results.

To address this request a sparse rework was suggested:
https://lore.kernel.org/linux-mm/cover.1784292223.git.agordeev@linux.ibm.=
com/

But an altenative (huge) MM rework looks as a superior solution:
https://lore.kernel.org/linux-mm/74182e50-b54f-4d2d-a27f-3a59a538d6bc@arm=
.com/
https://lore.kernel.org/linux-mm/20260806083926.1807279-1-usama.anjum@arm=
.com/

Changes since v6:
- bottom-halves are disabled on entering and leaving the lazy mmu mode

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
 arch/s390/include/asm/pgtable.h  | 157 ++++++++++--
 arch/s390/kernel/setup.c         |   2 +
 arch/s390/kernel/smp.c           |   7 +
 arch/s390/mm/Makefile            |   1 +
 arch/s390/mm/lazy_mmu.c          | 418 +++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c           |   8 +-
 fs/proc/task_mmu.c               |   2 +-
 include/linux/kasan.h            |  19 +-
 include/linux/pgtable.h          |  46 ++++
 mm/kasan/common.c                |  14 ++
 mm/kasan/kasan.h                 |   2 +
 mm/kasan/report_generic.c        |   3 +
 mm/madvise.c                     |   8 +-
 mm/memory.c                      |   8 +-
 mm/mprotect.c                    |   2 +-
 mm/mremap.c                      |   2 +-
 mm/vmalloc.c                     |   6 +-
 20 files changed, 678 insertions(+), 39 deletions(-)
 create mode 100644 arch/s390/include/asm/lazy_mmu.h
 create mode 100644 arch/s390/mm/lazy_mmu.c

--=20
2.53.0


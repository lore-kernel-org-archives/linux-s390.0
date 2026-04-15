Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBD3D8116;
	Wed, 15 Apr 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265305; cv=none; b=s4W2Vorwwe8J0WyywYJIJ53U6yPFgF8k5RuH7fihsorj4c6Mrh7m9QeCj4BQRr1IjveL52hn4E7WnjfzFQ0zlHrC3xS4fJp8CdM24ms67TGBSLznAqj2CvAuxVplwezQS+b/tKerBFgbpied9Xn67D5bf4Z3GkJ0JxSo07X8CqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265305; c=relaxed/simple;
	bh=EYo8PTBb6ubRAzLc4mEYBiQWId41sVrT8xSXkr111Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZpVD6Wy9mRrME9xqIq1PvbbcuZQSA50eu62whhRiN2OZbc8LoHFUj92K0NNnGVltlEA2Ha4xS1RYmBTiqk0TvHQc1u6y2Mq7p10NkpBEmYn3fsKB9AInBTNyfDQCd0yaAlUF0jTcEmcNjTKdrTyMMNT/mXWcjVgZOJNxJ2D00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lHQeNcIY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lHQeNcIY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4MmYl2130871;
	Wed, 15 Apr 2026 15:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=VEmAhm9lvbiogU8ihSnPPoJha16C
	+sVKY0V/CVeb6IE=; b=lHQeNcIYzNSTb2fnn2FP+nTElWxFdwl3HpPtbM5mN2aT
	FZubjKWKn7e90i51pSFAmjtK4zBrR4r6Bd/lXspxPZ9pAWnZrjwSlvoqnfFJyV1m
	5XSueWrqFyGJk4Sr7HEG7gruhJvYLTI8mGLlB19fzMkHbzpvbPBRIG6Y25oB0UnN
	dGCQBGmDmMJr8zAlNOcOFTUW/Li0hvG5ScT7QFQRHOr2kSSbz+sJEJVqVLr45PVb
	juAvgRjCfC/Y2lfDudQkDLwdOijgi0jq5gVX+/AaTaGZj61AzKV4WdnSzICdSEY7
	tq+RXaGTE7JvoEACmM8HZpAT8eTFlFjXTHPz9Oc7dQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ngrcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FDp7HT025635;
	Wed, 15 Apr 2026 15:01:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujph1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FF1P8D61800728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:01:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AEC02004B;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4F4520040;
	Wed, 15 Apr 2026 15:01:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Apr 2026 15:01:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id CC295E076B; Wed, 15 Apr 2026 17:01:24 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] s390/mm: Batch PTE updates in lazy MMU mode
Date: Wed, 15 Apr 2026 17:01:18 +0200
Message-ID: <cover.1776264097.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N0DeCq2xMwae5oZnaRepWI6GRn5gK0Fe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEzNyBTYWx0ZWRfX9EsCEdbINvSN
 30rjq7sG1oHpvTCmxFHXui10GBS+DGKbjtu3ju3iJuvvHAzsQSbe1+Sg42vLnc/SLtdcnfSVDR1
 wAm11L4m330fNoydY+XCd45wFzgmLvXqYKe4k1m15Fce6zNC0xpTkQniwv/8E1Qj4vOq1K73RRQ
 XkEaL33N90sBkxg6N2E4mhVJ+63neGHg7C03PsFYNd7betsi2s467rNgk2etR9kg4yDHNYmvPgI
 2yhBxuLUf62ACsffp9D1rY0abVHsitlHjwlX6KMKj7yHgam8ui5ZaXtHxaO6sUoxt/kujVlWRUe
 IQVIFkMlpvcxrN3gqq8IzVZAlPpUVB3EKh086sZT1vuKnGlrVsLvhTKNfzMft5URgRpJkpxRT1+
 1QrtxVSpVl4x2bv631Nu02FqZCsJC1ASinfFqjGRbA62mTI0yI06ithUTcN344yr9pz0l84L51X
 DJC/RdpJLo+iKpotnqA==
X-Proofpoint-ORIG-GUID: N0DeCq2xMwae5oZnaRepWI6GRn5gK0Fe
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69dfa849 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=4FgYxLJZaCZ31HQ3kVcA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150137

Hi All!

This is v2 of the batched PTE updates in lazy MMU mode rework.

Changes since v1:
- lazy_mmu_mode_enable_pte() renamed to lazy_mmu_mode_enable_for_pte_rang=
e()
- lazy_mmu_mode_enable_for_pte_range() semantics clarified
- some sashiko comments addressed [1] including one bug fix
- patches 2-4 added

Patches 3-6 is the actual s390 rework, while patches 1,2 are a prerequisi=
te
that affects the generic code.

Patch 6 needs to be mereged in patch 5 if deemed useful.

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

1. https://sashiko.dev/#/patchset/cover.1774420056.git.agordeev%40linux.i=
bm.com

Thanks!

Alexander Gordeev (6):
  mm: Make lazy MMU mode context-aware
  mm/pgtable: Fix bogus comment to clear_not_present_full_ptes()
  s390/mm: Complete ptep_get() conversion
  s390/mm: Make PTC and UV call order consistent
  s390/mm: Batch PTE updates in lazy MMU mode
  s390/mm: Allow lazy MMU mode disabling

 arch/s390/Kconfig               |  11 +
 arch/s390/boot/vmem.c           |  32 +--
 arch/s390/include/asm/hugetlb.h |   2 +-
 arch/s390/include/asm/pgtable.h | 258 ++++++++++++++++----
 arch/s390/mm/Makefile           |   1 +
 arch/s390/mm/hugetlbpage.c      |  12 +-
 arch/s390/mm/ipte_batch.c       | 400 ++++++++++++++++++++++++++++++++
 arch/s390/mm/pageattr.c         |  42 ++--
 arch/s390/mm/pgtable.c          |   8 +-
 arch/s390/mm/vmem.c             |  82 ++++---
 fs/proc/task_mmu.c              |   2 +-
 include/linux/pgtable.h         |  51 +++-
 mm/madvise.c                    |   8 +-
 mm/memory.c                     |   8 +-
 mm/mprotect.c                   |   2 +-
 mm/mremap.c                     |   2 +-
 mm/vmalloc.c                    |   6 +-
 17 files changed, 781 insertions(+), 146 deletions(-)
 create mode 100644 arch/s390/mm/ipte_batch.c

--=20
2.51.0


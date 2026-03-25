Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052737267C;
	Wed, 25 Mar 2026 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424504; cv=none; b=LvNRDhvbniEXpQM+Iw/XGC4RP2OMjHEJTPzmGzmjNm4EgL2HVxXrnoBLpyxGRAj9luSxcxnbeSAmMVIuXApqL2cjnEu6FRH8rNOZ+OpAhaFG+9YBw2ltwqy5h3nLp9eyoxl0Slzvo5yuQsJ+XCtdH61rsKRlpasYaZIzQqM8MF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424504; c=relaxed/simple;
	bh=DJey7cOD/X74MNW/6oD1QLptfqoZSbqxOm0D/ZVWkfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgM4SPReXnrLeieXN5eC4VSdrm3gw1j85gu8+WIoYuqXjxf4ip/4llx9kpLv/hhVxCYxMDTqQYqxGqyf3YLZRguKwE/huIH7d3jDIf2CovC7VbvOwlmwiqoHJmIc5T/TMNRrZzpxmNKTRD/8XfGILH/CBtx6QsYL0TktcMCCxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DunETyhR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DunETyhR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P6s0T43850414;
	Wed, 25 Mar 2026 07:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PHjQr1TeTUJQnuNftC3BVHoFFmp4yAey/06pHHOJY
	2k=; b=DunETyhRgoPgP3rq4MqQ/nP1cCpqB6jYzOoU2OrU6+rtdnMnW81mkwR2V
	p0b46yOLyZQh+1rDX8daSraj+tfX+1F8G65SiLf/n2YPI2SereUl3fvLvE7PHLgB
	0V1g0zXBaCAMRWxk9wHEFnYwKgunzPRG0o9o4+08suUfgLkP+rx1pLtIm7/7AxXt
	yTH+gEsf/tNCa2/eg022dSpNVFVaRIzeK3QemttcuGL3HdLThv82Io4Jr4ueAHjR
	BwqJKKac707EsoLVQSlH7Gi2uuOlpyKG1ky4PZEd+OhSxYqqklGMQhteMjNr01Xn
	3Q3Vzi9NnvpKoNp9fmf7yUgJXIuNw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqfcb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:41:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P63YmX008722;
	Wed, 25 Mar 2026 07:41:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnnk5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 07:41:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P7fJD959113968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 07:41:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCED2005A;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 816362004E;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Mar 2026 07:41:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 67C63E0723; Wed, 25 Mar 2026 08:41:19 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] s390/mm: Batch PTE updates in lazy MMU mode
Date: Wed, 25 Mar 2026 08:41:17 +0100
Message-ID: <cover.1774420056.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tcrSTXG4jo1D0QMxiBTsSGm3V5p9l42V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1MCBTYWx0ZWRfX0SKZeYKKebmU
 KMy4XYAecKVjRDlzmP2Rn+nzjSRBuW9ooSVfcWGSLUndj6kuD4688f7hbntE27niVa0SwIpKjiI
 Hznp3PyZJOS/q5UcggycOY43nqxJGDbe2f2Zg7H/E4jPsIyb7eMRSDJiyAji5BPBOtZfcNKnaL3
 JbJUJCZjXIMeS9QvvkWUik6pVQWsZD3+bQtKNVg8n7wNTjxImDjMGC6ETaTgIGVdN/yh0Y97PTc
 QtE3DIGyrVuMzOVG+gUOTMm3WePyO/lLTGHfpaDR0RICXH/QcL2ljZXbdpETkuEQxGO7aeM8C6A
 CF7CQTIIuCOlNnkghwkPW+6Zyj9/OTbofv+h+LDEMLn4GCc0joSn7jjt/QazFlTHbXYojuc/lUR
 HBaUC+NEMGsJh6nBXeZaksaum+1zX9C6hXRHdKBD7gXUNwwmSh3BTQ9jhwzrdAV2ENEi2iwFqCJ
 SLAhlAVEpxXx6anZHkw==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c391a6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
 a=OejtQ4jW4XaKWV-sQpAA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: tcrSTXG4jo1D0QMxiBTsSGm3V5p9l42V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250050

Hi All!

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

Patch #2 is the actual s390 rework, while patch #1 is a prerequisite
that affects the generic code. It was briefly communicated upstream
and got some approvals:

https://lore.kernel.org/linux-mm/d407a381-099b-4ec6-a20e-aeff4f3d750f@arm=
.com/#t
https://lore.kernel.org/linux-mm/852d6f8c-e167-4527-9dc9-98549124f6b1@red=
hat.com/

I am sending this as an RFC in the hope that I may have missed less
obvious existing code paths or potential code changes that could
further enable batching. Any ideas would be greatly appreciated!

Thanks!

Alexander Gordeev (2):
  mm: make lazy MMU mode context-aware
  s390/mm: Batch PTE updates in lazy MMU mode

 arch/s390/Kconfig               |   8 +
 arch/s390/include/asm/pgtable.h | 209 +++++++++++++++--
 arch/s390/mm/Makefile           |   1 +
 arch/s390/mm/ipte_batch.c       | 396 ++++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c          |   8 +-
 fs/proc/task_mmu.c              |   2 +-
 include/linux/pgtable.h         |  42 ++++
 mm/madvise.c                    |   8 +-
 mm/memory.c                     |   8 +-
 mm/mprotect.c                   |   2 +-
 mm/mremap.c                     |   2 +-
 mm/vmalloc.c                    |   6 +-
 12 files changed, 659 insertions(+), 33 deletions(-)
 create mode 100644 arch/s390/mm/ipte_batch.c

--=20
2.51.0


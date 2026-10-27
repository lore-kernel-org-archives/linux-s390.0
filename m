Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111437;
	b=XyNY7q82BZsM6W4bddybjMvOef0CLWOPdTGbwDBPTinNVnOynDjHRYxTD+YWt/oJ+3IK
	 l5Cn8f3Di4HrHuI2/dMeJiXeEbYShV+Oxh2uAMxvBUOQZX1+OvzQef2dGHI+wf3mq8GOt
	 zXI5YdtRoBiZEAAEZ6RW78CiqTppQU8VSfQxbLdXF8LBadeCWrFwESYKKZwkqxF2vo+KJ
	 L9eurVVOEhGnVAiblbOJeHRA6Z+f+95eSnxUrdoWMtEC4RBAjEie4hGHnZNjIt3Wh+MXU
	 9scnQxraSjhLrRlfkqSIVulPSyWOakk5c3JJu71PEdcEgyh02DtXcy1LyalK2FLrzsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111437;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=64G8+dISdgGmkcmCrzMWc7X1BGz/9B9ZCw+wC4dp1oA=;
	b=nxYbq+HAglqfvA8r9SZPSqoGjOKRJxF2kpWo4zUTXx8EOqsj8qoF4Q/JfnhsfjGYWTRt
	 UacM+09EBeT981vaDM41bVaoEFVsdvjts3cViuIOxa3zwK89dX75FiV7rsifAVnSsx1gC
	 /C9f3VGnb5qtWeFwO3yb9Up3fGoY1loL3MYI56zsLI1frN8W+w5PEWgfu5SZUljuGn/5O
	 ps9P5Qq+JO2mkfOfasOVsvXCHx6cNIikSR5bd9nSdSys4wGo3cdIcFpr9zksLnyE5RPMi
	 1fvgZ6MOMMT/HifTqh8Zn85W1eym0Xazp1WkEqmgKyHDCU8/oWyOZ+aEJwhehvvrgwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lzdQKGlu;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B43606A31B;
	Tue, 27 Oct 2026 14:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B43606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lzdQKGlu
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEKL11518849;
	Tue, 27 Oct 2026 14:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=64G8+dISdgGmkcmCrzMWc7X1BGz/9B9ZCw+wC4dp1
	oA=; b=lzdQKGluekEMqn3KDkP9hGd25Rd+u4AILGonamQF6PQChiwld78sqOi9q
	yWo5x3rNgt2TDE9eq6zIAM1rtxadjbGiYJkmsQ3mt4OQTY5zBisoWcBcyYH0u6fq
	5tPJ+xpuK1794lVx1QxobwryU1bJGm/q5/h0kmWFbn0nVTSEw8n7AMVKFIMNXhtF
	UoOUauWSTjpQs7o/mZV8eEK1rte20AnLvPvKaQ5zRLkJewADwjI1IUUik200z8nu
	7BoebKGDP98GqqwO8pjXVhvDOiV84L/SOS1wFB0/5I94NXoCN9GtWJN1Zw1qhLzR
	G8KkKE0wHViRyDrTurypTsa/RX78g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3fysgf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoPko4190088;
	Tue, 27 Oct 2026 14:30:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnn8sy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUV8137028236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11C342004E;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05CB2004D;
	Tue, 27 Oct 2026 14:30:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 00/10] s390: Consistent usage of text_mutex
Date: Tue, 27 Oct 2026 15:30:20 +0100
Message-ID: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0b58b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NVAJKBO_cAemxlG4CmYA:9
X-Proofpoint-ORIG-GUID: dndyVhI_mIyL_dtErvxmpEdKPO8ws20-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX4dle1A4Ky1Mf
 qx5rzqxorr+iRnZh+HyhnUldV/5sznhJr267H/vfftoVl2Cg1462AdTP6Fwfc4cTFeOFUcoaZ5H
 hUxAmf+Rs4i3P1fZxu7qLDuBrXm4RBQXEi2UfL69RaVTFiBmBtoahnQtAVtFi+ntjr8as6XXYCE
 nT78k1M2OBKSIb1dH6VqMqXK3CYt4k9L0zZSy++DBez7JEJ24hxcck8UjP27cQDbgQKTDHPZMhx
 xI+4/yOYyitm2y8Ba/j/rjSN22jlqBvMWDXg00gwCaKVjJf8qVyAHM7C4ULr4Sd8Mhfciiq6JxL
 4mIS96pGxOE49KR/rVCN6UQWkqTGEPleSL/O+ebTNXajayobwwj4IIkbyD9SeE42bHEb25SCsaI
 /iDiXE9nhzMAFXjTYTxJg+O1MKgj2dRhjKPZwC1M5bffIckt3hQy1hfXGuf3YWCpGh0hzTjTtvM
 gcMyCn/tM4D7rBLcOFw==
X-Proofpoint-GUID: dndyVhI_mIyL_dtErvxmpEdKPO8ws20-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX7B6suErsb44l
 kyJ5ByDALoQh1nPhw7i3XJVCbuUUrLe2Y3kiHoUXYx38AsN8sLIxtmL0000KnCoy925oQnYWqEm
 FA8srpwqZ+/ZR6b644cYUqaXJ5ptL8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056

v2:
- Use text mutex for all callers of s390_kernel_write(), and add lockdep
  checking. [Based on a review comment from Ilya Leoshkevich, and also
  Sashiko feedback]

- Note: this takes now the mutex also at places where it is technically
  not necessary (e.g. ftrace init nop patching). However this is not much
  of a difference to before, where the spinlock in s390_kernel_write()
  was always taken instead

v1:
Other architectures serialize kernel text patching with text_mutex. s390
does not: __s390_kernel_write() relies on a private spinlock, and callers
partially depend on implicit exclusion (e.g. no kprobe can be set on a
jump label).

Make s390 consistent with other architectures:

- Patches 1-3 add text_mutex to the jump_label, ftrace and bpf text
  patching paths

- Patch 4 removes the redundant spinlock from __s390_kernel_write().
  CPU serialization, previously done implicitly, is now explicit via
  sync_core()

Thanks,
Heiko

Heiko Carstens (10):
  s390/jump_label: Serialize text patching with text_mutex
  s390/ftrace: Serialize text patching with text_mutex
  s390/bpf: Serialize text patching with text_mutex
  s390/runtime-const: Serialize text patching with text_mutex
  s390/module: Serialize text patching with text_mutex
  s390/stackprotector: Serialize text patching with text_mutex
  s390/nospec-branch: Serialize text patching with text_mutex
  s390/alternative: Serialize text patching with text_mutex
  s390/uaccess: Move s390_kernel_write() to asm/text-patching.h
  s390/maccess: Remove spinlock from __s390_kernel_write()

 arch/s390/include/asm/runtime-const.h |  4 +++-
 arch/s390/include/asm/text-patching.h | 14 ++++++++++++++
 arch/s390/include/asm/uaccess.h       |  9 ---------
 arch/s390/kernel/alternative.c        |  6 +++++-
 arch/s390/kernel/ftrace.c             | 11 +++++++++++
 arch/s390/kernel/jump_label.c         |  3 ++-
 arch/s390/kernel/kprobes.c            |  4 +++-
 arch/s390/kernel/module.c             |  2 ++
 arch/s390/kernel/nospec-branch.c      |  4 ++++
 arch/s390/kernel/stackprotector.c     |  6 +++++-
 arch/s390/mm/maccess.c                |  9 ++++-----
 arch/s390/net/bpf_jit_comp.c          | 21 +++++++++++++++++----
 12 files changed, 70 insertions(+), 23 deletions(-)

-- 
2.53.0


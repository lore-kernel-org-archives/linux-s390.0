Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728D7262A;
	Sun, 19 Jul 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466016; cv=none; b=Ly56d2kQ2oceVGiHkpWfyDd+ojMcHiVNTHm9lphMzzvna+WnIHT1Bd2LG0R77c1IdYpODe792NRF0B9NTipVHkMw5MExfljJvBNq+m7W3dyBZIWWKgLksBWxL2zoYwVGDbFx6cYOafdf+aeCRikKE8DMebnttYlTjmfjmG4MJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466016; c=relaxed/simple;
	bh=OyYcqMbB9FY2u9nk1si4+E0HCFJIE7B8KifswfndNZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tp93TaZOHK73t+rrr7KYAvHOuS47Wy8t1kvurwBay28XEgWHZwG+5UlApXHClpFHLkMYzIl3pHw4BfghzrGLiFgGFHV+pXahkDSAUx8sc7d1tkNhVYrbZAhR64WEJvxq3lauAj+4CJb1JHfIB2asgOQiP5806/XDYjUTt3ZBkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ScVsxnXr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ScVsxnXr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBBsck3258057;
	Sun, 19 Jul 2026 13:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=siJZ4QHaIqsKL/mro0wAOyhSm+JDHJumBB3JU3LO3
	zI=; b=ScVsxnXrM5mS5R3IMfAZhyz93+Y3oM/ouNJhGNlRo9mCJD1hMSVuZCD8V
	QFEHNn51a0IwukUoqLtAXwXRetKAeJJvDELcji379xxmjx9edUH64vb29UWMTZDh
	KfULxHtQNdP0fe3lLjYF0RERa/h5MmXUp7jwisAwB2cdgMKcnsen7GJGkLFw7Sz2
	MpLNK8w6r0wkl5SZDt2jzT+pqVF1mrevipUWa3glAKtpQZK6kk+fhjRu82s5gdY0
	eBpHuW6FTgVqFmPrvaJuDBVkNNyODcLI8bNOrAREEHiul6pyhDtYqIOZd2zYlH7c
	tzdN9F2tRLstVCmQVZW8wc7f1kKgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fucac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnad6018664;
	Sun, 19 Jul 2026 13:00:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy1c8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD06iL45416818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:00:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A0832004D;
	Sun, 19 Jul 2026 13:00:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69C7B2004B;
	Sun, 19 Jul 2026 13:00:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:00:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] s390: Reintroduce support for DCACHE_WORD_ACCESS
Date: Sun, 19 Jul 2026 15:00:00 +0200
Message-ID: <20260719130006.3882764-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX5DaDKFqThfMD
 kUy/BUSibETFY2m/SGs8qvMBeIDjHFa2n3BthI6v/s6lbMJIOU+Xicgv7kK01J4b7itAsxxWdvJ
 WfxOzypLajq8u2c8WJlDeyzjxKC7QKSGHvGPTAj4buSg+Y57M/5gT0xQGy9C9qCNDmNQwWyPbq3
 tD71c37m0Ub7wd9XzQR2kB3lyVy9ObtVNBh0zpT68ed+WWvzhDX2trOfTvNlBNt+QSnrjeBAXHF
 mePkcYXklcJ/WiGODfmVWtUeU7POvwc5GjvLsMYOVS2A/MI80YE0uPJp+2zPHrxcRalR1oIXMZR
 nfYG9L84anBa0nY3rYYlSTw83AQtO3px/blxTNFELhTKMHEvO8QdtXVqAHWDguze3vz4Xs3O7UR
 OdjFzyySpocu7B909c9BCHLnWzdQwGYzm3KI0oq59YOrrrj/tRh1HbTE+nyaSrovLVN07MQuCMT
 yQUyBopqIi0fWlV0/Ww==
X-Proofpoint-GUID: UGEle3GqFfHzLApijzDHojKzUc-M-zPf
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5cca5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=oTK_JJbRH6YLXrI8L4wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfXw1uYo4ox4Nn7
 LZEqde8KGIqQIocZezSSv9azbVGagg+PFesumz4V+J0z7Wi0tgwMByYwFAMSYbh10djAYW4R+I8
 ZUTP6NqVE3E/k5y66Mdd9476C6eZKYM=
X-Proofpoint-ORIG-GUID: UGEle3GqFfHzLApijzDHojKzUc-M-zPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

v3:
- Fix two more pre-existing bugs reported by Sashiko
- Add Christian's Tested-by tag to four of the six patches

v2:
- Explicitely PAGE_ALIGN size in uv_alloc_stor_var() [Sashiko]
- Document that lazy PTE update / TLB flushing is intended [Sashiko]

v1:
Support for DCACHE_WORD_ACCESS was recently removed [1] since it caused
problems with the incomplete handling of secure storage access
exceptions. It looked like fixing the exception handler would be a larger
effort; therefore support for DCACHE_WORD_ACCESS was removed as a work
around.

Address the potential problems that exist with secure storage access
exceptions and add support for DCACHE_WORD_ACCESS again.

In particular address the following problems:

- Reading the guest variable storage area via the /proc/kcore interface
  results in short reads. Address this by using a VM_SPARSE area for the
  guest variable storage area. VM_SPARSE areas will be handled like
  memory holes (zeros will be read).

- Fix handling of secure storage access exceptions in vmalloc area.

- Remove folio handling for secure storage access exceptions to avoid
  potential data corruption.

[1] 37540b8c287f ("s390: Revert support for DCACHE_WORD_ACCESS")

Heiko Carstens (6):
  KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
  s390/mm: Add missing mm check to do_secure_storage_access()
  s390/mm: Use lock_mm_and_find_vma() in do_secure_storage_access()
  s390/mm: Fix handling of vmalloc area in do_secure_storage_access()
  s390/mm: Remove folio handling for kernel faults in do_secure_storage_access()
  s390: Add support for DCACHE_WORD_ACCESS (again)

 arch/s390/Kconfig                      |  1 +
 arch/s390/include/asm/asm-extable.h    |  4 ++
 arch/s390/include/asm/uv.h             |  2 +
 arch/s390/include/asm/word-at-a-time.h | 22 +++++++++
 arch/s390/kernel/uv.c                  | 65 ++++++++++++++++++++++++++
 arch/s390/kvm/pv.c                     |  6 +--
 arch/s390/mm/extable.c                 | 18 +++++++
 arch/s390/mm/fault.c                   | 20 +++-----
 8 files changed, 122 insertions(+), 16 deletions(-)

-- 
2.53.0


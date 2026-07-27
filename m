Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A84429038;
	Mon, 27 Jul 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170859; cv=none; b=CLWALbf4VLZqkCS8hfhmgE8yIXFhUspe0OuBvT/jP7tYaH5/kqpXKVBGZ/CGLopTnBiQKYhZv9a+j3ulJbGne/NlJm3tkWrP/ix7q+710V8SMEnH6a2YdcERstXVO67Wq4it6eSOhe/Z5wgcrrXMNN5xEHSm4S/jRqRe1l/N7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170859; c=relaxed/simple;
	bh=fnfjUxgX2uIvCVHMNy4VZETaFAiNbcE6B4R75sxVZ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ocxr0n1OD3XWw1n27DK+nDaz7YL6VMo4gO4DqlCHhZUyojLeu3EKsBToQ5UD+2Yg0NTp7sD3+Raq3cbhG/1Tl+z+l1KaypVcUuM3JSryOoqy7jTsXNKbaRF52rousE5ZtzidhgFxmFTX7rYlakTglbwTzSiCr/HydHfg69rPPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pcFkpS+5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pcFkpS+5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnsFh2413039;
	Mon, 27 Jul 2026 16:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oAyKFv3kXswLseKc2ZWYUqe0HAF8lpo0QMZCw3LJ8
	WA=; b=pcFkpS+5xXf7ril1k7KrRpBohxkOWsynkCqvfoOI0S4VBlvu4BTbnjwmm
	zVCwSBplx/BbZdH3B8WYRZsE83/gFHfErKIdU9VKnsD3wIXJlu65d4p6llpLcjdn
	zkx1hr1s3PR1tYNi0YsmYbG9zB6I2VoEgOwjDy0r8lu7HpUleFshtYZ9qOkbuLYi
	Sb9a9dA+QPF72wz7Q0oSQr8mOI6Pp5uUpayRSngl4ibiLFtt7y1buj3XvyjjgYb3
	wn2X44x2iJlgIK3tzuHo+tCwnwV1zwoLVQ7FYx10k3UxTtIWVCj62yENImCJi8Lo
	N9jsxkdSI2DY21MZchxU8d6PMgdVg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrnr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGfFAP022796;
	Mon, 27 Jul 2026 16:47:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjx670-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RGlMee22217218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 16:47:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53CC12024B;
	Mon, 27 Jul 2026 16:24:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E8DC20244;
	Mon, 27 Jul 2026 16:24:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 16:24:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] s390: Remove or replace cond_resched() calls
Date: Mon, 27 Jul 2026 18:24:26 +0200
Message-ID: <20260727162430.1599396-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R4ZDEcc9ylWlximUj_UVR3ERCNGGmq2I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfXxCiMaw+djh58
 Lwo3wNh/EroqRabOcTXCyRRQthONP00gSJceiHZwX5sDVxknBXfjvBbblxJySuRkTeyNp57xBwf
 FkrfZ8FNaRq/fwwDPP0lfevGrGdt6RQ=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a678b9f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Fs_qYlmMC0Zql47DM_AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX2GtlkASbyozm
 xRPZk+W9+OxdfksmcWNl5LGPn9RO3jxz9+qhkzBVBhBaUxhBt5uyvJdFIwYYC9ZYXQjmUTkPYLv
 4tKwrNcNiOTRIq8VWvLOaS6FwAe0MYBib0f7qVIe7u+OpnRx4mSxdC6m4yrLSkCr2b3stTI5uf1
 qSgSyxn8XMQ+BsTbfHtNM3mtI7fFWYed9WCjC/vWRue5B4yvj/zMG8bGFngmKcZrZztnzAGH3aq
 nQR1NjKTnwM2xYF1wYIXyBhQoPGNXDtvUq9IzsXsgYLl3f9iZzQa8Zm+7vIV6jJzvMA5KJGcBFI
 2jKD8nhA8zpWrhP9ANn/0Z4OIVSuFePf5/zs62NcmrJu607lV3Mq1UqllpoUVVXCpIdwVd2UZUj
 ETu7wPX5flIRtJjQXP3ogyXnEJecSvizZzG203Llkm/lEaLdri8p1+seAeCJiGx1Sod5d3OKuN2
 HuulS1aAAjRHk7pqrwQ==
X-Proofpoint-GUID: R4ZDEcc9ylWlximUj_UVR3ERCNGGmq2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270151

Since [1] it is only possible to select the PREEMPT or PREEMPT_LAZY
preemption models for s390. This has caused some minor problems, but
everything has been addressed.

Given that for both preemption models cond_resched() is a no-op remove
or replace it everywhere.

[1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

Heiko Carstens (4):
  s390/crypto: Replace cond_resched() with schedule()
  KVM: s390: Remove cond_resched() calls
  s390: Remove cond_resched() calls
  s390/cio: Remove cond_resched() calls

 arch/s390/crypto/paes_s390.c    | 8 ++++----
 arch/s390/crypto/phmac_s390.c   | 4 ++--
 arch/s390/include/asm/uv.h      | 1 -
 arch/s390/kernel/perf_cpum_cf.c | 1 -
 arch/s390/kvm/gaccess.c         | 8 ++------
 arch/s390/kvm/gmap.c            | 4 ----
 arch/s390/kvm/kvm-s390.c        | 1 -
 arch/s390/kvm/pv.c              | 1 -
 arch/s390/kvm/vsie.c            | 1 -
 arch/s390/mm/cmm.c              | 2 --
 arch/s390/mm/gmap_helpers.c     | 1 -
 arch/s390/mm/pageattr.c         | 5 -----
 arch/s390/mm/pgalloc.c          | 1 -
 arch/s390/pci/pci.c             | 4 +---
 drivers/s390/cio/css.c          | 8 --------
 15 files changed, 9 insertions(+), 41 deletions(-)

-- 
2.53.0


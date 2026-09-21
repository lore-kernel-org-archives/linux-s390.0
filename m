Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564474C14FF;
	Mon, 21 Sep 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006301; cv=none; b=i0RcYqbZTVpVH1/qrgTxg/baY0J8BvTO9o+zda3REktNeQ/qftFn0621RwXcUnFNubhAKoPlNmAw9FZoDgTMDYJ5bLSJ8eRPHg8mPeBj1CFh2+1xg7BVeS0kuMahhNanySmQaJfDCk7gw/ZhXeeTrNBOngafBZHarXY1BJi9hTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006301; c=relaxed/simple;
	bh=D+/Cs4t6gTlsKqDLuK5TLr1/qGMZST3/nj+IgPO+bFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NeUzvW0qyy+atjOxFWBvEMz45C0sphXARjr2iYyGC3jEkwWrAE5aRxKHsfIJSfVc1Hfhr67Hy9RO2e5tfhV3ArmeSLVvn4CAU6PinVdvzdOilZ1DZ4u9YUnbDkHRl6aV0tpgjbI8vqHSOhbFPSYsnH8afB1g5BXHEYHgEmRrvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jQL8qxjT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jQL8qxjT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8J9q1902977;
	Mon, 21 Sep 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pt2LnqOSzZz0Yt0Mzmy+ycliYGK0jQym/x1v4bZQo
	DY=; b=jQL8qxjTvNP2rtinsWaxvZ9BcxZgB0cQ6wImekkaD8YV1m0hWOFwlJmcP
	smjCbsxY4xlfgGAYPn2GBWLiFJQ7YFlHx2sb1O2SyxRqJaEcVLQgJc8are4AnDnR
	moA2rXXghSbBZ/w8tRriiD17yCYRJBfDce73GF46EOQPsPykz8gSK3+weCPubTBe
	2Yfq1S2lRwuohhqktU7M1qU3NNglGkOoqbVeEA+it9VViP5/ZjvcoeyvnH/DjejG
	kpZ2pjUEuEgZLPl0oQEA49/e9HEzvvLmfigUwn7ZIz3lhgDMoZxXq4BPSa5NI9FL
	KzmF1fHSESPI5fwKgygXKOCRtsQhQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv1ak9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHUmS2399637;
	Mon, 21 Sep 2026 15:58:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy5r39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw6Dr41287982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5711420043;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2913B20040;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 00/11] s390: More this_cpu_*() changes
Date: Mon, 21 Sep 2026 17:57:54 +0200
Message-ID: <20260921155806.2447506-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7ASN6u2dw3aALmsWWjLwmGOyn4AqqDG8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX7cx51ypnwP3R
 oeBclLjg7nkLZ5ZixCYCl9Wn6mN6umgsXd39qMZyN7zuV3pqpDOBWQZwkNQFpDq22pSgtMJLacJ
 vwdigqM6GVQgAoOVwHy1s81Xn7+wTuo=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab15412 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=D0pyD9DYDlHxKxV_1YgA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 7ASN6u2dw3aALmsWWjLwmGOyn4AqqDG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX6EureZ+2bSrz
 FOoowYjYIx/YQkmdNPCdAdKHpQiJZAm+Qs0+vss+P3OSI2jpWCv5a8uqq5/px3oEgU3SX3W366D
 Yw1aEZC/ZnrCe8snlKbTt3o2gid7VVKx0f3x39DwC+XkzJGFkS7KeQa3uIeGnTS+rTtrxuQ0Mp6
 L/zgKxa1iuWQrBlOjIyo255u4KCRKp6Y6ER4c9IxGfQsS3VEEMK6pizCbLU8gk/iMKih3Dd7CJ6
 Rrx4Kl+RNYum1But58lcC+6ih6V+DiWSgiOcZFOtyAdnp05kjEA4ORR/WDNWO1gAfCMWEuMN+DR
 bADGWGcv1FsuQaGlfZhPIW7fFNmXkADA67y2g1VD2RrL2n2EMgErFLhi1AdEZTu9rHcb7oUy0tP
 xlGytyrzLDKItVQ5bQBMHkTdnOugZnr2hlfaPfvZZJ7u1vSUSbc26E0pXdRG7bNxCoW7KqFW5xv
 bJB8RItUWOlr9VNQyOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227

v4:
- With the change to la instead of agrk also the register pair cannot be
  mapped to gpr0/gpr1 anymore, since all three registers involved in pcpu
  operations are now used as base or index registers. If gpr0 is used as
  base or index register the corresponding instructions treat the content
  of that register as zero, instead of using its real content. Fix that
  by using the "a" instead if "d" constraint for register pairs. Also add
  another sanity check to cover this. [Sashiko]

v3:
- Add various sanity checks to enforce correct register usage
  [Mark Rutland]

- Use %N instead of %M operand modifier to access odd register of a
  register pair in inline assemblies. Strictly speaking this is not
  correct, since %N is supposed to be used for DImode operands and %M for
  TImode operands. However both gcc and clang handle them identical, and
  there is an existing user of %N in the kernel since many years.
  Therefore use %N to get rid of the not yet released clang 24
  dependency. [Christian Borntraeger]

- Use la (load address) instruction with base and index register to
  generate a CPUs percpu variable address instead of agrk. la is
  available for all architecture levels. This removes the z196
  dependency as minimum architecture level. [Christian Borntraeger]

- Change coding style at some places, and fix various typos in commit
  messages and comments.

- Fix compile error caused by missing semicolon.

v2:
- Yet another brown paper bug: Re-add CPU migration check to last
  patch. Unconditionally recalculating and updating the percpu variable
  address and percpu offset register can corrupt previous context
  register state in several cases (not only the single case reported by
  Sashiko).

v1:
Most of this is only about cleaning up the percpu code after preemptible
this_cpu_*() operations have been implemented. The first ten patches are
all more or less trivial cleanup patches trying to make the code shorter
and more readable.

The only non-trivial patch is the last one, which converts s390's
this_cpu_*() operations to use a similar scheme like Mark Rutland
provided it for arm64 [1]. This allows to simplify the irq entry and exit
path, however at the cost of slightly worse code for this_cpu_*()
operations.

The simplified irq entry and exit code seems to be worth it. Usable
performance numbers are not available yet, however I don't expect big
difference to before.

[1] https://lore.kernel.org/all/20260904161758.376504-1-mark.rutland@arm.com/

Thanks,
Heiko

Heiko Carstens (11):
  s390/percpu: Fix comment typo
  s390/percpu: Add sanity check to GEN_MVIY macro
  s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
  s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
  s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
  s390/percpu: Rename inline assembly symbolic names
  s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
  s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
  s390/percpu: Use percpu code section for this_cpu_xchg()
  s390/percpu: Use percpu code section for this_cpu_cmpxchg()
  s390/percpu: Rework to simplify percpu_entry() and percpu_exit()

 arch/s390/include/asm/entry-percpu.h |  71 ++----
 arch/s390/include/asm/lowcore.h      |   5 +-
 arch/s390/include/asm/percpu.h       | 354 +++++++++++++++++----------
 arch/s390/kernel/irq.c               |  10 +-
 arch/s390/kernel/nmi.c               |   4 +-
 arch/s390/kernel/traps.c             |   4 +-
 6 files changed, 248 insertions(+), 200 deletions(-)

-- 
2.53.0


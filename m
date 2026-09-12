Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB5271464;
	Sat, 12 Sep 2026 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789251520; cv=none; b=gZocgYXseRnzO0sxY++Y3y0jl1SXXESuGEifa1xhz42m4xzahipG7bzgYz7SHgupaYJ8vp2VxsyRqy4ed3UM/l96l2d3xXAvEiTUSyXhEpVypOmWOOiPVGqcMvw8qkqhJVAC+RC6Ukx8xY9dy15zImMXuhB2XOvcHmxgsLbaiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789251520; c=relaxed/simple;
	bh=K2T76TWOKnIpmR5n23o/rPxvxHuGGcOQg3+ni9dDK9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o+YNUqeKtIUC3wglRiO6DGID1Z736TSWR6DlVTTj5TWLWTMkyvYAEfmY5hRviGVgZvvtOrqO+IJADqyNY9UoY/lbT3ZIIedIqwlbJ9vLehOnIrdQ9oG7rUHikJw6fbswzUIg3TPFeE2589nQJgkR/YsxC6yuUBgvAXCZyyM7Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ob98sxVR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ob98sxVR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CM1hKY1488060;
	Sat, 12 Sep 2026 22:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=wqHlALdC6hXgeVeOChxqVWR0z77xgX4cZixik1+ThH0=; b=ob98sxVR
	SdJ5t+FcTZdogP/FPvbdvnUSZmMUK2KB9NnoBdxDUVyJg5zi4Yqyfri6oOUhL8N+
	lLzmo2VN98vRbvm/EAdBsJjmFaEvBB2xiJ5aEqGrZMtBhfnAnMqhdNgfSeIsRcq4
	xWy22FEyj+kLfUxnKSM+bBiqioWoDGIhdR+Ex12jOLX7sX2O0R5a7jjn7Dt3lkzB
	yWeOKvz1H78k0POVg7ijoW8mKpUrLBeIgUlzrCGynwXUjr/ydc+expcsDBKfB984
	rsjV10M/42F0SVZdRw8/fS1PFiYn0XaGv47cVj59dJn/jYifWOmzxQlon8KEaEie
	6XNhyp5fcbXRJQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5haxe0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 22:18:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68CLoB1d3869984;
	Sat, 12 Sep 2026 22:18:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvrmfd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 22:18:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68CMIVv828181010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Sep 2026 22:18:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D368A2004D;
	Sat, 12 Sep 2026 22:18:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95C602004B;
	Sat, 12 Sep 2026 22:18:31 +0000 (GMT)
Received: from localhost (unknown [9.111.2.187])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 12 Sep 2026 22:18:31 +0000 (GMT)
Date: Sun, 13 Sep 2026 00:18:30 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.3-rc3
Message-ID: <ttl9vau@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMyMiBTYWx0ZWRfX+C4Kt0c9s7c5
 5sEqzWsIzJSUJFu6NMWjjU4aEmJtZFgqyG9BqHP21OzfxTbMeWkhio/uNAcpfJucjwfwyGQPQW+
 l7qEPRa08fc0ejt+Eo+ztGXwDzD1Q6JbGxrEc0Lonc513L9/xCnE/ruyNvV//jp8NKqhc4JzOfN
 uQXROi/nsdJgfqiPeEbXoKHDBxe523qj1p89PkCzUXQ4wQtjBFfBcSyLLxd42vVkF+O/6HIcuJs
 r8aYgXs8qt5dz9+j4kn6hRw7SjE+LT21ywp2KUIwK/h/y4lckuBQnqFCMCtdxkYBfKhENp3gd0d
 gx9zihqZag8lZXThmOabJDDVxQyTootgcb505zzsbLFjOhzNLEEMnR8/rlsmM4bshORsz4MHB+X
 gt4rxj9NwUJXDvvf2QtuvCx0oEutsd4Tgc9qaPg3LWf3FzC/nP43ANn2ICq7jtK+nIwCHulqYG8
 bmq1mWDbdx+Vq30Tyqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMyMiBTYWx0ZWRfX4NWrKjR/jndx
 q0aZoyg0m8EvmF5vCtnWaDnQb06mixYhpPjflDznOhag9KQSNy/QCKFZkzdHSNQlMReVPR/hi81
 h0jHIFRYwmNa/QZcZ42vNba3ASZDsXg=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa5cfbc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=60rNVkasl8gHqEbvGwUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r3b6F8WgOz_PQbbjIYwAl0Lrh7h7SrGM
X-Proofpoint-GUID: r3b6F8WgOz_PQbbjIYwAl0Lrh7h7SrGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120322

Hello Linus,

please pull s390 updates for 7.3-rc3.

Thank you,
Vasily

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-3

for you to fetch changes up to dc2136341be9835e70ba7c6b36904cf3683fd029:

  s390/crypto: Enable CONTEXT_ANALYSIS (2026-09-08 15:53:41 +0200)

----------------------------------------------------------------
s390 updates for 7.3-rc3

- Fix NULL pointer dereferences in s390dbf when setting debug levels or
  resizing debug areas while logging events. Remove duplicate messages
  about kernel parameter overrides

- Fix PAI perf crashes when per task events move to newly onlined CPUs.
  Add CPU hotplug callbacks to allocate and free the per-CPU data

- Fix mutex use in atomic context in AES and PAES CTR code by using
  semaphore trylocks instead. Remove conditional locking and enable
  Clang CONTEXT_ANALYSIS for the crypto code

- Fix scatterlist walk error handling in AES and PAES and avoid freeing
  PAES walk resources twice

- Fix missing scrubbing of temporary AES and PAES buffers, including AES
  GCM error paths

- Set missing CRYPTO_ALG_ASYNC and CRYPTO_ALG_NO_FALLBACK flags for PAES

- Fix -EBUSY handling in PAES and PHMAC to avoid cleaning up requests
  already queued to the crypto engine

- Fix PAES and PHMAC requests being completed twice on errors

- Fix PAES and PHMAC hangs when key conversion keeps returning -EBUSY
  by returning -EIO after the last retry

----------------------------------------------------------------
Harald Freudenberger (11):
      s390/crypto: Fix skcipher_walk return code handling in aes_s390
      s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorithm
      s390/crypto: Fix use of mutex in atomic context
      s390/crypto: Fix return code handling at skcipher_walk_done in PAES algorithms
      s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
      s390/crypto: Fix use of mutex in atomic context in PAES
      s390/crypto: Fix missing cra_flags in paes_s390
      s390/crypto: Fix handling of EBUSY in PAES when req is pushed to crypto engine
      s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto engine
      s390/crypto: Fix wrong return code to engine in asynch callbacks
      s390/crypto: Map EBUSY to EIO when key conversion fails repeatedly

Heiko Carstens (1):
      s390/crypto: Enable CONTEXT_ANALYSIS

Mikhail Zaslonko (3):
      s390/debug: Fix NULL pointer dereference in debug_set_level()
      s390/debug: Do not repeat parameter override notice on debug_set_level()
      s390/debug: Fix race between debug area resize and event logging

Thomas Richter (3):
      s390/pai: Use PAI PMU index as parameter replacing event
      s390/pai: Move locking to event init and delete
      s390/pai: Support CPU hotplug for PMU PAI

 arch/s390/crypto/Makefile     |   2 +
 arch/s390/crypto/aes_s390.c   |  87 ++++++++++++-------
 arch/s390/crypto/paes_s390.c  | 188 ++++++++++++++++++++++++----------------
 arch/s390/crypto/phmac_s390.c |  36 +++++---
 arch/s390/include/asm/pai.h   |   1 -
 arch/s390/kernel/debug.c      |  54 ++++++++----
 arch/s390/kernel/perf_pai.c   | 196 +++++++++++++++++++++++++++++-------------
 7 files changed, 371 insertions(+), 193 deletions(-)

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF435432E91
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131081; cv=none; b=S5r2Ise3zvFCytWHkjdjFriISyAMD/MpN4pCNna7qGVXBSXkB2WdKm4sjYqZOt1HCcVAmwyZz4rvt7HA96Hhb1DNpjXv3Z7P3FHnos+MW0AVqJzKlYlUqgTHper2UL9Tfy+BscNLSBzCMslYzVHQdhVzMwjVfJ5Nv0b+kgCZqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131081; c=relaxed/simple;
	bh=9Yd/KIjV4WduYgJdwqh6ChTW5egtgK4niAvvFUt4Uzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCqFGk3x8tg2dZ6HgTxiWmX6ZF5Hd2BfjuCeXPuqAOpwLWoNg184uqM90BPU76Dwqw2RnVoIwG0pgH+qeD71aPgOfwy8y7sOmMdQmuNqhVWY29dRHlTOgx3t2JQOmSkJ9eVF06m6vRsFxk9ZtHdgmp8OJSGog5lgEZM1MG1rCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Se7O1pJC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Se7O1pJC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6VjKV2621738
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OaVdSPenhzx1PUm2FdL5oYRsWiy5jxl0MqJjO+J0i
	as=; b=Se7O1pJCi/OTJHkE3I1fPrMKms8IMFOoI+BJWH7kJ5eZNAD8GCWBgnOtW
	OdPQPeps8UyMporNiTcidzrS6ToNUCg/jgVLcCgygj4m3jDkoxDwJdjJZFltJjAh
	42p8+jz2TyjoAgE6JVZOXnGDF9TLcm/JWoa+QipTjiqGxVQu3ui1h0fjrBlVHiAd
	S3iVDactsIxnSmwZME5Xv1pf6u2pPH/K8yBpLQzcqn0xg5u2Z2c0lwkHPLqPtVQz
	55b9rk+ngN3MmrW1DXtKe5Z50+qZTXzier6RmLCG9RNE2O3tLozygh632spb/0aQ
	U/ge7/RPjr6pYxkJjDyrgwmyznErw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1ar77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9BLj3001819
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw87xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9HZNq51315076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:17:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40BC82004D;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E7CB20043;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.129.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 0/7] Fixes and rework for paes_s390 and phmac_s390
Date: Wed, 19 Aug 2026 11:17:27 +0200
Message-ID: <20260819091734.7331-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a8574b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=bXAP_PYkuvYdcVEYZgwA:9
X-Proofpoint-GUID: DYVBRv1NfJygmRg2QpovjGCIQtibRjAn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX8ctEz8pLt1jT
 0mK45ZsoYRas658Us7pSzRmt7O1i0ZNv+7Nxwe0ExewrXiILT+7Wi5PIBq/LuzRNeiX87KmwBPL
 roCfTukmdDZ0YYotu2ejCz1xxJdwF0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX4s826lFHNYtn
 2yjo/xt9N/xemIJg4YH3zKQugLjSqfC7eKZlzVM+ykFXXyaQG4zim9tU7pxYJP6v/H0G35t15ng
 5CPixDjpweCaYjI1lRZAe5jihFdY0C4aPQw4X+RWi5Vof6wUqBO6YK5TP0NeAUJzvDV5YuJfYhJ
 2M/kL6g8rwuxN8SDrdJWTDnHln0jzpkGXgTUdDZeJSKcLa5Ew7g5qvVXXfIx+h2J9QZwiJ5r5oN
 1fyfmhet8LkMCBk5D59kKu0OuqwM2Inf3Pi1m5b3ffSqWhV6yNO/GOYG48FFbT1Z6n2/0X7GCZM
 vwqkI7Ll1ws62gEffbIBOO2s+XaF5PeAvVQHMUQqAZjQS7iuK6K9Ct5cE9uj7XfPVJt5M4AjoFL
 sSfk5b2EFKl0xS1nPD5k+2q323cfccIfA0qvaIg+sh7bQDHFKJ6ETmUPrHYOSgSuFWe/BlA6P05
 UVp79KBVD+hVL4oOZew==
X-Proofpoint-ORIG-GUID: DYVBRv1NfJygmRg2QpovjGCIQtibRjAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190068

Fix and rework some issues around arch/s390/paes_s390.c and
arch/s390/phmac_s390.c:

- Fix skcipher_walk return code handling in paes_s390
- Add scrub of some temp buffers
- Shift from using a mutex to using a semaphore in PAES CTR
  Surprisingly clang code analysis is able to deal with semaphores and
  thus the shift also fixes the issue with CONTEXT_ANALYSIS enabled.
- And some more fixes related to paes and phmac (see changelog).

For more details please see patch headers.

Changelog:

v1: initial version - however, all these patches are follow up patches
    from a similar patch queue for aes_s390.c
v2: - On one error path in the CTR implementation the scrubbing of a
      temp buffer could be bypassed. Also checked Sashikos claim about
      possible double free but this is not the case.
    - All paes algorithms did not set any base.cra_flags. So now set
      the ASYNC and the NO_FALLBACK flag.
    - If a request is pushed to the crypto engine there is another
      return code EBUSY also indicating success but the code handled
      this as a failure.
    - The very same was with the phmac implementation. So corrected
      the return code handling there as well.   
v3: - Reworked the -EBUSY handling in paes and phmac again. The
      synchronous path could have emitted -EBUSY also and would have
      triggered the failure handling. So map -EBUSY to -EINPROGRESS.
v4: - Mapping EBUSY to EINPROGRESS is not the right approach. So
      reworked again more thoroughly.
    - There came another reply from Sashiko about a possible double
      processing maybe even double free as a result of wrongly
      returning a failure code in the callback functions back to the
      engine when a request has been completed. The callback must
      return 0 - so another patch for this.

Harald Freudenberger (7):
  s390/crypto: Fix return code handling at skcipher_walk_done in PAES
    algorithms
  s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
  s390/crypto: Fix use of mutex in atomic context in PAES
  s390/crypto: Fix missing cra_flags in paes_s390
  s390/crypto: Fix handling of EBUSY in PAES when req is pushed to
    crypto engine
  s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to
    crypto engine
  s390/crypto: Fix wrong return code to engine in asynch callbacks

 arch/s390/crypto/paes_s390.c  | 96 ++++++++++++++++++++++++-----------
 arch/s390/crypto/phmac_s390.c | 32 ++++++++----
 2 files changed, 87 insertions(+), 41 deletions(-)

--
2.43.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA692EC0A7
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302015; cv=none; b=NMVu8nrvq5xVr7Cy9uOf2VudDOyEjgPTsKLUEGjfo312YBa8lT8GIspxzVHUswpO35GrRjEfl6cmCqEGuGvZSN4eCviv6UHQyzbOCdmVxJA7aAtu6IV1MSqoSNY7JpR0mR7aQb8zcRgb2Ks5vDU4v6MTFj6yXrRgyB1GJH45U+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302015; c=relaxed/simple;
	bh=OGF/C8PBaM7Ap4UPk0TcsVWg1Br3H75m9m2IR9HuJOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SL3hNLp/ld/26mcvW0+9C5SgI4spYPbpXK+ZErkEs43UAZD35adQdLp/CDWxX7z6aO9DNlJnM/9+Ntg65h/4wLnhyBm0SQwpHbNIr/jOpaFPxlPkjlRUvbf0zAim6tuskFai6H/2id4duyGstgwrCaIVgQzKFqX6M9zqbmI3PbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qoJ5vfME; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qoJ5vfME"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8VwT2980499
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3hEk18Mf5I38jpKJG83fp0/NStdm5AopjHtW7yZ3n
	kY=; b=qoJ5vfME+FzwMMNHx/Un880Ev67MxFwcEWQUPsueHzQh3AO6ctOiY+Fm9
	00gNGVqRyWKOikTcrLqFONAbYMad5TaALgkwS4ny0TknJ28YMfozptStDJKR73/w
	GGD0eumknREwkY+S2qCzdxTJvv5qxbxjsytAlhqaVI5rgLQ+BCnDPSL1dUbAKkMo
	UA2uQw34rjY2j0hT5XkUIelRrJvYpjkg/vPXn47i7fAsTNCQ8+cEx6N2oQQs3SzC
	xJTLbAKyAYvERLu2ZyYeUrIKZ6dUqowehUqdgYwpHTKSZhmMQ9DLULsBRVg95GEf
	HUpfb+hM5B+7sQ5ercwLtHaQGxwsQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0rafk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fiwW021714
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yuave-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kmMi52035872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 574652004E;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37E7D20043;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 0/9] Fixes and rework for paes_s390 and phmac_s390
Date: Fri, 21 Aug 2026 10:46:39 +0200
Message-ID: <20260821084648.23222-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88107d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=jDsoFWGkZLupzffnQz0A:9
X-Proofpoint-ORIG-GUID: Zfx7GRQ7W-hoJjeIeLxHlwwrCUKoNhRR
X-Proofpoint-GUID: Zfx7GRQ7W-hoJjeIeLxHlwwrCUKoNhRR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX8OxcEpKOOtBY
 tzIa4DD0KxKvL0EL18UDa801JxVrSAVkdi921DZO8MP6EGOFwganqUD0ouRzOuEWn/pevqVv0cr
 rK6KYB7Xoy7zsU57Q27i4zAhq3ySLs8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX8DqMekBS2iYN
 5ovt4RAKoPEFsozBQwpQ1krJvXgZXIoMHWf2hfUJWBXJ20UbnyfzY4jEo84+laZvPA+Ihq3lcb/
 wqTMBHEAV6u6Rwdt8lPqG8wMlB4nOFgKK9cPT4fZbSM9DpnkGLDu+zXoPITav1VNYK2Ct6X/+Ho
 xavDLooxF58mw7MHNUtBCwec7Lp/oVK0TJoi+Xe3IBU7eYoU02kc9e2EkoRPWuaLePitGTpnfy3
 OVK/s7mtfizelqPGdjC1Oa9kTYmoqlj+iyuwS6Rkmw12Ok5acc5U8quS6BoctM6Pkl5RkwL3crW
 pdcZxwe/rAj48xNplAUtWcg+Kq5TYwHlEFA2XaLN944b2P7sjhl1D0qE8tqgsaxHN7qiKBwc3Pz
 5caBN599g0eroPz7OMeh1thEkGodZWABpHN21OBh+GaGLqB4klBY2c31m8QCoAtE/nIly97r3IP
 YXCDOxMELfkJePtpplQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061

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
v5: - Sashiko found a potential for a deadlock with phmac where a
      persistent key conversion failure results in an -EBUSY which is
      as such written into the request. However, -EBUSY is swallowed
      by the engine layer and thus the calling process never gets it's
      callback invoked and may wait forever. So map -EBUSY to -EIO in
      the conversion function when there is a persistent inability to
      convert a key - in the end this is an IO failure. 
v6: - Added Fixes and Cc tags to patch #8.
    - And finally picked Heiko's update on arch/s390/Makefile to enable
      context analysis for the clang compiler.

Harald Freudenberger (8):
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
  s390/crypto: Map EBUSY to EIO when key conversion fails repeatedly

Heiko Carstens (1):
  s390/crypto: Enable CONTEXT_ANALYSIS

 arch/s390/crypto/Makefile     |   2 +
 arch/s390/crypto/paes_s390.c  | 100 +++++++++++++++++++++++-----------
 arch/s390/crypto/phmac_s390.c |  36 ++++++++----
 3 files changed, 97 insertions(+), 41 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
--
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2085331EDF
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235608; cv=none; b=JEQKqMpmhf+gkAKuY85mwh5lswDWvyfIjN0HkjZigXDEGMYZS/rq+wBQFLWx5ptz3xJEpY+6dUW8xa7eGHdljtd6BSaFKkPpx1MvrWFV4J/WlFqSWMkL2dw3oqz49oE2pLrx8B9s1CXMD7zEasTss/XWIFfmWDHSuelLW37zcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235608; c=relaxed/simple;
	bh=B9Rtdkq4tKKJfilESXzohKT1Fwa9hBEztwSAnnAD7d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfWQJ03gfyP0OVrTlxungxK0MhJuHXEk6HD79TGlp15tz6SlM+VlkPLni2D/W7EPyVIbE+pT3ZFpWTNNqHrDBOrk8kwiO4F22SK+3EEtbqHUZRuckYLfdA9rWjIlE3RnIqpjvrk8J4Jy929NHYHkq6cFHPsYKXlRxh7ain2CkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rGeoQZGg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rGeoQZGg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8qGNb3543899
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ouvouWNjj/kPZBUlVNhWY7/eSUZX/vERkDT1Q2kRH
	Hw=; b=rGeoQZGgOLisFdpA6rumz2lKOxOe8uqi44BA152Jq83+QOTb6P/OI4YIr
	pzv5+Mg7KJ3wfKj1or7kXNhDK7+gJxNVISk04fyREUz9fD4TLVxMn07or6ih8PRb
	dJXEfwd3P4Mb13+6s9WVvS3M17M/XR+J1PHapz2sBYZBUfletmc5Kl/9RFPWBW/Q
	Ni2T5ORRR61C2WBSVnfyq2RnNzMOrWN+RoIXANGgmKYOwfPZyR5FzZtEgfyChiZ7
	9FV7rVP9wVL5mtI+GgD0MuY5eZ2nhn2HVDjgbSkag5OXlOwrup/aiznACbgtxUDB
	a3z3wBnfHZmgOjmacKgqx8XfA14Wg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2aqx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEBfoL009642
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xheypw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJvUx39125494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DAF520043;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B0020040;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 0/8] Fixes and rework for paes_s390 and phmac_s390
Date: Thu, 20 Aug 2026 16:19:49 +0200
Message-ID: <20260820141957.19091-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a870d12 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=jDsoFWGkZLupzffnQz0A:9
X-Proofpoint-GUID: 9Q7cmbCfgRtmtxJKHVY-hlOr2r1H7wYp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX9OFdlaugRPON
 Jms71TPcByi7rbb0h79xxupQ8hcpvTT+SyA9aePAOOYhC2KhpINcsW1iOUSW57z1ZIKb0/VLMq0
 HBMx6BxrqqSTRQD7cdBvwBGdekgSQAbvxsuWL7GlsifsgJ9di/HewjuJQXe5GXCRUvXNQ9J1piW
 V+/q/Hs12DYIFoBCF6uDapNpbWnjg1Xfg505XiPko5+RQ/G2rrgU7jhUTUe91hVmFveGuVZRfCo
 369wwYwRO7UD/476mXXBhQQ9j/F9fnB5/L/h3maODIBHUNwgAw4XUFdvozZZXBGRmliCr6WHaKy
 H9w+qHLMQlY0x7834l9ZqdaNwI0WMTow5wTkj2u/hAx9gx0zkGihpRiE1qkShYTxEeB4MSLAp4z
 i2Jnfbfg87mQTEB3lmBQSGTOXSGB5TUd+y1wMKOf97BJsBPaRgchyaqmuZLdYgj6f6yMl0/1fuV
 0mMjwYpZlqzUC0z3dtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX56b+jSpAfUFZ
 4ql+80OTAQN8ryWWkX0fknHgzamu5fvm26ruv28lJCzqzdRwAK4Ls3dc47jEzIhtHuP+2+5j71U
 OocTlvLHCBUjNwaDsBbegZAF9qw8hds=
X-Proofpoint-ORIG-GUID: 9Q7cmbCfgRtmtxJKHVY-hlOr2r1H7wYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105

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

 arch/s390/crypto/paes_s390.c  | 100 +++++++++++++++++++++++-----------
 arch/s390/crypto/phmac_s390.c |  36 ++++++++----
 2 files changed, 95 insertions(+), 41 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.43.0


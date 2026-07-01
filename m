Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6289379C46
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924433; cv=none; b=AsT1uKKym0dkQrSnOa65d21lr9SlALq1U1TBp1Rpfs5goK1c4/b8sZeWrKgoo95E5hWUueocSI7b9zrxhuKKLFx2wiJLQGMcH9UF3JpMfc4d2dD4ZRgZFcKCkDeii/PYwLg+kjFQ/4sO0JPXM2k19lrAbPSq3ix81c8o0LqLZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924433; c=relaxed/simple;
	bh=qWL58z8OHZdFWXiYC74gWOLj3MsSqiI/YLDTL5XNg7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeZiDzgSqd2yHp+KBy3icS/tw321k4qe+/J/+vbJexYZD35PsmfAXkfVxcej2y25EVYcN41oVgCPRCVzRZvhiPdsR3OBOn36nTt6k5SCmetsYVtns6pslEaPSkQ0e+beEXJUtljvF4dzCM+xp3+SaQGv/4AYpiDXZw9pCnMKm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PUaGkZiD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PUaGkZiD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AIRp1446515;
	Wed, 1 Jul 2026 16:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GoUhMALv85KWTwmE9pfYeEgVqyJBhjKP3WIRrlpSN
	cQ=; b=PUaGkZiDS/zG5i4B8Z7LDCEFfz7Alw1FXopuH6bASMT3jiQ4L6l2u0rcX
	AQyEEg3Rsw3ZaLHLG22DzN7WjMgHSZNgLsvDKefCi4UcejGLiI3RJQWjaPkwJJZl
	3TdHOqHhJ+g9csovsKmUo8AOuMpmikk4mStEjBaBXbhml6sC+Oxc+w5dwm0IizLZ
	U7Mg5z/HBGH1ODlo7OYDjnC/0p21S+bqgyG08RwBHXJSkuoOiFhkNgS8igfdUf1L
	K1Zg3bTjYY0gXHfrtKxLJ0rBOWebTd6WsRmkmx13EHm4+MgN0pmcg1BNbzBIwkQ+
	OEjHm1HqZqJY0uarkqCv0aTUs9/sg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjwa9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYmh0015634;
	Wed, 1 Jul 2026 16:46:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gg1tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661Gkpc251118366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C698220043;
	Wed,  1 Jul 2026 16:46:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92E0720040;
	Wed,  1 Jul 2026 16:46:51 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 16:46:51 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 00/21] target/s390x: Extend qemu CPACF support
Date: Wed,  1 Jul 2026 18:46:23 +0200
Message-ID: <20260701164650.95760-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX6IKUFbtLHsdd
 n1cYuuPd5UtPBLlX3v+ivSsb8opwnu1JHBfMpQ35RMTj/LOkiGkWaX8MaabJ1+P13Yey7aJH1zo
 3UeSfwdrkpf2/mVRc1Fdx7jG8nt5bh/c/LT/pAyM3lOEyZxVvCKxoV+/2bbedS62UHOwuQ3ec2o
 TYpSJY/TNddMaF4jMgbmLPlsjUOimd6Zbaq/WGRHB+sPufXmL/DuD6huLfZlYPBGtAGSu9WIkHx
 0N8ZDPeHBYymMRFLT7LG4XIKjHzR0K8meeDTgjkVxRkt67aPsoYVG3P/mB/toKSWpvlm+Awt3Bc
 r7gT6mzZrjXv9IkwbBM7nEVQ+RdwGPsGhMdP/K19v5Fm/yYIZwIXeNEEgdPrJdN8ojwWoSIs6AW
 ZBeArxqgAX4qVIm6EpJdlulhQJl6s3aj/gbqJtcXJ9zo+cxoLUjWLMEslQXNoBdrxs8i1Dqt8kZ
 7n64G8HexqMvKjn1ISA==
X-Proofpoint-GUID: A8Xtc6DjvAcyJE836DlLev-CLZgPiqH0
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a454480 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=F9706GdJSPyeJdtyyJAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX6QlsR1A+cnzo
 pt03lYMeIbfNHL9D4ucTDjf4DVZ2BPq9E+aGr3kgvE1UVvTyDQdPw16j/niyTaAG4bvumYkdIgz
 aq+Z5HpZRGFfbjI/WmhcYpSS67cCBB0=
X-Proofpoint-ORIG-GUID: A8Xtc6DjvAcyJE836DlLev-CLZgPiqH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

This patch series extends the s390 qemu CPACF support to be able to
run a subset of the CPACF instruction cross platform. There have been
requests on the kernel crypto mailing list about a way to test
s390 specific crypto implementations. For example a way to test
s390 CPACF exploitation code like the s390_aes.ko kernel module.

So here now is a set of patches verified on x86 and s390 which
over (slow but working) support for a subset of the subfunctions of
some of the CPACF instructions.

Test: There are some very basic tests included with this patch series
suitable for some CI run. Better test coverage can be done by running
a full blown Linux and use for example the in-kernel crypto modules.
The 'usual' in-kernel crpyto modules will be automatically loaded
which run a bunch of test cases. So there is now support for these
kernel modules:
* sha256_s390x (autoloaded, sha256)
* sha512_s390x (autoloaded, sha512)
* aes_s390x (autoloaded, clear key aes ecb, cbc, ctr, xts)
* pkey_pckmo (autoloaded, derive AES protected key from clear key)
* paes_s390x (not autoloaded, protected key aes ecb, cbc, ctr, xts)
All these modules run selftests if configured by the kernel (which is
enabled by default). Failures are reported via syslog. Additionally
the aes testcases from libica can be run either inside such an qemu
environment or with a static build executed with the qemu tcg
application qemu-s390x --cpu max <static-build-libica-test>.

Changelog:
v1: Initial version with
    - Related code restructured
    - Support KIMD SHA512 and thus SHA256
    - Support KMC AES-128, AES-192 and AES-256 and thus have basic AES
      support (ECB mode) enabled.
    - Support PCC Compute-XTS-Parameter-AES-128 and
      Compute-XTS-Parameter-AES-256 but only for block sequence number
      0. This is a requirement for the next step:
    - Support KM XTS-AES-128 and KM XTS-AES-256. Together with the
      minimal PCC support this enables AES-XTS CPACF acceleration.
v2: - Basic PCKMO support to be able to 'derive' an AES protected key
      from clear key. See header details.
    - Support protected key AES-ECB.
    - Support protected key AES-CBC.
    - Minimal protected key AES-XTS support for CPACF PCC.
    - Support protected key AES-XTS.
    - Support AES-CTR.
    - Support protected key AES-CTR.
v3: - Reordered patches as suggested by Finn.
    - One small bug fix in CPACF_aes.c related to address translation.
v4: - Rename of the parameters based on feedback from Janosch to
      make clear these are registers or ptrs to registers.
      Added Tested by from Holger. Fixed typo "face" -> "fake".
v5: - Add documentation file docs/system/s390x/cpacf.rst which
      describes the state of the CPACF instructions and which
      functions are covered when this series is applied.
      First version sent to public mailing list qemu-s390x.
v6: - Rebase/rework to build on current qemu head.
    - Add docs/system/s390x/cpacf.rst to target-s390x.rst
    - New file crypto/aes-helpers.c with some simple
      functions to support AES modes CBC, CTR and XTS.
    - Slight rewrite of the s390x CPACF implementations to
      use these generic AES mode implementations.
v7: - Update on docs/system/s390x/cpacf.rst to mention
      the zArchicteture Principles of Operation document
      which describes all these CPACF instructions.
v8: - Add a fix which deals with incorrect address handling
      in the sha512 implementation related to fetch and push
      data from/to memory.
    - Slight rework around the capcf function implementation and
      exception generation.
    - Added some more details to the new cpacf.rst file.
    - Fixed some typos and added some suggestions from Finn.
    - Fixed cc handling on return of PCKMO (must not update cc).
    Missing: simple test cases to verify that the implemented and not
    implemented cpacf functions and subfunctions work as expected. But
    see the statement about tests at the header.
v9: - Add simple tests for all the implemented CPACF instructions but
      pckmo (which is a privileged instruction).
    - Reworked the Fix for wrong address to call the wrap function
      inline; rephrased commit header.
    - Improve the header file cpacf.h to hold defines for all the
      cpacf instruction functions and use them in the code.
    - one new commit comprising the base protected key support with
      exposing the xor pattern and wkvp and en/decrypt key functions
      via cpacf.h. So the testcases can use this header file.
    - one new commit which reworks the fetch memory and store memory
      from and to guest (suggested by Ilya Leoshkevich).

Harald Freudenberger (21):
  target/s390x: Fix wrong address handling in address loops
  target/s390x: Rework s390 cpacf implementations
  target/s390x: Move cpacf sha512 code into a new file
  target/s390x: Support cpacf sha256
  target/s390x: Support AES ECB for cpacf km instruction
  target/s390x: Support AES CBC for cpacf kmc instruction
  target/s390x: Support AES CTR for cpacf kmctr instruction
  target/s390x: Minimal AES XTS support for cpacf pcc instruction
  target/s390x: Support AES XTS for cpacf km instruction
  target/s390x: Base support for cpacf protected keys
  target/s390x: Support pckmo encrypt AES subfunctions
  target/s390x: Support protected key AES ECB for cpacf km instruction
  target/s390x: Support protected key AES CBC for cpacf kmc instruction
  target/s390x: Support protected key AES CTR for cpacf kmctr
    instruction
  target/s390x: Minimal protected key AES XTS support for cpacf pcc
    instruction
  target/s390x: Support protected key AES XTS for cpacf km instruction
  docs/s390: Document CPACF instructions support
  crypto: Add aes-helpers file to support some AES modes
  target/s390x: Use generic AES helper functions
  target/s390x: Improve fetch and store mem from and to guest
  tests/tcg/s390x: Add tests for CPACF instructions

 crypto/aes-helpers.c             | 106 ++++
 crypto/meson.build               |   1 +
 docs/system/s390x/cpacf.rst      | 144 +++++
 docs/system/target-s390x.rst     |   1 +
 include/crypto/aes.h             |  14 +
 target/s390x/gen-features.c      |  31 ++
 target/s390x/tcg/cpacf.h         | 312 +++++++++++
 target/s390x/tcg/cpacf_aes.c     | 903 +++++++++++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c  | 228 ++++++++
 target/s390x/tcg/crypto_helper.c | 426 ++++++++-------
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/meson.build     |   3 +
 target/s390x/tcg/translate.c     |  11 +-
 tests/tcg/s390x/Makefile.target  |   9 +
 tests/tcg/s390x/cpacf-kdsa.c     |  59 ++
 tests/tcg/s390x/cpacf-kimd.c     | 164 ++++++
 tests/tcg/s390x/cpacf-klmd.c     | 202 +++++++
 tests/tcg/s390x/cpacf-km.c       | 576 ++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmac.c     |  59 ++
 tests/tcg/s390x/cpacf-kmc.c      | 342 ++++++++++++
 tests/tcg/s390x/cpacf-kmctr.c    | 354 ++++++++++++
 tests/tcg/s390x/cpacf-pcc.c      | 241 +++++++++
 tests/tcg/s390x/cpacf-prno.c     | 130 +++++
 tests/tcg/s390x/cpacf.h          | 570 +++++++++++++++++++
 24 files changed, 4670 insertions(+), 217 deletions(-)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 docs/system/s390x/cpacf.rst
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
 create mode 100644 tests/tcg/s390x/cpacf-kimd.c
 create mode 100644 tests/tcg/s390x/cpacf-klmd.c
 create mode 100644 tests/tcg/s390x/cpacf-km.c
 create mode 100644 tests/tcg/s390x/cpacf-kmac.c
 create mode 100644 tests/tcg/s390x/cpacf-kmc.c
 create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
 create mode 100644 tests/tcg/s390x/cpacf-pcc.c
 create mode 100644 tests/tcg/s390x/cpacf-prno.c
 create mode 100644 tests/tcg/s390x/cpacf.h


base-commit: 20553466cc47af6a8c95f665b601fce3c852e503
--
2.43.0


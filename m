Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1D3CB2C7
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689717; cv=none; b=qPkR9xczpdzEOqPVZs1JJtOMhAcKGc2mzr9K6bfGGVWbVGbGJzL1QjH8NvAJyyf9gB1CH05Jng3ojRhAKquwgbH/fa9umNJAVkXrIxzbBY4PzwNf2aRrCizzDsNsW09sBcjQOojJqc2cZzTEx6YtRRFbUhm1+ZMyg45m7S4uDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689717; c=relaxed/simple;
	bh=D88kjqW7MbW4sT6SmI4kYYNjmIh0C7QC/LFN1O1sk7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7PEkhX3dJ4pjvv8IzkgoZIHhBFhTbfqBG+uXtMG4Ev33x/sw8L9BBrbawAqeW+mOQ0VqGE9j7qJjNZuq4AgHqGZQjHT0+ctr5SdCQK1a42oD/Pb12FniPCuV9Yz3yAw9rcyyJ5DH09PepjSwc64ivMI65AhEPpsJqJnFcy3zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gTPhHiC/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gTPhHiC/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8nQ2G4023014;
	Wed, 17 Jun 2026 09:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Bt0dikeLsoR/i1Gzk/JuVbDRbbQYMANKRJNE4ak7Y
	b4=; b=gTPhHiC/MfL3nmBhuVzfFgwdBEufDNOjFaEMRyvg4CvCTkgDXs8ZxdBPx
	1GI0dlLafbDmW4WwwLlgLPYfCuYJQMbF39bFF6ZBOA+vZlhBpJGAJqecLFR2gbtx
	ovJAIgwsT8eSqDMcJzTOLGEJZDKLpKSaOxVgZZfajJwDEhnU50mKyj39sa5e6cgz
	fmlrwTTKqyYSlCj8weZ/AFQ3K9FdzvO7uzy6xmLkrAEmtOO+KrCMonGCBok5x8o5
	DTVHNwzPDgXbiEsATh70IIzN4H+0f+5IOOKQrpe+hhw9v59+jH3W8fX+9QhGSpgw
	B4eDHCkAS1jhchCzO0swmK+rODHmw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx289p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9Yc4V028281;
	Wed, 17 Jun 2026 09:48:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudvaahdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H9mL8c14483790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 09:48:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DAB72004B;
	Wed, 17 Jun 2026 09:48:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1DDC20043;
	Wed, 17 Jun 2026 09:48:20 +0000 (GMT)
Received: from funtu2.ehn-de.ibm.com (unknown [9.224.92.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 09:48:20 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v7 00/17] target/s390x: Extend qemu CPACF support
Date: Wed, 17 Jun 2026 11:48:03 +0200
Message-ID: <20260617094820.34402-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXzPC6COVdfMmk
 /yDpP+hDdDHTBEY5L1Tg6ehEsBjIOGqr/Ly9hdym8S+sDXrrrjhoeJ24OTVsjM/4MfRCbaTZrYV
 6XS/QOQfUWM/8owPXTJ3gMhHo+gYzqDwk8h9e0PT4kmN9xRtuZeKKHSlGhVkE+7qSF779B8xVa2
 odKcnqLmqK/smRVPg+ptE9xjf2xpYcHr46GZw/twziZg1TvaLBZCmDL7E/hL3Q8/M2aVCW/YFzQ
 MdPfHtmDvfiHnT8azBGwUI1oYDGh27mgKFxn8SsoUZtQYyNdFTM8E/0BYzZufIoDLhd/I2H+rYx
 1rbYw8eBavHL8TcBil552BBBVxs4zPI1mNu1GGcU7ZFMLvCIRxwfFKddVzRqbisDwpq/aSFVn7A
 9Aw74jy+SsEqCF5ybgn8bZlfFpNRRGb3MqkPjYdQ3L9B5oBVP2rwcSpt6IrHv7en07HybR1lE9z
 EZLGv4Lhf93giQqXoWA==
X-Proofpoint-GUID: 8XpdZH2sJOLiB-3XV-5e-Py5TRBEHSlb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX5u+yvr2BKYHK
 eNDhrFLlCyPoYSfmmqnVu7EXc3gS+dZBKVdJRa7FoNfARqWmXIdgYN6eUVyjEpDB6I7EK3VYVd4
 8fOjuolgITMq/x0ZcRlTTJI6WdUJNmU=
X-Proofpoint-ORIG-GUID: 8XpdZH2sJOLiB-3XV-5e-Py5TRBEHSlb
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a326d69 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=8isNsbLcrRSMNWPVaYIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092

This patch series extends the s390 qemu CPACF support to be able to
run a subset of the CPACF instruction cross platform. There have been
requests on the kernel crypto mailing list about a way to test
s390 specific crypto implementations. For example a way to test
s390 CPACF exploitation code like the s390_aes.ko kernel module.

So here now is a set of patches verified on x86 and s390 which
over (slow but working) support for a subset of the subfunctions of
some of the CPACF instructions.

Test: As this series is more or less complete, a full blown linux
can be run and the 'usual' in-kernel crpyto modules will be
automatically loaded which run a bunch of test cases. So there
is now support for these kernel modules:
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
      which describes all these CPAC instructions.

Harald Freudenberger (17):
  target/s390x: Rework s390 cpacf implementations
  target/s390x: Move cpacf sha512 code into a new file
  target/s390x: Support cpacf sha256
  target/s390x: Support AES ECB for cpacf km instruction
  target/s390x: Support AES CBC for cpacf kmc instruction
  target/s390x: Support AES CTR for cpacf kmctr instruction
  target/s390x: Minimal AES XTS support for cpacf pcc instruction
  target/s390x: Support AES XTS for cpacf km instruction
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

 crypto/aes-helpers.c             | 101 ++++
 crypto/meson.build               |   1 +
 docs/system/s390x/cpacf.rst      | 116 ++++
 docs/system/target-s390x.rst     |   1 +
 include/crypto/aes.h             |  14 +
 target/s390x/gen-features.c      |  31 +
 target/s390x/tcg/cpacf.h         |  63 ++
 target/s390x/tcg/cpacf_aes.c     | 955 +++++++++++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c  | 232 ++++++++
 target/s390x/tcg/cpacf_sha512.c  | 245 ++++++++
 target/s390x/tcg/crypto_helper.c | 423 +++++++-------
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/meson.build     |   3 +
 target/s390x/tcg/translate.c     |   2 +
 14 files changed, 1972 insertions(+), 216 deletions(-)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 docs/system/s390x/cpacf.rst
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 target/s390x/tcg/cpacf_sha512.c


base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
--
2.43.0


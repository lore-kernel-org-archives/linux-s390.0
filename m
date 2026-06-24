Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC03A8738
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288658; cv=none; b=eoczr+Kzf/B130ICHz/Rt0kynCIrwTzNF/Mj4G+vnHIu7Ztgn4xwSuQTzD1qZmqNMm5PBonRMfQeccqwJhOkJrvggybS8UuvXH5IaZvq8VuozqHUSZOZspgHe8vX3ePsvDac+yKg/numk7I2F+omUuP6ohjO+3Gx6OvhjfZSAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288658; c=relaxed/simple;
	bh=o1hEsy/I74yZm9sjuKhXfGOVf1nNggbSg/pAK6odnz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjrVqxQnQTs6grJzb9BcS3BUHYgnRkNtv5Ke6v/Uoh+R9L6FpZtPFJbOXh1dk8bZE0//8B5yHfj1oTQpym3dsNYGTr5lf3VNLwYIZIighMGDMEBNMP6sHPknD66umwO5v3p+/5Tyl1TpxGMBkjI9ZouBCgz/qnKvbYIW0hL23zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3RGmzu3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3RGmzu3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6Igcl299878;
	Wed, 24 Jun 2026 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rO25/BnUKkpiimiaryuZW28g617oJv+yyXpJaj/P5
	sQ=; b=D3RGmzu3pwc1Y2WCaAPkbZN9+PwgSvUWhXc2fyHA5WV6XWa9zVsrpst37
	P2/lkAZYOqqlrrDgEvXMNg+XR6FNREMXdyML+jVSRPwelvtrGJr10hkPbid7Pxhj
	1HPecmgRfH2bxrcwmNm+w1rPcRYWNYNQrpnbU6J0PEhb2y7g9UsO+5oo/PlMGgG2
	ktXVVyR8R2rmDJK0WdSbNGZbdlW+mYbnzqIcpqJHZwmHPfTlJ9I4WyYy6H4Jf/iL
	GQt89it9zWDqlbSWSEtaByyCoQtvGjdOcePcyWGunz6VPby1Wh+xd6/kQbwc3MAp
	Q+fA7FtzCC0jBt5wrdg1MdKUutlzQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqu07y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84dTK017273;
	Wed, 24 Jun 2026 08:10:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phfgv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AUqB48628014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C332004E;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A13A2004B;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:29 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 00/18] target/s390x: Extend qemu CPACF support
Date: Wed, 24 Jun 2026 10:09:57 +0200
Message-ID: <20260624081029.23815-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3b90fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=ae0fflXcXhGj7XbWUPMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX/CGtsUdAC+Q9
 CX4fbvEvue2eGxR+8fq5o7qrWb1TYJFgWXvuSCdNYpb0mw7HxMWMhXqiT0bHh0pDhq9SvA4zxEt
 KNM49B5J7hpm64FsSpkRU8XZ9siEne8x6hTLXjzbJPpPUYvPoHWf4RC0CZaAtQvtTT+dJewmzLl
 Yp1Bx6njrV9OMajxkUNpnq7C5BTkwfiwMrmbINc2w3NxJXOaIrTF3PbVNPWoaLil2uMrOc5cAf/
 O/AdB3tTOhIw21OksRfYLCYeTA2L/mW/umKKuh0OGp8ue4NvCfNX8Q+t6d9tZmEEKBKFC7gzm75
 JOe+H962KpX6XGsiQRbbb/4TNRyCEz3DGFiNkRrRfL+G5yxofYiHqxvfYH0arf4VXMp5zA3Aqq6
 Ps69g9MJHOWYaY0U/So1uVU9qvKYKXcNxDtNNzYytaDqNtXyVOHuFZdOaPufRAxo7I1DMo5A3qp
 5/EfZLSKO9iFo7i6B7A==
X-Proofpoint-GUID: L4UJV18MNxjLtre8IO8hDPWDYcMhDWBe
X-Proofpoint-ORIG-GUID: L4UJV18MNxjLtre8IO8hDPWDYcMhDWBe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX8huSj1Y15+bM
 2yb+Rbkd64g5Q4Q0X98vkQbo/fY67hkGXLbcfIjfXph2/mk0SCwtSM47DDVS86rmrqBBtAPjSk9
 Jmw58hnc0Vsi5tJDjJISV0N6AR91aIs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240063

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

Harald Freudenberger (18):
  target/s390x: Fix wrong address handling in address loops
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

 crypto/aes-helpers.c             | 106 ++++
 crypto/meson.build               |   1 +
 docs/system/s390x/cpacf.rst      | 144 +++++
 docs/system/target-s390x.rst     |   1 +
 include/crypto/aes.h             |  14 +
 target/s390x/gen-features.c      |  31 +
 target/s390x/tcg/cpacf.h         |  66 +++
 target/s390x/tcg/cpacf_aes.c     | 956 +++++++++++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c  | 232 ++++++++
 target/s390x/tcg/cpacf_sha512.c  | 245 ++++++++
 target/s390x/tcg/crypto_helper.c | 426 +++++++-------
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/meson.build     |   3 +
 target/s390x/tcg/translate.c     |  11 +-
 14 files changed, 2020 insertions(+), 217 deletions(-)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 docs/system/s390x/cpacf.rst
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 target/s390x/tcg/cpacf_sha512.c


base-commit: 3b50303f9563a42538a1fd5c0ea7f952e23016e1
--
2.43.0


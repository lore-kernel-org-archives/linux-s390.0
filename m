Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154123BCF7
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697364; cv=none; b=Di+bfm40UZcCeOfyZopQxsLmunYX151tloJzTPIKbwHaE8XBmyu6HANosuzafA0QF8mFV5NBb2ddQFiKSBHsBxorNYuBnEa0Dp0j+mdBnTlM8kdaZHs7ofHBP80wRxktmlqf+A6I7+GtRoYQLSLxbjx+TPA3UAAkotaW6aeejns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697364; c=relaxed/simple;
	bh=Kth0IFJkoJunq+J5bGOJ8btpTYy4otq+94AZ/RKqcXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XesjU91aDJXfckRGZJ164+nkEcNWkQGx/CXtL0kbQ0H9loXLdCGHN8gy8MQ5lez3eNdeqpyysp0fSNOJl2hAt/3KYaIQ9BEZm81o0q/RXL8jPQDp0qmQ7VAP/SFpAxpUVDlooeHeWdYLbuL8b/Wa242DI7fH3z6C7wM4SpARLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CpcY4WJp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CpcY4WJp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmE1i1906802;
	Fri, 10 Jul 2026 15:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ixIRxAtrWP7R9feocAGhHHrT7GMvsYKk8ilW7UoZi
	/c=; b=CpcY4WJpa72+5fTPtiIF7R/rPnoblsKk7YOsVzHie27hlwDpCwiQ3APmI
	fESReJSB2di+74RFPcF7IbMYt3084gjEuO5VVurbp2zIgJWyjERlcOsV+GsiRv1L
	QlctonATGvXG6aRCjPtKnhFaEk5Lqt4O24o3JrYJEzSHeJMfeIzzYgw2FvZilVNp
	cth3W1v+ATxvF2o8ginoOjsF+PmPl7Jl6IWiGGmY5DsBVrSACDGQSaaEwZFSuN2B
	2bylJEmdCtHcwJcl8i4s9knMTP225lYLlpsDg1Uvzi7mhiW2flkoPdUqRxbt0aD6
	dlQ0j/Jg8USP1ov19zixqgieGMglA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur75sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AFJeet003168;
	Fri, 10 Jul 2026 15:29:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwjt2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFT7iJ49480142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:29:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6043C2004B;
	Fri, 10 Jul 2026 15:29:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D5AD20040;
	Fri, 10 Jul 2026 15:29:07 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:29:07 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v12 00/17] target/s390x: Extend qemu CPACF support
Date: Fri, 10 Jul 2026 17:28:46 +0200
Message-ID: <20260710152906.80207-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX691QEPsocf/n
 riEQEJ/zm8vb7c9sUs3Ikk6QNmBONxoWJ8oyMjIYNuzSZ38zVupE284kcjcnbl9Uo7jRGR6TEZf
 1jlKlNr+EYO1bgGLE5bACN3wagDnl28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX4g+7AY0NBPOc
 sdloReB1mOS7qXHORFoewmHLm2hqAS6455MHVUlReFV37tf33K9HsOT1PWEFkpN0sh0ISz9saWZ
 yrlvrQ8qKE4bBUjhmQtDF8BA6fG7s7tVQtZtiSaFkrD/5XVet7swyloqrhJKZwFqSoaM4JSKMxE
 E03bOSSh9YcyHgRPcE2IBGHVkh18vhJtALWLOcXtypjS8EKgtfbsPxuuBLZrltOMMITpARtkxEk
 NXc+z0KIB3tCOrKLXzTckEuB/Rl8/eEyiS7LXyrvodBpwPlEe36Np0wZoZuV5Mowx37oV9pJ++P
 VLR/dLHnV9n1ZXnZakvUtWxRh+3XzXZr+lyj/0rmJ47NWibTKsbxAdsXE06zwflvO4EANZiS5sZ
 M5/dEhImpy8GB8jgv5cNfjuExu0VAlNdDYcxC43ifCmcVxpX8ABvbMw1eKIbPbcFCefK7vwE0jz
 x6lVKtVzOCSmKHkkzag==
X-Proofpoint-GUID: bPJ1J5aYxgNr1RD_Cc9eFexjpjNYYZHP
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a510fc8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=ub7y4zZ0EdBwlokmjyoA:9
X-Proofpoint-ORIG-GUID: bPJ1J5aYxgNr1RD_Cc9eFexjpjNYYZHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100153

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
v10: - Fixed v9 patch 3 (cpacf_sha512.c was missing)
     Please note that patch #10 "target/s390x: Base support for cpacf
     protected keys" produces a build warning ("unused function"). As
     by default the qemu build has warnings=errors enabled, this one
     patch does not build on it's own. If this is not acceptable, the
     hunk introducing the two functions may be moved to the next
     commit; another solution would be to merge with patch #11.
v11: Fixed nearly all checkpatch findings - only the warnings about
     Maintainers may need update is still there.
v12: - Very first patch is integrated in master and thus removed from
       this series.
     - New header file include/crypto/aes-headers.h as suggested by
       Daniel. Moved the patch which introduces the aes helpers before
       the actual AES cpacf implementations and reworked all the code
       to use these helpers.
     - Merged together "Base support for cpacf protected keys" and
       "Support pckmo encrypt AES subfunctions" to fix the broken
       build caused by unused functions.
     - Merged the changes from patch "Improve fetch and store mem from
       and to guest" directly into the code where it is introduced.

Harald Freudenberger (17):
  target/s390x: Rework s390 cpacf implementations
  target/s390x: Move cpacf sha512 code into a new file
  target/s390x: Support cpacf sha256
  crypto: Add aes-helpers file to support some AES modes
  target/s390x: Support AES ECB for cpacf km instruction
  target/s390x: Support AES CBC for cpacf kmc instruction
  target/s390x: Support AES CTR for cpacf kmctr instruction
  target/s390x: Minimal AES XTS support for cpacf pcc instruction
  target/s390x: Support AES XTS for cpacf km instruction
  target/s390x: Base support for cpacf protected keys and pckmo
  target/s390x: Support protected key AES ECB for cpacf km instruction
  target/s390x: Support protected key AES CBC for cpacf kmc instruction
  target/s390x: Support protected key AES CTR for cpacf kmctr
    instruction
  target/s390x: Minimal protected key AES XTS support for cpacf pcc
    instruction
  target/s390x: Support protected key AES XTS for cpacf km instruction
  docs/s390: Document CPACF instructions support
  tests/tcg/s390x: Add tests for CPACF instructions

 crypto/aes-helpers.c             | 106 ++++
 crypto/meson.build               |   1 +
 docs/system/s390x/cpacf.rst      | 146 +++++
 docs/system/target-s390x.rst     |   1 +
 include/crypto/aes-helpers.h     | 116 ++++
 target/s390x/gen-features.c      |  31 ++
 target/s390x/tcg/cpacf.h         | 312 +++++++++++
 target/s390x/tcg/cpacf_aes.c     | 903 +++++++++++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c  | 227 ++++++++
 target/s390x/tcg/cpacf_sha512.c  | 241 +++++++++
 target/s390x/tcg/crypto_helper.c | 422 +++++++--------
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/meson.build     |   3 +
 target/s390x/tcg/translate.c     |  11 +-
 tests/tcg/s390x/Makefile.target  |   9 +
 tests/tcg/s390x/cpacf-kdsa.c     |  58 ++
 tests/tcg/s390x/cpacf-kimd.c     | 166 ++++++
 tests/tcg/s390x/cpacf-klmd.c     | 206 +++++++
 tests/tcg/s390x/cpacf-km.c       | 590 ++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmac.c     |  58 ++
 tests/tcg/s390x/cpacf-kmc.c      | 351 ++++++++++++
 tests/tcg/s390x/cpacf-kmctr.c    | 360 ++++++++++++
 tests/tcg/s390x/cpacf-pcc.c      | 245 +++++++++
 tests/tcg/s390x/cpacf-prno.c     | 131 +++++
 tests/tcg/s390x/cpacf.h          | 571 +++++++++++++++++++
 25 files changed, 5053 insertions(+), 213 deletions(-)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 docs/system/s390x/cpacf.rst
 create mode 100644 include/crypto/aes-helpers.h
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 target/s390x/tcg/cpacf_sha512.c
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


base-commit: f893c46c3931b3684d235d221bf8b7844ddbf1d7
--
2.43.0


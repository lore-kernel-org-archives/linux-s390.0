Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A892DECD3
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029224; cv=none; b=mCOeuQBlyKqNtB8TJMstmPaLbK8siWh6grb/rGZOixhvnoa2qhi/3w4FtSO+BChzf9twCXLm8FtttNH9SZltcvNirv1ORrQ5mgD6AoSBFUjlxggw6N2cvdkba0IKoUQbZzRPD8L3JgqJB0d+KdNXtYWJl6uH1hxObJaNoc6Jwmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029224; c=relaxed/simple;
	bh=Sh/YBMn9Fj0bYclXdzep6Dcu7EFOMVos/9xhxiKJUOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNm2gUB1/eS6/yfuurNMGCxYfE5NyRCFuu4M32F3I0nFOBFMK9JVBiRCoVYIbsHXWnKLrcall8JvfgU8ULQHp+dgGicj0+nrFeLkhprxkFSLS20C1VDyOfRjvyh0g68POkMpYAWLnsT4jBgYrk0DSUE8ijmXBBfgipZKQAnw9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qXXMOZi8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qXXMOZi8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Eo8Ax3015451;
	Thu, 6 Aug 2026 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=7BjIvkPzUjD5gbTzNNggx+mibIvb
	RWszI59/KhUskj8=; b=qXXMOZi85O5V6Z/maPUbM4bT+tIjKKcqapAg+3LNXMu8
	bOoUTfskw1OQ+Pj3PB8g76ZEH8LBOhug9xf5bnIzjVzPdDsGGtwiDCcyQaAm3cGK
	r1fHmIzWQiKUoYJ9j6addMbYiI5aaANTsFvofb93dbz9bbCyqypcuquHujdGoaZX
	12uK4mK0tska0GF1zet6wNxBWwrngb5o4vcO/4hUGd3YdudA46f0/hzfGr+sVdRD
	dYDfEz6S+IqPXtBOmaMYUyi3dzdG4wnPtHaqVMjdFcAIe9bosKi5YlVtHFQoq0i8
	tcncLpiak1463wCPAEuw4jsBHOBz2QXh2FbQecVlZA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8ev092n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:13:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FBJmF005659;
	Thu, 6 Aug 2026 15:13:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kbprg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:13:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676FD2J039649722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:13:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C4920043;
	Thu,  6 Aug 2026 15:13:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F4602004B;
	Thu,  6 Aug 2026 15:13:02 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:13:02 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v14 00/19] target/s390x: Extend qemu CPACF support
Date: Thu,  6 Aug 2026 17:12:42 +0200
Message-ID: <20260806151302.26846-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jqmXIjedDdUDN6ggY33hanxpQJ2WlHJ5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfXxMLcAFlPz2Bu
 DuhEH8aEs2yEiRTBNwRUqsv/O7zXtKdiTDjVXLDzCHuEwxmscdoh6x24ncTiosbIeK4ngs9RdUn
 nqaYAaRJuJeb5m+lYiALldLMUVNvfD4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX6Lh6x/bXGtR4
 SLogzt2HEDeSWJmXVe70W4TmSbDDVtK1+L0/MKwE8Q2NAJNprC7r5sYtkdngXPlXHPoCF1vr+ue
 d/7JDoSk2c9kmU79QgPjam/AqbiAOWp3w/K9mbQPMse7IYVeZsHwm78RnY7551lq0hakf9SAAaO
 sR5a3zePcFQX8CSGUiLYS65lp/e6EgXiW8t+L/ffu4kriLJHRrX06GXOdWja5kB8UQh6D4YU80T
 CxZ8bjr/JSFpL1n2sYtSsawG8Hb9fN3qYutnO/nfODdlArzeLmG1T1+xghYzpjF+fYViI5XHHi6
 xMCV4uSiaC0sW509NDnmLq2tY+OXzXBMaaKmPuzZVtT7gKhst3E5cCD7AZmC6HcmulehIZfgEPG
 H1RshPTNHOfqIlgWUl++sswWTOaBUAgQXVqtzhCgMr6pP2EIYNOx8EMb40i1/5fmMLVFUxZkI+U
 KKdfL7AsMvANPZ2q6bA==
X-Proofpoint-GUID: jqmXIjedDdUDN6ggY33hanxpQJ2WlHJ5
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a74a483 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=3YebopYHS2Y058ClqBAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060115

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
v13: - reworked the helper functions to copy memory from and to
       guest. These are now inline functions located in
       target/s390x/tcg/crypto_helper.h and have been renamed and
       extended for u32 and u64 as well. Also the both sha
       implementations have been reworked to use these helper
       functions. See patch #4 for details.
     - fixed the wrong list of parameters docu in patch #5
     - added some Reviewed-by tags.
     - reworked the testcases to run (more or less) on real s390
       hardware. However this does not and can not work with protected
       keys.
     - rebased to current master head.
v14: - fixed one wrong constant in target/s390x/tcg/cpacf.h
     - added 1 patch (patch #1) which fixes the missing privileged
       flag with the PCKMO instruction.
     - added a simple testcase for the PCKMO instruction (see
       tests/s390x/tcg/cpacf-pckmo.c for details).     

Harald Freudenberger (19):
  target/s390x: Fix missing privileged flag at PCKMO instruction
  target/s390x: Rework s390 cpacf implementations
  target/s390x: Move cpacf sha512 code into a new file
  target/s390x: Support cpacf sha256
  target/s390x: Add helper functions for copy memory to and from guest
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
 docs/system/s390x/cpacf.rst      | 146 ++++++
 docs/system/target-s390x.rst     |   1 +
 include/crypto/aes-helpers.h     | 109 ++++
 target/s390x/gen-features.c      |  31 ++
 target/s390x/tcg/cpacf.h         | 312 +++++++++++
 target/s390x/tcg/cpacf_aes.c     | 874 +++++++++++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c  | 186 +++++++
 target/s390x/tcg/cpacf_sha512.c  | 200 +++++++
 target/s390x/tcg/crypto_helper.c | 423 +++++++--------
 target/s390x/tcg/crypto_helper.h | 100 ++++
 target/s390x/tcg/insn-data.h.inc |   3 +-
 target/s390x/tcg/meson.build     |   3 +
 target/s390x/tcg/translate.c     |  11 +-
 tests/tcg/s390x/Makefile.target  |  10 +
 tests/tcg/s390x/cpacf-kdsa.c     |  58 ++
 tests/tcg/s390x/cpacf-kimd.c     | 166 ++++++
 tests/tcg/s390x/cpacf-klmd.c     | 206 ++++++++
 tests/tcg/s390x/cpacf-km.c       | 590 +++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmac.c     |  58 ++
 tests/tcg/s390x/cpacf-kmc.c      | 351 +++++++++++++
 tests/tcg/s390x/cpacf-kmctr.c    | 360 +++++++++++++
 tests/tcg/s390x/cpacf-pcc.c      | 245 +++++++++
 tests/tcg/s390x/cpacf-pckmo.c    |  45 ++
 tests/tcg/s390x/cpacf-prno.c     | 131 +++++
 tests/tcg/s390x/cpacf.h          | 571 ++++++++++++++++++++
 27 files changed, 5083 insertions(+), 214 deletions(-)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 docs/system/s390x/cpacf.rst
 create mode 100644 include/crypto/aes-helpers.h
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 target/s390x/tcg/cpacf_sha512.c
 create mode 100644 target/s390x/tcg/crypto_helper.h
 create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
 create mode 100644 tests/tcg/s390x/cpacf-kimd.c
 create mode 100644 tests/tcg/s390x/cpacf-klmd.c
 create mode 100644 tests/tcg/s390x/cpacf-km.c
 create mode 100644 tests/tcg/s390x/cpacf-kmac.c
 create mode 100644 tests/tcg/s390x/cpacf-kmc.c
 create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
 create mode 100644 tests/tcg/s390x/cpacf-pcc.c
 create mode 100644 tests/tcg/s390x/cpacf-pckmo.c
 create mode 100644 tests/tcg/s390x/cpacf-prno.c
 create mode 100644 tests/tcg/s390x/cpacf.h


base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
--
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA617FAC2
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501824; cv=none; b=O6FLVzJN2EqSkYTMWnOYhjx3+rVXg+UR/GNOgsT/7mlc+DV+enZBiMQDMZbC7XeUH/VfBKMnz431OSN2cuO99CPCG6XsqoME2luI4igGVe73g9jZ8UvyPyekXzoa/911zjiGbmK1qmcEchVct4/XvE0pjwmrELWIFGYYxFKVq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501824; c=relaxed/simple;
	bh=hQD3cLYFXerNsPp1FRp85YrM7y9PQ8TVDy3BVq0PFAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T88iUiQFF5tZWviiwDrqszPJWN7cjc/3FOytp+jqfFikSn8Jo4e+XICGWkaoucuDnnRygMR9SRGf4jwZ5rVorFg+LhzvFhRzWIotZ7aiW1YR5IhmSq0XZ8nDd7R3zxvomIpIkFBEGoReIDbRGHGwEjibfemIL3Xkhdk3xIsDho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHDAHuLQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHDAHuLQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAXtDA013704;
	Thu, 24 Apr 2025 13:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8oY8gEpnMtY4Rmonq+SDHUJz3bNcbrLAhtk+8IW0r
	K4=; b=HHDAHuLQDj1I84xTwHZ1z1tEQo4XR/80gYXXnRwwl4Ch4EihgwkyOxGBM
	EsVEgsyVSAjfCAurxTLVVUEmGW3GEvTMwuNfdyRH3tREPhe3yAX4jnoJBO+9DKJ5
	4D/p7plyK2amSQ9xgVnoJdowzn04iqrg8ldAyTw3FgqO/N0DF4x3+Ma4LGRkVfYp
	kpSdynou6gMNmr8XO7NbQmubgY3LB07XeRj6WTcrKSv/HLJoUAwo1XzkwNIqVpwQ
	M0alQOvxG9pGJb3NuRi2LceE2N1/G7VGeOyGy/qokzofbHcLGmjI4bgbm0/yc/Y4
	ZnGXR11A1O47fha3X3eG5AhFdwkhQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678bwbq1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBfDiQ028407;
	Thu, 24 Apr 2025 13:36:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvrcg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaKEZ14221798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195432004D;
	Thu, 24 Apr 2025 13:36:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A936E20043;
	Thu, 24 Apr 2025 13:36:19 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Date: Thu, 24 Apr 2025 15:35:54 +0200
Message-ID: <20250424133619.16495-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX4QvAqFn6X98P o+uBZqpCcVHz8VzUG19hsW4GdU2pToU311V4gTrQSQjba5K8WO+RXJxBXfzztTgKYfoey3e+Owo c5jCqGuOGgXfdHeNLaMa9TcDhG3Zyp2pObEa8GidChe37YL/puCTt5pi8TkXS+OiMNIYQ5M9dqO
 N22O8EpCC5pf345612fHx1FfRsvtd8K69gBtX3FIpOz7NtAVOmZ0x+QyoxBIt7wpE9IsaSbXHNm En0IqGc8d3BQ+L9+65pQr/sIzeOwb7SJ0NAuJI5So1DEqe38M4SlOh+jG60izN/EG58YLDl7Ebe knGfw5HqnaBL8vJJsayCgYHgJ11Gq8bAAvSBr2KzX8gG/ewSdmqkVLnXB+K4TfOUQXWu1vRimu1
 MtCVv0VOXOw/1n/Il1CVMFgCcPCj4TW97nNYPwvoaysmlXeJtT9b/RATp+KhnddA+6VZ0Kkd
X-Proofpoint-ORIG-GUID: wAQnOAKe6aK9NJ-ESzWgCBhcXKBiJ8kq
X-Authority-Analysis: v=2.4 cv=KZzSsRYD c=1 sm=1 tr=0 ts=680a3e7b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=YG_P9kPGDIcRJ2qUHdsA:9
X-Proofpoint-GUID: wAQnOAKe6aK9NJ-ESzWgCBhcXKBiJ8kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

This series of patches has the goal to open up a do-not-allocate
memory path from the callers of the pkey in-kernel api down to
the crypto cards and back.

The asynch in-kernel cipher implementations (and the s390 PAES
cipher implementations are one of them) may be called in a
context where memory allocations which trigger IO is not acceptable.

So this patch series reworks the AP bus code, the zcrypt layer,
the pkey layer and the pkey handlers to respect this situation
by processing a new parameter xflags (execution hints flags).
There is a flag PKEY_XFLAG_NOMEMALLOC which tells the code to
not allocate memory which may lead to IO operations.

To reach this goal, the actual code changes have been differed.
The zcrypt misc functions which need memory for cprb build
use a pre allocated memory pool for this purpose. The findcard()
functions have one temp memory area preallocated and protected
with a mutex. Some smaller data is not allocated any more but went
to the stack instead. The AP bus also uses a pre-allocated
memory pool for building AP message requests.

Note that the PAES implementation still needs to get reworked
to run the protected key derivation in a real asynchronous way.
However, this rework of AP bus, zcrypt and pkey is the base work
required before reconsidering the PAES implementation.

The patch series starts bottom (AP bus) and goes up the call
chain (PKEY). At any time in the patch stack it should compile.
For easier review I tried to have one logic code change by
each patch and thus keep the patches "small". For the upstream
version I intend to fold them together into only a few commits.

Changelog:
v1: initial version
v2: - Rework on patch 0001 and 0002 based on feedback from Holger.
      Also there was one place in zcrypt_msgtype50.c where still
      an ap msg buffer was alloacated.
    - Rework on patch 0003 - fixed feedback from Holger. Also the
      min poolitems is now a module parameter and defaults to 8.
    - Rework on patch 0004 - as suggested by Holger the "userspace"
      parameter is now included into the ap msg flags.
    - Rework on patch 0005 - nr of cca cprbs in the mempool is now
      a module parameter.
    - Rework on patch 0006 - nr of ep11 cprbs in the mempool is now
      a module parameter.
    - Rework on patch 0007 - as suggested by Holger instead of
      implementing a copy-and-pasted new function
      zcrypt_device_status_mask_ext2() use and extend the existing
      the existing function to avoid code duplication.
    - The rest of the patch series needed adaptions but there is
      no functional change compared to v1.
v3: Rework based on feedback from Holger:
    - There is now one zcrypt module parameter "mempool_threshold"
      controlling the cprb mempools for CCA and EP11. The default
      value of 5 shall cover 5 CCA or EP11 requests/replies in parallel.
    - The cca and ep11 card and domain info cache is done - anyway
      nearly all callers used the verify=1 to enforce the retrieval
      of fresh information. So now this info is always freshly fetched
      from the card/domain.
    - Holger found out that there are some unused functions lurking
      around - deleted :-)
    - The only thing still missing is no-mem support for the UV
      driver. As of now the pkey uv layer refuses to contact the UV
      dd in case the NOMEMALLOC flag is given.
    - Tested and found no issues.
v4: Still some minor changes:
    - The UV patch is now part of this patch series
    - With that came a slight rework of the pkey uv handler code.
      It is now pre-allocating one struct for use with the UV driver.
    - The zcrypt api module parameter mempool_threshold is now
      checked and enforced to have at least a value of 1.
    - Heiko found some things, for example the mempool_create()
      was for some reason checking for PTR_ERR which does not apply to
      the used way of creating the mempools - fixed in all patches.
    - Heiko also had the question about the artificial limit of
      16 APQNs as target addressing for EP11 cprbs. Together with
      Holger we found out, that this is not needed at all - so yet
      another patch now reworks this code (see patch "s390/zcrypt:
      Avoid alloc and copy of ep11 targets if kernelspace cprb").
v5: - new patch for the uv code to support another non-malloc
      interface function ("s390/uv: Rename find_secret() to
      uv_find_secret() and publish")
    - with that a slight rework of the pkey uv handler which is
      now able to retrieve uv protected key secrets without malloc.
    - new patch for the uv code to remove the old interface function
      ("s390/uv: Remove uv_get_secret_metadata function").
    - Lots of minor reworks triggered by review comments from
      Holger.
v6: - Typo in patch header and other patch header text improvements
      fixed
    - zero page to be used for uv before calling
      uv_find_secret().
    - added the latest signed-offs
    - tested, looks good
v7: - Requested changes from Holger on patch #4 where missing.
      Added. No other changes.
v8: - Fixed warnings from clang compiler about uninit variable,
      fixed findings from Heiko about possible memset on NULL ptr.
      Changed: patch 0002, 0006, 0007
      
Harald Freudenberger (25):
  s390/ap: Move response_type struct into ap_msg struct
  s390/ap/zcrypt: Rework AP message buffer allocation
  s390/ap: Introduce ap message buffer pool
  s390/zcrypt: Avoid alloc and copy of ep11 targets if kernelspace cprb
  s390/ap/zcrypt: New xflag parameter
  s390/zcrypt: Introduce cprb mempool for cca misc functions
  s390/zcrypt: Introduce cprb mempool for ep11 misc functions
  s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
  s390/zcrypt: Introduce pre-allocated device status array for cca misc
  s390/zcrypt: Introduce pre-allocated device status array for ep11 misc
  s390/zcrypt: Remove unused functions from cca misc
  s390/zcrypt: Remove CCA and EP11 card and domain info caches
  s390/zcrypt: Rework cca findcard() implementation and callers
  s390/zcrypt: Rework ep11 findcard() implementation and callers
  s390/zcrypt: Rework cca misc functions kmallocs to use the cprb
    mempool
  s390/zcrypt: Propagate xflags argument with cca_get_info()
  s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of
    kmalloc
  s390/zcrypt: Rework ep11 misc functions to use cprb mempool
  s390/pkey: Rework CCA pkey handler to use stack for small memory
    allocs
  s390/pkey: Rework EP11 pkey handler to use stack for small memory
    allocs
  s390/uv: Rename find_secret() to uv_find_secret() and publish
  s390/pkey: Use preallocated memory for retrieve of UV secret metadata
  s390/uv: Remove uv_get_secret_metadata function
  s390/pkey: Provide and pass xflags within pkey and zcrypt layers
  s390/pkey/crypto: Introduce xflags param for pkey in-kernel API

 arch/s390/crypto/paes_s390.c           |   6 +-
 arch/s390/include/asm/pkey.h           |  15 +-
 arch/s390/include/asm/uv.h             |   5 +-
 arch/s390/kernel/uv.c                  |  47 +--
 drivers/s390/crypto/ap_bus.c           |  74 ++++
 drivers/s390/crypto/ap_bus.h           |  30 +-
 drivers/s390/crypto/pkey_api.c         |  50 +--
 drivers/s390/crypto/pkey_base.c        |  34 +-
 drivers/s390/crypto/pkey_base.h        |  37 +-
 drivers/s390/crypto/pkey_cca.c         | 134 ++++---
 drivers/s390/crypto/pkey_ep11.c        | 117 +++---
 drivers/s390/crypto/pkey_pckmo.c       |   9 +-
 drivers/s390/crypto/pkey_sysfs.c       |   4 +-
 drivers/s390/crypto/pkey_uv.c          |  44 ++-
 drivers/s390/crypto/zcrypt_api.c       | 167 +++++----
 drivers/s390/crypto/zcrypt_api.h       |  16 +-
 drivers/s390/crypto/zcrypt_ccamisc.c   | 486 +++++++++----------------
 drivers/s390/crypto/zcrypt_ccamisc.h   |  49 +--
 drivers/s390/crypto/zcrypt_cex4.c      |  39 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  | 454 +++++++++++------------
 drivers/s390/crypto/zcrypt_ep11misc.h  |  27 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  36 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 109 +++---
 23 files changed, 961 insertions(+), 1028 deletions(-)


base-commit: bffb31040cb61aa72de8ffac655fe1459d581505
--
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6B13D891
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727089; cv=none; b=FmApBgtMpxoIMw+TLTLnYxOflCHfEuMeIAXh6W7UTkqdip+t5iVY2WgVltuGQDztAgH/vg0EHdjOpaqWXArU/r2XJVguF2KwfHHA4FIcoXndfeihepY+a8e7JogkfvtDj2RaYjy3bLRi2mVWHC30GVQjeVSM+fDXQyGJuC+bswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727089; c=relaxed/simple;
	bh=5qmf0svNpoNYABuiGWLcygjmi358F6yLvP4c4ofCXZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVfKXcF3zoDGZ8ITiVPOxFJGDKVPx2Rh/zeigbIIeUEgTr92nWXQBHXhxEAcyhKcqAxq1MOtdp5hcVRkZzNX7me8o3zHOpJPUvI5RVD1J6cCgEb0/2GtfMlUe1zpd2L0Ptu083MKWEa4ASP9eKp9Bvqo/8qv17ErSHRYSWo4ZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hy6JrPYw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hy6JrPYw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAejSY021131;
	Tue, 15 Apr 2025 14:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=l1iw3S6uey7DjXL5+mzc9RbzpzQRpFg7h4wKMV2ea
	ag=; b=hy6JrPYwAX4rgJZvQ688JtAXPyPJwmRU+RU9QhQwZ26vyALSmzD1aupPl
	oTWJkKyqnj0K4orzKEpspTpO691qwx661ml9LF/Hd/icuZLBp0YDWRAVyUv1pSEX
	qz/tTsmBIdGehK0Z1isXBO2BHn02RQihqzCPDYK7RE5+LOuhjn7Rlxp4x/iK/RRB
	ipwS2q0utkeuWo/iIXTYOQuDkE294OFHPtlr3KwaT6VdzIirvbQq16eBtukxgtc7
	QxrExDvClORr+qg8EAzHbiMBEy+Ika4H80orY2ops1X/y4fIcLB/GSJQXHVQwbzF
	P54mAWcUkZgwkDvYI+Dl6Mch+N7vw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461nwq13dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FDhb9s030906;
	Tue, 15 Apr 2025 14:24:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnkjdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOdlT56492322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81F3F20040;
	Tue, 15 Apr 2025 14:24:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 206862004D;
	Tue, 15 Apr 2025 14:24:39 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:39 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Date: Tue, 15 Apr 2025 16:24:13 +0200
Message-ID: <20250415142438.118474-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PhF62SCTcfBGtYrWaAlD4g7BUJQ9R3tv
X-Proofpoint-GUID: PhF62SCTcfBGtYrWaAlD4g7BUJQ9R3tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

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
  Add a new parameter xflags to the in-kernel API function
    pkey_key2protkey(). Currently there is only one flag supported:

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
 drivers/s390/crypto/pkey_uv.c          |  43 ++-
 drivers/s390/crypto/zcrypt_api.c       | 164 ++++++---
 drivers/s390/crypto/zcrypt_api.h       |  16 +-
 drivers/s390/crypto/zcrypt_ccamisc.c   | 489 +++++++++----------------
 drivers/s390/crypto/zcrypt_ccamisc.h   |  49 +--
 drivers/s390/crypto/zcrypt_cex4.c      |  39 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  | 457 +++++++++++------------
 drivers/s390/crypto/zcrypt_ep11misc.h  |  27 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  36 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 109 +++---
 23 files changed, 968 insertions(+), 1023 deletions(-)


base-commit: bffb31040cb61aa72de8ffac655fe1459d581505
--
2.43.0


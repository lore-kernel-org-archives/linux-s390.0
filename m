Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B525DCF4
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207396; cv=none; b=Fwk7f1FW4lNtVDGyRA7yxr1NJ51IxFmd2946EcyhTPJUXgCstyrTvACrRU3R0XfcuKptLLIehYKy9uqL966UcvV/bikrcQPlntsVdG1oudPCr8U7SPwBimjapfb4RuqurPhdBCV60imYuOBVR1xgfLxppyb76qce++sS39DEH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207396; c=relaxed/simple;
	bh=7r1Eal9lR5BtUUlWvsSmbVQ9bX2D4IhrBI9md4gn38g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0+7OTvBncJza5cudYN22mliaGGT9/Bb6bu+v9IdwGgMTXRgtXG7cZvw1QlMETVZhHJ9zMiMLgSPtO2lG7AoUzGc2DlwHqitbh6O6a8h/E441kVIKtKT3nBNqP1CYexNma5OZSwj4EocmzKTUdKHDLhVm791/5XJCnFaKXIt+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JoVgv83m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JoVgv83m"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399LKjK028280;
	Wed, 9 Apr 2025 14:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n4hVYojIGir5SSuUdUxuVxgSlWcFlEvsSfKm96nFs
	MM=; b=JoVgv83m0s0g62JnqhDOYifzaScg1+c8pEHBxw7JjBd1IMC5LEbj63oMm
	bAqC2YA1py3V1eH/T/aY97ftTcM2dA+Vtkjc8w+e/T1FIXsLe9SQ8fHK3u9KtaQs
	l5sg3bSwXla57DIGAWuNOL8U4ud73OKGpvSvPMXn4XNaoZneCfH2/QdAhtooPbwG
	OENNhgAblzrEvqn4iKv+Iy2DlK5nayATUT6cHCG6CzZWhpnah3pftSw5LU1++Z8P
	9Avwmuy1T2IKCx9jgmVTI1RtWWaBccq42pCcCSQXccmyNQ/ItJ8v9KBMsgFP6b3Q
	gAy6OGnCHS+Abn2qV4Xaj0SDC8YKw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10m0cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539DRFLw013915;
	Wed, 9 Apr 2025 14:03:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunr03f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E36hj52625692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA71020043;
	Wed,  9 Apr 2025 14:03:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51C1920040;
	Wed,  9 Apr 2025 14:03:06 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 00/24] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Date: Wed,  9 Apr 2025 16:02:41 +0200
Message-ID: <20250409140305.58900-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ilPNVm8UGhMxJS7tdv93GszGZ51W0tQV
X-Proofpoint-GUID: ilPNVm8UGhMxJS7tdv93GszGZ51W0tQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

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

Harald Freudenberger (24):
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
  s390/zcrypt/pkey: Rework cca findcard() implementation and callers
  s390/zcrypt/pkey: Rework ep11 findcard() implementation and callers
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
  s390/zcrypt/pkey: Provide and pass xflags within pkey and zcrypt
    layers
  s390/pkey/crypto: Introduce xflags param for pkey in-kernel API

 arch/s390/crypto/paes_s390.c           |   6 +-
 arch/s390/include/asm/pkey.h           |  15 +-
 arch/s390/include/asm/uv.h             |   3 +
 arch/s390/kernel/uv.c                  |  12 +-
 drivers/s390/crypto/ap_bus.c           |  74 ++++
 drivers/s390/crypto/ap_bus.h           |  30 +-
 drivers/s390/crypto/pkey_api.c         |  54 +--
 drivers/s390/crypto/pkey_base.c        |  34 +-
 drivers/s390/crypto/pkey_base.h        |  37 +-
 drivers/s390/crypto/pkey_cca.c         | 121 +++---
 drivers/s390/crypto/pkey_ep11.c        | 106 +++---
 drivers/s390/crypto/pkey_pckmo.c       |   9 +-
 drivers/s390/crypto/pkey_sysfs.c       |   4 +-
 drivers/s390/crypto/pkey_uv.c          |  43 ++-
 drivers/s390/crypto/zcrypt_api.c       | 161 +++++---
 drivers/s390/crypto/zcrypt_api.h       |  16 +-
 drivers/s390/crypto/zcrypt_ccamisc.c   | 485 +++++++++----------------
 drivers/s390/crypto/zcrypt_ccamisc.h   |  49 +--
 drivers/s390/crypto/zcrypt_cex4.c      |  39 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  | 458 +++++++++++------------
 drivers/s390/crypto/zcrypt_ep11misc.h  |  27 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  36 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 109 +++---
 23 files changed, 940 insertions(+), 988 deletions(-)

--
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2621FCF5F
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304509; cv=none; b=ZvA/+ZV6AxWRxb9HYbbAD1/q4wB33/Gmu3HOmhDzXyOAfXkZsQJQyWRKJi5x61+8BWZRWtHTtLK5poaI3mK4QLeUAUag4DsP/GVjD4BG+lb6BLZ9d6o9Llm4wnWbEK3Ty1Agztme5ajdnGyw87yegaVBwBHOjHQTV6g45a2DytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304509; c=relaxed/simple;
	bh=N1ZC/6rgsYB0kKn2nEtSwAsxV92XIsQNwXhQTfMx01g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ7led8PuuPizfiVAb/vHX1sf2fsV+UrfvAf1MRJsVl3MaNxJ/9LDltoB1O470QYgOUhJlWCQjUdsOGGJntav1xuSAJ4PVydPyR1PdkImw5RYZi0XDw8qLwn4JSza6sqhVd9TCtIN/JHGeQlfInVugkgMRpLLKvfz2vKcv6YRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I3wy0fYC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I3wy0fYC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N7WvuW026606;
	Sun, 23 Feb 2025 09:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IfYKnZv/MjzhX1mlNMGCfNaTVGt4c61p3d4WEK0DG
	mc=; b=I3wy0fYC04794pgUUEE22TFMDOxR+ivGdmWYNCgNu1QYnp2DW72k+RHlE
	LgtO0oEKV9LBSerjq/Yz/lf6I0ly7QpcshzFiCR2tzWKtxO7kuDYRd1iL7QBBKYj
	idv9jlX1Idr/zGQdOgjXd6qY3/+z0MA9n/eA7Rx7bxReJCaY/gU6B/WGFk/16leD
	/t/fgXVAFOnrofqEYVyd8KC6qGw7NNOsYzSpw8byWB2kBmJEmLzfAURP3hn3tfe1
	rEY3VeoaWgkiY6lUNoRivOIxGe6mTi6g0g1tEf+9kYaQh8oHdZeGCgV4+uJPQyJg
	XVWZIqwSjIfLmk8rN4boY/qu+BCiQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yycnrbuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N7aeMG027337;
	Sun, 23 Feb 2025 09:55:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1hapx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t0BF35259060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B9E520049;
	Sun, 23 Feb 2025 09:55:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0018E20040;
	Sun, 23 Feb 2025 09:54:59 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:54:59 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 00/20] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Date: Sun, 23 Feb 2025 10:54:39 +0100
Message-ID: <20250223095459.43058-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -2zsezAWXlk7wOnTXGuM5oUtkHipDdv1
X-Proofpoint-ORIG-GUID: -2zsezAWXlk7wOnTXGuM5oUtkHipDdv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

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

Harald Freudenberger (20):
  s390/ap: Move response_type struct into ap_msg struct
  s390/ap/zcrypt: Rework AP message buffer allocation
  s390/ap: Introduce ap message buffer pool
  s390/zcrypt: Rework zcrypt layer to support new flag NOMEMALLOC
  s390/zcrypt: Introduce cprb mempool for cca misc functions
  s390/zcrypt: Introduce cprb mempool for ep11 misc functions
  s390/zcrypt: New zcrypt function zcrypt_device_status_mask_ext2
  s390/zcrypt: Introduce pre-allocated device status array for cca misc
  s390/zcrypt: Introduce pre-allocated device status array for ep11 misc
  s390/zcrypt/pkey: Rework cca findcard() implementation and callers
  s390/zcrypt/pkey: Rework ep11 findcard() implementation and callers
  s390/zcrypt: Rework cca misc functions kmallocs to use the cprb
    mempool
  s390/zcrypt: Add small mempool for cca info list entries
  s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of
    kmalloc
  s390/zcrypt: Rework ep11 misc functions to use cprb mempool
  s390/zcrypt: Add small mempool for ep11 card info list entries
  s390/pkey: Rework CCA pkey handler to use stack for small memory
    allocs
  s390/pkey: Rework EP11 pkey handler to use stack for small memory
    allocs
  s390/zcrypt/pkey: Provide and pass xflags within pkey and zcrypt
    layers
  s390/pkey/crypto: Introduce xflags param for pkey in-kernel API

 arch/s390/crypto/paes_s390.c           |   2 +-
 arch/s390/include/asm/pkey.h           |  13 +-
 drivers/s390/crypto/ap_bus.c           |  71 +++++
 drivers/s390/crypto/ap_bus.h           |  34 +--
 drivers/s390/crypto/pkey_api.c         |  50 ++--
 drivers/s390/crypto/pkey_base.c        |  34 ++-
 drivers/s390/crypto/pkey_base.h        |  37 ++-
 drivers/s390/crypto/pkey_cca.c         | 121 ++++----
 drivers/s390/crypto/pkey_ep11.c        | 106 +++----
 drivers/s390/crypto/pkey_pckmo.c       |   9 +-
 drivers/s390/crypto/pkey_sysfs.c       |   4 +-
 drivers/s390/crypto/pkey_uv.c          |  16 +-
 drivers/s390/crypto/zcrypt_api.c       | 151 +++++++---
 drivers/s390/crypto/zcrypt_api.h       |  18 +-
 drivers/s390/crypto/zcrypt_ccamisc.c   | 343 +++++++++++++++-------
 drivers/s390/crypto/zcrypt_ccamisc.h   |  41 +--
 drivers/s390/crypto/zcrypt_cex4.c      |  16 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  | 385 ++++++++++++++++---------
 drivers/s390/crypto/zcrypt_ep11misc.h  |  28 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  36 ++-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 119 ++++----
 21 files changed, 988 insertions(+), 646 deletions(-)

-- 
2.43.0


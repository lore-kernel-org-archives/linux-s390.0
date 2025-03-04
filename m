Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFD283CAF
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108886; cv=none; b=ntALn2Bx0ABtzlvJ5lCNomfwXinYpyez/CkpS7vNC5lNM47fPresVl4bxD5MSdfrSTJ0xYWxCRV7UWuA5lOLmimzzJKXahJM1ZQtzFJT3GP9+3R0edzvgToS/Klrf7U7KdSDHCziyp1eaSNgEMrX4WJf/ywSmThMSryebmUcUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108886; c=relaxed/simple;
	bh=UVeWl3tUjJp3gcde9t2BA84PFjIsktftwUcbybqe7KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQgZutno7VBqMzPSHcj7qg77V9NrnuauanXEja25ARHyT4iNZGzNSeAgCTMfu9PoQjCFNcaHNbMExicKGoK/9ituyZjzK63gL2WVhIlkJu1vsg/rZNmbxJBSuwhk3db2+84PvpNLNfKwaah+AhHWioJNiwvTWqLwWDweCdFeyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FfssWd2o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FfssWd2o"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524CSboM007621;
	Tue, 4 Mar 2025 17:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XdULB0FkkYJpDKMEmupdMxDPd5UyGG5lu9JRQBhmS
	N0=; b=FfssWd2olb+wOT0O+Avl+5u031W4YBgqqAThUvrlZBZL8IN1FhTo06Dje
	GTWvJj9hMqDs3ySwmKceSpgZ3sASsZM4ugtGDIHWAyZ4CVSoWbt00b8tJWgUU1hI
	huHjZ8z4cmvZBj9gl2xmvdG/eHZfumbPpn7AQMOH2rvqkmtvd/SLpIpvpZOwa8k6
	274J8c71MCFSpNiePF9RjsIz5T/Hdb6+GKRIhctJSvxElyqWBlzZpVM2a7buDqAO
	+wc3lT0YVEdqDOb/DH6RFqAx9e5LEA2VEF5CKjdsJbr8n+Dmihf6X94KJ6aEuW60
	dXqtAFD+RfEIWROCBcwt3hq/H58TQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j31fhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Gf6QU020788;
	Tue, 4 Mar 2025 17:21:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjx78m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLH6u35521276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D3DA20043;
	Tue,  4 Mar 2025 17:21:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F2F420040;
	Tue,  4 Mar 2025 17:21:17 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 00/20] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Date: Tue,  4 Mar 2025 18:20:56 +0100
Message-ID: <20250304172116.85374-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xZzRUfGYk8Lhy4MMegmLa7M-Qn7d3xBB
X-Proofpoint-ORIG-GUID: xZzRUfGYk8Lhy4MMegmLa7M-Qn7d3xBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

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

Harald Freudenberger (20):
  s390/ap: Move response_type struct into ap_msg struct
  s390/ap/zcrypt: Rework AP message buffer allocation
  s390/ap: Introduce ap message buffer pool
  s390/ap/zcrypt: New xflag parameter and extension of the ap msg flags
  s390/zcrypt: Introduce cprb mempool for cca misc functions
  s390/zcrypt: Introduce cprb mempool for ep11 misc functions
  s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
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
 arch/s390/include/asm/pkey.h           |  15 +-
 drivers/s390/crypto/ap_bus.c           |  73 +++++
 drivers/s390/crypto/ap_bus.h           |  37 +--
 drivers/s390/crypto/pkey_api.c         |  54 ++--
 drivers/s390/crypto/pkey_base.c        |  34 ++-
 drivers/s390/crypto/pkey_base.h        |  37 ++-
 drivers/s390/crypto/pkey_cca.c         | 121 ++++----
 drivers/s390/crypto/pkey_ep11.c        | 106 +++----
 drivers/s390/crypto/pkey_pckmo.c       |   9 +-
 drivers/s390/crypto/pkey_sysfs.c       |   4 +-
 drivers/s390/crypto/pkey_uv.c          |  16 +-
 drivers/s390/crypto/zcrypt_api.c       | 172 +++++++----
 drivers/s390/crypto/zcrypt_api.h       |  42 ++-
 drivers/s390/crypto/zcrypt_ccamisc.c   | 350 +++++++++++++++-------
 drivers/s390/crypto/zcrypt_ccamisc.h   |  41 +--
 drivers/s390/crypto/zcrypt_cex4.c      |  16 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  | 387 ++++++++++++++++---------
 drivers/s390/crypto/zcrypt_ep11misc.h  |  28 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  36 ++-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 121 ++++----
 drivers/s390/crypto/zcrypt_msgtype6.h  |   4 +-
 22 files changed, 1032 insertions(+), 673 deletions(-)

--
2.43.0


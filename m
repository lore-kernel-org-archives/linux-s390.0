Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32A17996
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213804; cv=none; b=BU9BvAxa0Nzn0lUcCpbDsn1JH3eJwY4vCoKnppT0dmkmEW8Q5YpQjP+LdJOPxHFaab0NXvzKRdQM/JeKiwZXcs/hf0GfGovqNdc+tBziVV/6USEqebyZuXx5TFc4vB2LsinN+f+ptmFgH4yBleA/QrAM6J2w4dFfDNCLCnqCXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213804; c=relaxed/simple;
	bh=+Jy7hQooFdLAXnEB2zYRHPbQZg9o5vPSGbMZnhpOL68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8FLq2FpeCmIusF4AaUeddey5TlYbfbvdseV7qWM4+oY25CNRpC4fddAEpsA7untr063iF9Wohlk74EMexUAxr7VECMRAihVwyWN2mlwH1YZPoGpjwmrQHFJZCB6tjkN3klMduqcE/F52+uCSwpvY+zF/9jzCfbWMgjVADdmGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ACY0GOAc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ACY0GOAc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E5EK79024771
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OXqTm9INAbkICpFH8IZrCDqHqiKT7nd3tUvztmmj7
	g0=; b=ACY0GOAcMK/bH5kDETz6Z60sGPheIsr/DmNnivrFi1gyBT35URc77gnTh
	Tw285HisPBs7oHrN2iGhy5o3r3/aO0aiSrXPWMB00bClsnD2hQly42raAfJlv0tK
	APDL/ZZeEBSMfnYfDEWylpP0O8jJ1Kyb7HIftTAfV8XtS/+1oRMLhHvHBZ1cu0hu
	BnMLw0K+cmAdeGDB3hSCXC23mo2ItP1MFjYboLtIoOfQ3wudn2EdBCvyuBwz7QRu
	w0SOjhyBbVRbjr8U46HednZ1q/iSqpxHmbywMoxLnBj7JWcLckOQp4W5aw2zxhdQ
	NTAEMz690lbTedoCJCE2Y2J+7+tLA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6k5vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E6GV3q015329
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpubfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 09:10:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54E99uEd44695940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:09:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB2CE2008E;
	Wed, 14 May 2025 09:09:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BBF02007A;
	Wed, 14 May 2025 09:09:56 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.111.35.98])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 09:09:56 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v5 0/2] Rework protected key AES for true asynch support
Date: Wed, 14 May 2025 11:09:53 +0200
Message-ID: <20250514090955.72370-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA3OSBTYWx0ZWRfXzmkhbFvozxRX aJRcfMaNjNZpGqgyja8pXpuM5jhsCfwa5ScH2iCta49eX64PmXmAGW/DwZYxhPfKInOz9DhK7gc N2cuaKm+G/h1oA0TsbgZgScJL08JJGpoBNxe51FtGEOd5T7sKpIBkD5be/glHWPRgY+AQd+KWTd
 k7+iY+CihvSlyE9HS/e8G+u4KDY7VSJb9jvN2kUJb2aQOYzMyPud+bhdQOActsvT2PaqtEjPMZx DIRlsU2B9WsczZkWSZ74Eecum4LjtWQpxMu8fiPJ5HHfcw+iZCh/UMvOIwNAOt43IO6ZW+RbJd1 GVS/XZ6c0xJXX7nfKwz0zjnArEI3/MHIOG3anAbKPaNlpjR4sRFQ8SxJ1D2dkTvnl/EkGp4QD+k
 WiRLKhSVysM932M7DU4LxkEldHol0iW12HKX2+M+DBGyo0eRwlm/DDCkmll92DvLoRO8SM4W
X-Proofpoint-ORIG-GUID: xeUBV-XuyX8d0u8sH3ZrZ_n5dhghKl56
X-Authority-Analysis: v=2.4 cv=d5f1yQjE c=1 sm=1 tr=0 ts=68245de9 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=umTLqrzy8u1HU5sndx8A:9
X-Proofpoint-GUID: xeUBV-XuyX8d0u8sH3ZrZ_n5dhghKl56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140079

This is a complete rework of the protected key AES (PAES) implementation.
The goal of this rework is to implement the 4 modes (ecb, cbc, ctr, xts)
in a real asynchronous fashion:

- init(), exit() and setkey() are synchronous and don't allocate any memory.
- the encrypt/decrypt functions first try to do the job in a synchronous
  manner. If this fails, for example the protected key got invalid caused
  by a guest suspend/resume or guest migration action, the encrypt/decrypt
  is transferred to an instance of the crypto engine (see below) for
  asynchronous processing.
  These postponed requests are then handled by the crypto engine by
  invoking the do_one_request() callback but may of course again run into
  a still not converted key or the key is getting invalid. If the key is
  still not converted, the first thread does the conversion and updates
  the key status in the transformation context. The conversion is
  invoked via pkey API with a new flag PKEY_XFLAG_NOMEMALLOC.
  Note that once there is an active requests enqueued to get async
  processed via crypto engine, further requests also need to go via
  crypto engine to keep the request sequence.

This patch together with the pkey/zcrypt/AP extensions to support
the new PKEY_XFLAG_NOMEMMALOC should toughen the paes crypto algorithms
to truly meet the requirements for in-kernel skcipher implementations
and the usage patterns for the dm-crypt and dm-integrity layers.
The new flag PKEY_XFLAG_NOMEMALLOC tells the PKEY layer (and
subsidiary layers) that it must not allocate any memory causing IO
operations. Note that the patches for this pkey/zcrypt/AP extensions
are currently in the features branch but may be seen in the master
branch with the next merge.

There is still some confusion about the way how paes treats the key
within the transformation context. The tfm context may be shared by
multiple requests running en/decryption with the same key. So the tfm
context is supposed to be read-only.
The s390 protected key support is in fact an encrypted key with the
wrapping key sitting in the firmware. On each invocation of a
protected key instruction the firmware unwraps the pkey and performs
the operation. Part of the protected key is a hash about the wrapping
key used - so the firmware is able to detect if a protected key
matches to the wrapping key or not. If there is a mismatch the cpacf
operation fails with cc 1 (key invalid). Such a situation can occur
for example with a kvm live guest migration to another machine where
the guest simple awakens in a new environment. As the wrapping key is
NOT transfered, after the reawakening all protected key cpacf
operations fail with "key invalid". There exist other situations
where a protected key cpacf operation may run into "key invalid" and
thus the code needs to be prepared for such cpacf failures.
The recovery is simple: via pkey API the source key material (in real
cases this is usually a secure key bound to a HSM) needs to generate
a new protected key which is the wrapped by the wrapping key of the
current firmware.
So the paes tfms hold the source key material to be able to
re-generate the protected key at any time. A naive implementation
would hold the protected key in some kind of running context (for
example the request context) and only the source key would be stored
in the tfm context. But the derivation of the protected key from the
source key is an expensive and time consuming process often involving
interaction with a crypto card. And such a naive implementation would
then for every tfm in use trigger the derivation process individual.
So why not store the protected key in tfm context and only the very
first process hitting the "invalid key" cc runs the derivation and
updates the protected key stored in the tfm. The only really important
thing is that the protected key update and cloning from this value
needs to be done in a atomic fashion.
Please note that there are still race conditions where the protected
key stored in the tfm may get updated by an (outdated) protected key
value. This is not an issue and the code handles this correctly by
again re-deriving the protected key. The only fact that matters, is
that the protected key must always be in a state where the cpacf
instructions can figure out if it is valid (the hash part of the
protected key matches to the hash of the wrapping key) or invalid
(and refuse the crypto operation with "invalid key").

Changelog:
v1 - first version. Applied and tested on top of the mentioned
     pkey/zcrypt/AP changes. Selftests and multithreaded testcases
     executed via AP_ALG interface run successful and even instrumented
     code (with some sleeps to force asynch pathes) ran fine.
     Code is good enough for a first code review and collecting feedback.
v2 - A new patch which does a slight rework of the cpacf_pcc() inline
     function to return the condition code.
     A rework of the paes implementation based on feedback from Herbert
     and Ingo:
     - the spinlock is now consequently used to protect updates and
       changes on the protected key and protected key state within
       the transformation context.
     - setkey() is now synchronous
     - the walk is now held in the request context and thus the
       postponing of a request to the engine and later processing
       can continue at exactly the same state.
     - the param block needed for the cpacf instructions is constructed
       once and held in the request context.
     - if a request can't get handled synchronous, it is postponed
       for asynch processing via an instance of the crpyto engine.
     With v2 comes a patch which updates the crypto engine docu
     in Documentation/crypto. Feel free to use it or drop it or
     do some rework - at least it needs some review.
     v2 was only posted internal to collect some feedback within IBM.
v3 - Slight improvements based on feedback from Finn.
v4 - With feedback from Holger and Herbert Xu. Holger gave some good
     hints about better readability of the code and I picked nearly
     all his suggestions. Herbert noted that once a request goes via
     engine to keep the sequence as long as there are requests
     enqueued the following requests should also go via engine. This
     is now realized via a via_engine_ctr atomic counter in the tfm
     context.
     Stress tested with lots of debug code to run through all the
     failure paths of the code. Looks good.
v5 - Fixed two typos and 1 too long line in the commit message found
     by Holger. Added Acked-by and Reviewed-by.
     Removed patch #3 which updates the crypto engine docu - this
     will go separate. All prepared for picking in the s390 subsystem.

Harald Freudenberger (2):
  s390/cpacf: Rework cpacf_pcc() to return condition code
  s390/crypto: Rework protected key AES for true asynch support

 arch/s390/crypto/paes_s390.c  | 1812 +++++++++++++++++++++++----------
 arch/s390/include/asm/cpacf.h |   18 +-
 2 files changed, 1285 insertions(+), 545 deletions(-)


base-commit: 3919600d32b92e67f1d28376bd63152306e99452
--
2.43.0

